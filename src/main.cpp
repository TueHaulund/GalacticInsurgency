#include <SFML/Graphics.hpp>

#include "GameState.hpp"

int main()
{
    sf::RenderWindow window(sf::VideoMode(500, 500), "Interceptor2D");
    sf::Clock clock;

    GameState state("scripts/main.lua", window);

    while(window.isOpen())
    {
        sf::Time dt = clock.restart();
        state.Update(dt.asSeconds());
        window.clear();
        state.Draw();
        window.display();
    }

    return 0;
}
