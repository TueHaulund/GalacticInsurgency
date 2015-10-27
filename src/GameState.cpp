#include "GameState.hpp"

GameState::GameState(const std::string &p_lua_path, sf::RenderWindow &p_window, bool p_libs) : 
    m_lua_state(p_libs),
    m_lua_script(p_lua_path, LoadScript),
    m_window(p_window)
{
    //Run main Lua script in our newly created state
    m_lua_state(m_lua_script.Get().c_str());

    //Populate key maps and event map
    BuildKeymap();
    BuildEventmap();

    auto lua_interface = m_lua_state["interface"];

    //Inject key-polling function into Lua state
    lua_interface["is_key_pressed"] = [this] (const std::string &p_key) -> bool
    {
        if(m_keymap.find(p_key) != m_keymap.end())
            return sf::Keyboard::isKeyPressed(m_keymap.at(p_key));
        else
            return false;
    };

    //Inject exit function into Lua state
    lua_interface["exit"] = [this] () -> void
    {
        //Closing the window terminates the main game loop
        m_window.close();
        return;
    };

    m_audiostate(m_lua_state);

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

void GameState::BuildKeymap()
{
    m_keymap = {
        {"up", sf::Keyboard::Up},
        {"down", sf::Keyboard::Down},
        {"left", sf::Keyboard::Left},
        {"right", sf::Keyboard::Right}
    };

    //Build reverse table for efficient reverse lookup
    for(auto &pair : m_keymap)
        m_keymap_rev[pair.second] = pair.first;

    return;
}

void GameState::BuildEventmap()
{
    auto lua_handle_event = m_lua_state["interface"]["handle_event"];

    m_eventmap[sf::Event::Closed] = [lua_handle_event] (const sf::Event &e) -> void
    {
        lua_handle_event("closed");
        return;
    };

    m_eventmap[sf::Event::Resized] = [lua_handle_event] (const sf::Event &e) -> void
    {
        lua_handle_event("resized", e.size.width, e.size.height);
        return;
    };

    m_eventmap[sf::Event::LostFocus] = [lua_handle_event] (const sf::Event &e) -> void
    {
        lua_handle_event("lost_focus");
        return;
    };

    m_eventmap[sf::Event::GainedFocus] = [lua_handle_event] (const sf::Event &e) -> void
    {
        lua_handle_event("gained_focus");
        return;
    };

    m_eventmap[sf::Event::KeyPressed] = [this, lua_handle_event] (const sf::Event &e) -> void
    {
        sf::Keyboard::Key k = e.key.code;
        if(m_keymap_rev.find(k) != m_keymap_rev.end())
            lua_handle_event("key_pressed", m_keymap_rev.at(k));
        return;
    };

    m_eventmap[sf::Event::KeyReleased] = [this, lua_handle_event] (const sf::Event &e) -> void
    {
        sf::Keyboard::Key k = e.key.code;
        if(m_keymap_rev.find(k) != m_keymap_rev.end())
            lua_handle_event("key_released", m_keymap_rev.at(k));
        return;
    };
    
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
