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
        std::map<std::string, std::unique_ptr<sf::Sprite>> m_spritemap;

        static std::unique_ptr<sf::Texture> LoadTexture(const std::string &p_path);
};

#endif
