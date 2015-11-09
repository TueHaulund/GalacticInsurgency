#ifndef RENDERSTATE_HPP
#define RENDERSTATE_HPP

#include <string>
#include <map>
#include <stdexcept>
#include <memory>

#include <SFML/Graphics.hpp>

#include <selene.h>

#include "Resource.hpp"

class RenderState
{
    public:
        void operator()(sel::State &p_lua_state, sf::RenderWindow &p_window);

    private:
        void WindowInterface(sel::State &p_lua_state, sf::RenderWindow &p_window);
        void SpriteInterface(sel::State &p_lua_state, sf::RenderWindow &p_window);
        void ShapeInterface(sel::State &p_lua_state, sf::RenderWindow &p_window);
        void TextInterface(sel::State &p_lua_state, sf::RenderWindow &p_window);

        std::map<std::string, std::unique_ptr<sf::Sprite>> m_spritemap;
        std::map<std::string, std::unique_ptr<sf::Shape>> m_shapemap;
        std::map<std::string, std::unique_ptr<sf::Text>> m_textmap;

        static std::unique_ptr<sf::Texture> LoadTexture(const std::string &p_path);
        static std::unique_ptr<sf::Font> LoadFont(const std::string &p_path);
};

#endif
