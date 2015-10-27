#ifndef AUDIOSTATE_HPP
#define AUDIOSTATE_HPP

#include <string>
#include <map>
#include <stdexcept>
#include <memory>

#include <SFML/Audio.hpp>

#include <selene.h>

#include "Resource.hpp"

class AudioState
{
    public:
        void operator()(sel::State &p_lua_state);

    private:
        void SoundInterface(sel::State &p_lua_state);
        void MusicInterface(sel::State &p_lua_state);
        
        std::map<std::string, std::unique_ptr<sf::Sound>> m_soundmap;
        std::map<std::string, std::unique_ptr<sf::Music>> m_musicmap;

        static std::unique_ptr<sf::SoundBuffer> LoadSound(const std::string &p_path);
};

#endif
