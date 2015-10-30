#include "AudioState.hpp"

void AudioState::operator()(sel::State &p_lua_state)
{
    SoundInterface(p_lua_state);
    MusicInterface(p_lua_state);
    return;
}

void AudioState::SoundInterface(sel::State &p_lua_state)
{
    auto lua_interface = p_lua_state["interface"];
    auto map_contains = [this] (const std::string &p_identifier) -> bool
    {
        return m_soundmap.find(p_identifier) != m_soundmap.end();
    };

    lua_interface["loadSound"] = [this, map_contains] (const std::string &p_identifier, const std::string &p_path) -> void
    {
        Resource<sf::SoundBuffer> buffer(p_path, LoadSound);

        if(map_contains(p_identifier))
            m_soundmap.at(p_identifier)->setBuffer(buffer.Get());
        else
            m_soundmap[p_identifier] = std::make_unique<sf::Sound>(buffer.Get());

        return;
    };

    lua_interface["clearSound"] = [this] (const std::string &p_identifier) -> void
    {
        m_soundmap.erase(p_identifier);
        return;
    };

    lua_interface["playSound"] = [this, map_contains] (const std::string &p_identifier) -> void
    { 
        if(map_contains(p_identifier))
            m_soundmap.at(p_identifier)->play();

        return;
    };

    lua_interface["pauseSound"] = [this, map_contains] (const std::string &p_identifier) -> void
    {
        if(map_contains(p_identifier))
            m_soundmap.at(p_identifier)->pause();

        return;
    };

    lua_interface["stopSound"] = [this, map_contains] (const std::string &p_identifier) -> void
    {
        if(map_contains(p_identifier))
            m_soundmap.at(p_identifier)->stop();

        return;
    };

    lua_interface["setSoundVolume"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_volume) -> void
    {
        if(map_contains(p_identifier))
            m_soundmap.at(p_identifier)->setVolume(static_cast<float>(p_volume));

        return;
    };

    lua_interface["setSoundLoop"] = [this, map_contains] (const std::string &p_identifier, bool p_loop) -> void
    {
        if(map_contains(p_identifier))
            m_soundmap.at(p_identifier)->setLoop(p_loop);

        return;
    };

    return;
}

void AudioState::MusicInterface(sel::State &p_lua_state)
{
    auto lua_interface = p_lua_state["interface"];
    auto map_contains = [this] (const std::string &p_identifier) -> bool
    {
        return m_musicmap.find(p_identifier) != m_musicmap.end();
    };

    lua_interface["loadMusic"] = [this] (const std::string &p_identifier, const std::string &p_path) -> void
    {
        m_musicmap[p_identifier] = std::make_unique<sf::Music>();
        if(!m_musicmap[p_identifier]->openFromFile(p_path))
            throw std::runtime_error("Unable to load music: " + p_path);

        return;
    };

    lua_interface["clearMusic"] = [this] (const std::string &p_identifier) -> void
    {
        m_musicmap.erase(p_identifier);
        return;
    };

    lua_interface["playMusic"] = [this, map_contains] (const std::string &p_identifier) -> void
    { 
        if(map_contains(p_identifier))
            m_musicmap.at(p_identifier)->play();

        return;
    };

    lua_interface["pauseMusic"] = [this, map_contains] (const std::string &p_identifier) -> void
    {
        if(map_contains(p_identifier))
            m_musicmap.at(p_identifier)->pause();

        return;
    };

    lua_interface["stopMusic"] = [this, map_contains] (const std::string &p_identifier) -> void
    {
        if(map_contains(p_identifier))
            m_musicmap.at(p_identifier)->stop();

        return;
    };

    lua_interface["setMusicVolume"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_volume) -> void
    {
	    if(map_contains(p_identifier))
            m_musicmap.at(p_identifier)->setVolume(static_cast<float>(p_volume));

        return;
    };

    lua_interface["setMusicLoop"] = [this, map_contains] (const std::string &p_identifier, bool p_loop) -> void
    {
        if(map_contains(p_identifier))
            m_musicmap.at(p_identifier)->setLoop(p_loop);

        return;
    };

    return;
}

//Loads audio file into an sf::SoundBuffer
std::unique_ptr<sf::SoundBuffer> AudioState::LoadSound(const std::string &p_path)
{
    auto sound = std::make_unique<sf::SoundBuffer>();

    if(!sound->loadFromFile(p_path))
        throw std::runtime_error("Unable to load sound: " + p_path);

    return sound;
}
