#include "GameState.hpp"

GameState::GameState(const std::string &p_lua_path, sf::RenderWindow &p_window, bool p_libs) : m_lua_state(p_libs), m_lua_script(p_lua_path, LoadScript), m_window(p_window)
{
    //Run main Lua script in our newly created state
    m_lua_state(m_lua_script.Get().c_str());

    //Populate key map, mapping strings to SFML keys and vice-versa
    m_keymap =
    {
        {"up",    sf::Keyboard::Up},
        {"down",  sf::Keyboard::Down},
        {"left",  sf::Keyboard::Left},
        {"right", sf::Keyboard::Right}
    };

    for(auto &pair : m_keymap)
        m_keymap_rev[pair.second] = pair.first;

    //Populate event map, mapping event types to Lua forwarding lambdas
    auto lhe = m_lua_state["interface"]["handle_event"];
    auto contains = [this] (sf::Keyboard::Key c) {return m_keymap_rev.find(c) != m_keymap_rev.end();};
    typedef const sf::Event& Evt;

    m_eventmap =
    {
        {sf::Event::Closed,      [=] (Evt e) {lhe("closed");}},
        {sf::Event::Resized,     [=] (Evt e) {lhe("resized", e.size.width, e.size.height);}},
        {sf::Event::LostFocus,   [=] (Evt e) {lhe("lost_focus");}},
        {sf::Event::GainedFocus, [=] (Evt e) {lhe("gained_focus");}},
        {sf::Event::KeyPressed,  [=] (Evt e) {if(contains(e.key.code)) lhe("key_pressed", m_keymap_rev.at(e.key.code));}},
        {sf::Event::KeyReleased, [=] (Evt e) {if(contains(e.key.code)) lhe("key_released", m_keymap_rev.at(e.key.code));}}
    };

    //Inject key-polling function into Lua state
    m_lua_state["interface"]["is_key_pressed"] = [&](const std::string &p_key) -> bool
    {
        if(m_keymap.find(p_key) != m_keymap.end())
            return sf::Keyboard::isKeyPressed(m_keymap.at(p_key));
        else
            return false;
    };

    //Inject exit function into Lua state
    m_lua_state["interface"]["exit"] = [&]() -> void
    {
        //Closing the window terminates the main game loop
        m_window.close();
    };

    return;
}

void GameState::Update(float p_dt)
{
    //Update game state in Lua
    m_lua_state["interface"]["update"](p_dt);
    
    //Pass events to Lua handler
    sf::Event event;
    while(m_window.pollEvent(event))
    {
        if(m_eventmap.find(event.type) != m_eventmap.end())
            m_eventmap.at(event.type)(event);
    }

    return;
}

void GameState::Draw()
{
    m_lua_state["interface"]["draw"]();
    return;
}

//Loads a script from a file into a std::string
std::unique_ptr<std::string> GameState::LoadScript(const std::string &p_path)
{
    auto script = std::make_unique<std::string>();
    std::ifstream file(p_path);

    if(!file)
        throw std::runtime_error("Unable to load script: " + p_path);

    std::stringstream buffer;
    buffer << file.rdbuf();
    *script = buffer.str();

    return script;
}
