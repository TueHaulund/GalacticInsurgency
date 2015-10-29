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
    auto map_apply = [this] (const std::string &p_identifier, std::function<void(sf::Sound&)> p_func) -> bool
    {
        if(m_soundmap.find(p_identifier) != m_soundmap.end())
        {
            p_func(*m_soundmap.at(p_identifier));
            return true;
        }
        
        return false;
    };

    lua_interface["load_sound"] = [this, map_apply] (const std::string &p_identifier, const std::string &p_path) -> void
    {
        Resource<sf::SoundBuffer> buffer(p_path, LoadSound);

        bool reload = map_apply(p_identifier, [buffer] (sf::Sound &s) -> void
        {
            s.setBuffer(buffer.Get());
            return;
        });

        if(!reload)
            m_soundmap[p_identifier] = std::make_unique<sf::Sound>(buffer.Get());

        return;
    };

    lua_interface["clear_sound"] = [this] (const std::string &p_identifier) -> void
    {
        m_soundmap.erase(p_identifier);
        return;
    };

    lua_interface["play_sound"] = [map_apply] (const std::string &p_identifier) -> void
    { 
        map_apply(p_identifier, [] (sf::Sound &s) -> void
        {
            s.play();
            return;
        });
        return;
    };

    lua_interface["pause_sound"] = [map_apply] (const std::string &p_identifier) -> void
    {
        map_apply(p_identifier, [] (sf::Sound &s) -> void
        {
            s.pause();
            return;
        });
        return;
    };

    lua_interface["stop_sound"] = [map_apply] (const std::string &p_identifier) -> void
    {
        map_apply(p_identifier, [] (sf::Sound &s) -> void
        {
            s.stop();
            return;
        });
        return;
    };

    lua_interface["set_sound_volume"] = [map_apply] (const std::string &p_identifier, int p_volume) -> void
    {
        map_apply(p_identifier, [p_volume] (sf::Sound &s) -> void
        {
            s.setVolume(static_cast<float>(p_volume));
            return;
        });
        return;
    };

    lua_interface["set_sound_loop"] = [map_apply] (const std::string &p_identifier, bool p_loop) -> void
    {
        map_apply(p_identifier, [p_loop] (sf::Sound &s) -> void
        {
            s.setLoop(p_loop);
            return;
        });
        return;
    };

    return;
}

void AudioState::MusicInterface(sel::State &p_lua_state)
{
    auto lua_interface = p_lua_state["interface"];
    auto map_apply = [this] (const std::string &p_identifier, std::function<void(sf::Music&)> p_func) -> void
    {
        if(m_musicmap.find(p_identifier) != m_musicmap.end())
            p_func(*m_musicmap.at(p_identifier));
        
        return;
    };

    lua_interface["load_music"] = [this] (const std::string &p_identifier, const std::string &p_path) -> void
    {
        m_musicmap[p_identifier] = std::make_unique<sf::Music>();
        if(!m_musicmap[p_identifier]->openFromFile(p_path))
            throw std::runtime_error("Unable to load music: " + p_path);

        return;
    };

    lua_interface["clear_music"] = [this] (const std::string &p_identifier) -> void
    {
        m_musicmap.erase(p_identifier);
        return;
    };

    lua_interface["play_music"] = [map_apply] (const std::string &p_identifier) -> void
    { 
        map_apply(p_identifier, [] (sf::Music &m) -> void
        {
            m.play();
            return;
        });
        return;
    };

    lua_interface["pause_music"] = [map_apply] (const std::string &p_identifier) -> void
    {
        map_apply(p_identifier, [] (sf::Music &m) -> void
        {
            m.pause();
            return;
        });
        return;
    };

    lua_interface["stop_music"] = [map_apply] (const std::string &p_identifier) -> void
    {
        map_apply(p_identifier, [] (sf::Music &m) -> void
        {
            m.stop();
            return;
        });
        return;
    };

    lua_interface["set_music_volume"] = [map_apply] (const std::string &p_identifier, int p_volume) -> void
    {
        map_apply(p_identifier, [p_volume] (sf::Music &m) -> void
        {
            m.setVolume(static_cast<float>(p_volume));
            return;
        });
        return;
    };

    lua_interface["set_music_loop"] = [map_apply] (const std::string &p_identifier, bool p_loop) -> void
    {
        map_apply(p_identifier, [p_loop] (sf::Music &m) -> void
        {
            m.setLoop(p_loop);
            return;
        });
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
