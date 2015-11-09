#include "RenderState.hpp"

void RenderState::operator()(sel::State &p_lua_state, sf::RenderWindow &p_window)
{
    WindowInterface(p_lua_state, p_window);
    SpriteInterface(p_lua_state, p_window);
    ShapeInterface(p_lua_state, p_window);
    TextInterface(p_lua_state, p_window);
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

    lua_interface["removeSprite"] = [this] (const std::string &p_identifier) -> void
    {
        m_spritemap.erase(p_identifier);
        return;
    };

    lua_interface["clearSprites"] = [this] () -> void
    {
        m_spritemap.clear();
        return;
    };

    lua_interface["setSpritePosition"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_x, lua_Number p_y) -> void
    {
        if(map_contains(p_identifier))
            m_spritemap.at(p_identifier)->setPosition(static_cast<float>(p_x), static_cast<float>(p_y));

        return;
    };

    lua_interface["setSpriteRotation"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_deg) -> void
    {
        if(map_contains(p_identifier))
        {
            sf::FloatRect size = m_spritemap.at(p_identifier)->getLocalBounds();
            m_spritemap.at(p_identifier)->setOrigin(size.width / 2.f, size.height / 2.f);
            m_spritemap.at(p_identifier)->setRotation(static_cast<float>(p_deg));
            m_spritemap.at(p_identifier)->setOrigin(0.f, 0.f);
        }

        return;
    };

    lua_interface["setSpriteClip"] = [this, map_contains] (const std::string &p_identifier, int p_l, int p_t, int p_w, int p_h) -> void
    {
        if(map_contains(p_identifier))
            m_spritemap.at(p_identifier)->setTextureRect(sf::IntRect(p_l, p_t, p_w, p_h));

        return;
    };

    lua_interface["setSpriteScale"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_x, lua_Number p_y) -> void
    {
        if(map_contains(p_identifier))
            m_spritemap.at(p_identifier)->setScale(static_cast<float>(p_x), static_cast<float>(p_y));

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

void RenderState::ShapeInterface(sel::State &p_state, sf::RenderWindow &p_window)
{
    auto lua_interface = p_state["interface"];
    auto map_contains = [this] (const std::string &p_identifier) -> bool
    {
        return m_shapemap.find(p_identifier) != m_shapemap.end();
    };

    lua_interface["createCircle"] = [this] (const std::string &p_identifier, lua_Number p_radius, int p_count) -> void
    {
        m_shapemap[p_identifier] = std::make_unique<sf::CircleShape>(p_radius, p_count);
        return;
    };

    lua_interface["createRectangle"] = [this] (const std::string &p_identifier, lua_Number p_w, lua_Number p_h) -> void
    {
        m_shapemap[p_identifier] = std::make_unique<sf::RectangleShape>(sf::Vector2f(static_cast<float>(p_w), static_cast<float>(p_h)));
        return;
    };

    lua_interface["removeShape"] = [this] (const std::string &p_identifier) -> void
    {
        m_shapemap.erase(p_identifier);
        return;
    };

    lua_interface["clearShapes"] = [this] () -> void
    {
        m_shapemap.clear();
        return;
    };

    lua_interface["setShapePosition"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_x, lua_Number p_y) -> void
    {
        if(map_contains(p_identifier))
            m_shapemap.at(p_identifier)->setPosition(static_cast<float>(p_x), static_cast<float>(p_y));

        return;
    };

    lua_interface["setShapeRotation"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_deg) -> void
    {
        if(map_contains(p_identifier))
        {
            sf::FloatRect size = m_shapemap.at(p_identifier)->getLocalBounds();
            m_shapemap.at(p_identifier)->setOrigin(size.width / 2.f, size.height / 2.f);
            m_shapemap.at(p_identifier)->setRotation(static_cast<float>(p_deg));
            m_shapemap.at(p_identifier)->setOrigin(0.f, 0.f);
        }

        return;
    };

    lua_interface["setShapeScale"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_x, lua_Number p_y) -> void
    {
        if(map_contains(p_identifier))
            m_shapemap.at(p_identifier)->setScale(static_cast<float>(p_x), static_cast<float>(p_y));

        return;
    };

    lua_interface["setShapeOutlineThickness"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_thickness) -> void
    {
        if(map_contains(p_identifier))
            m_shapemap.at(p_identifier)->setOutlineThickness(static_cast<float>(p_thickness));

        return;
    };

    lua_interface["setShapeOutlineColor"] = [this, map_contains] (const std::string &p_identifier, int p_r, int p_g, int p_b, int p_a) -> void
    {
        //Check for invalid values, no support for 8-bit types in Selene
        if(p_r < 0 || p_r > 255 || p_g < 0 || p_g > 255 || p_b < 0 || p_b > 255 || p_a < 0 || p_a > 255)
            throw std::runtime_error("Invalid color requested");

        if(map_contains(p_identifier))
            m_shapemap.at(p_identifier)->setOutlineColor(sf::Color(p_r, p_g, p_b, p_a));

        return;
    };

    lua_interface["setShapeFillColor"] = [this, map_contains] (const std::string &p_identifier, int p_r, int p_g, int p_b, int p_a) -> void
    {
        //Check for invalid values, no support for 8-bit types in Selene
        if(p_r < 0 || p_r > 255 || p_g < 0 || p_g > 255 || p_b < 0 || p_b > 255 || p_a < 0 || p_a > 255)
            throw std::runtime_error("Invalid color requested");

        if(map_contains(p_identifier))
            m_shapemap.at(p_identifier)->setFillColor(sf::Color(p_r, p_g, p_b, p_a));

        return;
    };

    lua_interface["drawShape"] = [this, map_contains, &p_window] (const std::string &p_identifier) -> void
    {
        if(map_contains(p_identifier))
            p_window.draw(*m_shapemap.at(p_identifier));

        return;
    };

    return;
}

void RenderState::TextInterface(sel::State &p_lua_state, sf::RenderWindow &p_window)
{
    auto lua_interface = p_lua_state["interface"];
    auto map_contains = [this] (const std::string &p_identifier) -> bool
    {
        return m_textmap.find(p_identifier) != m_textmap.end();
    };

    lua_interface["createText"] = [this, map_contains] (const std::string &p_identifier, const std::string &p_text, const std::string &p_path) -> void
    {
        Resource<sf::Font> font(p_path, LoadFont);

        if(map_contains(p_identifier))
        {
            m_textmap.at(p_identifier)->setFont(font.Get());
            m_textmap.at(p_identifier)->setString(p_text);
        }
        else
            m_textmap[p_identifier] = std::make_unique<sf::Text>(p_text, font.Get());

        return;
    };

    lua_interface["removeText"] = [this] (const std::string &p_identifier) -> void
    {
        m_textmap.erase(p_identifier);
        return;
    };

    lua_interface["clearText"] = [this] () -> void
    {
        m_textmap.clear();
        return;
    };

    lua_interface["setTextString"] = [this, map_contains] (const std::string &p_identifier, const std::string &p_str) -> void
    {
        if(map_contains(p_identifier))
            m_textmap.at(p_identifier)->setString(p_str);

        return;
    };

    lua_interface["setTextFont"] = [this, map_contains] (const std::string &p_identifier, const std::string &p_path) -> void
    {
        Resource<sf::Font> font(p_path, LoadFont);

        if(map_contains(p_identifier))
            m_textmap.at(p_identifier)->setFont(font.Get());

        return;
    };

    lua_interface["setTextSize"] = [this, map_contains] (const std::string &p_identifier, int p_size) -> void
    {
        if(p_size < 0)
            throw std::runtime_error("Invalid text size requested");

        if(map_contains(p_identifier))
            m_textmap.at(p_identifier)->setCharacterSize(static_cast<unsigned int>(p_size));

        return;
    };

    lua_interface["setTextColor"] = [this, map_contains] (const std::string &p_identifier, int p_r, int p_g, int p_b, int p_a) -> void
    {
        if(p_r < 0 || p_r > 255 || p_g < 0 || p_g > 255 || p_b < 0 || p_b > 255 || p_a < 0 || p_a > 255)
            throw std::runtime_error("Invalid color requested");

        if(map_contains(p_identifier))
            m_textmap.at(p_identifier)->setColor(sf::Color(p_r, p_g, p_b, p_a));

        return;
    };

    lua_interface["setTextPosition"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_x, lua_Number p_y) -> void
    {
        if(map_contains(p_identifier))
            m_textmap.at(p_identifier)->setPosition(static_cast<float>(p_x), static_cast<float>(p_y));

        return;
    };

    lua_interface["setTextRotation"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_deg) -> void
    {
        if(map_contains(p_identifier))
        {
            sf::FloatRect size = m_textmap.at(p_identifier)->getLocalBounds();
            m_textmap.at(p_identifier)->setOrigin(size.width / 2.f, size.height / 2.f);
            m_textmap.at(p_identifier)->setRotation(static_cast<float>(p_deg));
            m_textmap.at(p_identifier)->setOrigin(0.f, 0.f);
        }

        return;
    };

    lua_interface["setTextScale"] = [this, map_contains] (const std::string &p_identifier, lua_Number p_x, lua_Number p_y) -> void
    {
        if(map_contains(p_identifier))
            m_textmap.at(p_identifier)->setScale(static_cast<float>(p_x), static_cast<float>(p_y));

        return;
    };

    lua_interface["drawText"] = [this, map_contains, &p_window] (const std::string &p_identifier) -> void
    {
        if(map_contains(p_identifier))
            p_window.draw(*m_textmap.at(p_identifier));

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

std::unique_ptr<sf::Font> RenderState::LoadFont(const std::string &p_path)
{
    auto font = std::make_unique<sf::Font>();

    if(!font->loadFromFile(p_path))
        throw std::runtime_error("Unable to load font: " + p_path);

    return font;
}
