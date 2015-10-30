#include "RenderState.hpp"

void RenderState::operator()(sel::State &p_lua_state, sf::RenderWindow &p_window)
{
    WindowInterface(p_lua_state, p_window);
    SpriteInterface(p_lua_state, p_window);
    return;
}

void RenderState::WindowInterface(sel::State &p_lua_state, sf::RenderWindow &p_window)
{
    auto lua_interface = p_lua_state["interface"];
    
    lua_interface["createWindow"] = [&p_window] (int p_w, int p_h, int p_bpp, int p_fps, const std::string &p_title) -> void
    {
        //Check for negative values - no support for unsigned types in Selene
        if(p_w < 0 || p_h < 0 || p_bpp < 0 || p_fps < 0)
            throw std::runtime_error("Invalid video mode requested");

        p_window.create(sf::VideoMode(p_w, p_h, p_bpp), p_title, sf::Style::None);
        p_window.setFramerateLimit(p_fps);
        p_window.setKeyRepeatEnabled(false);
        return;
    };

    lua_interface["closeWindow"] = [&p_window] () -> void
    {
        p_window.close();
        return;
    };

    lua_interface["resizeWindow"] = [&p_window] (int p_w, int p_h) -> void
    {
        //Check for negative values - no support for unsigned types in Selene
        if(p_w < 0 || p_h < 0)
            throw std::runtime_error("Invalid video mode requested");

        p_window.setSize(sf::Vector2u(p_w, p_h));
        return;
    };

    return;
}

void RenderState::SpriteInterface(sel::State &p_lua_state, sf::RenderWindow &p_window)
{
    auto lua_interface = p_lua_state["interface"];
    auto map_contains = [this] (const std::string &p_identifier) -> bool
    {
        return m_spritemap.find(p_identifier) != m_spritemap.end();
    };

    lua_interface["loadSprite"] = [this, map_contains] (const std::string &p_identifier, const std::string &p_path) -> void
    {
        Resource<sf::Texture> texture(p_path, LoadTexture);

        if(map_contains(p_identifier))
            m_spritemap.at(p_identifier)->setTexture(texture.Get());
        else
            m_spritemap[p_identifier] = std::make_unique<sf::Sprite>(texture.Get());

        return;
    };

    lua_interface["clearSprite"] = [this] (const std::string &p_identifier) -> void
    {
        m_spritemap.erase(p_identifier);
        return;
    };

    lua_interface["setSpritePosition"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_x, lua_Number p_y) -> void
    {
        if(map_contains(p_identifier))
            m_spritemap.at(p_identifier)->setPosition(static_cast<float>(p_x), static_cast<float>(p_y));

        return;
    };

    lua_interface["setSpriteClip"] = [this, map_contains] (const std::string &p_identifier, int p_l, int p_t, int p_w, int p_h) -> void
    {
        if(map_contains(p_identifier))
            m_spritemap.at(p_identifier)->setTextureRect(sf::IntRect(p_l, p_t, p_w, p_h));

        return;
    };

    lua_interface["drawSprite"] = [this, map_contains, &p_window] (const std::string &p_identifier) -> void
    {
        if(map_contains(p_identifier))
            p_window.draw(*m_spritemap.at(p_identifier));

        return;
    };

    return;
}

std::unique_ptr<sf::Texture> RenderState::LoadTexture(const std::string &p_path)
{
    auto texture = std::make_unique<sf::Texture>();

    if(!texture->loadFromFile(p_path))
        throw std::runtime_error("Unable to load texture: " + p_path);

    return texture;
}
