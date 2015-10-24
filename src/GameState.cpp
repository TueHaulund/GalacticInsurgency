#include "GameState.hpp"

GameState::GameState(const std::string &p_lua_path, bool p_libs) : m_lua_state(p_libs)
{
    Resource<std::string> lua_script(p_lua_path, LoadScript);
    m_lua_state(lua_script.Get().c_str());

    return;
}

void GameState::Update(float p_dt)
{
    m_lua_state["update"](p_dt);
    return;
}

void GameState::Draw()
{
    m_lua_state["draw"]();
    return;
}

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
