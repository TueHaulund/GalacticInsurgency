#ifndef GAMESTATE_HPP
#define GAMESTATE_HPP

#include <string>
#include <map>
#include <stdexcept>
#include <memory>
#include <fstream>
#include <sstream>
#include <functional>

#include <SFML/Graphics.hpp>

#include <selene.h>

#include "Resource.hpp"
#include "RenderState.hpp"
#include "AudioState.hpp"

class GameState
{
    public:
        GameState(const std::string &p_lua_path, sf::RenderWindow &p_window, bool p_libs = true);
        ~GameState();
        bool IsActive() const;
        void Update(float p_dt);

    private:
        bool m_active;

        sel::State m_lua_state;
        Resource<std::string> m_lua_script;
        
        sf::RenderWindow &m_window;
        std::map<std::string, sf::Keyboard::Key> m_keymap;
        std::map<sf::Keyboard::Key, std::string> m_keymap_rev;
        std::map<sf::Event::EventType, std::function<void(const sf::Event&)>> m_eventmap;

        AudioState m_audiostate;
        RenderState m_renderstate;

        void BuildKeymap();
        void BuildEventmap();
        
        static std::unique_ptr<std::string> LoadScript(const std::string &p_path);
};

#endif
