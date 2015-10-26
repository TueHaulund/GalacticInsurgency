#include "GameState.hpp"

GameState::GameState(const std::string &p_lua_path, sf::RenderWindow &p_window, bool p_libs) : m_lua_state(p_libs), m_lua_script(p_lua_path, LoadScript), m_window(p_window)
{
    //Run main Lua script in our newly created state
    m_lua_state(m_lua_script.Get().c_str());

    //Populate key map, mapping strings to SFML keys
    m_key_map = {
        {"up",    sf::Keyboard::Up},
        {"down",  sf::Keyboard::Down},
        {"left",  sf::Keyboard::Left},
        {"right", sf::Keyboard::Right}
    };

    //Inject key-polling function into Lua state
    m_lua_state["interface"]["is_key_pressed"] = [&](const std::string &p_key) -> bool
    {
        if(m_key_map.find(p_key) != m_key_map.end())
            return sf::Keyboard::isKeyPressed(m_key_map.at(p_key));
        else
            return false;
    };

    //Populate event map, mapping SFML events to strings
    m_event_map = {
        {sf::Event::Closed,       "closed"},
        {sf::Event::LostFocus,    "lost_focus"},
        {sf::Event::GainedFocus,  "gained_focus"},
        {sf::Event::MouseLeft,    "mouse_left"},
        {sf::Event::MouseEntered, "mouse_entered"}
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
        if(m_event_map.find(event.type) != m_event_map.end())
            m_lua_state["interface"]["handle_event"](m_event_map.at(event.type));
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
