#include <SFML/Graphics.hpp>

#include "Resource.hpp"
#include "GameState.hpp"

int main()
{
    sf::RenderWindow window(sf::VideoMode(500, 500), "Interceptor2D");
    sf::Clock clock;

    GameState state("scripts/main.lua");

    while(window.isOpen())
    {
        sf::Time dt = clock.restart();
        sf::Event event;
        while(window.pollEvent(event))
        {
            if(event.type == sf::Event::Closed)
                window.close();
        }

        state.Update(dt.asSeconds());
        window.clear();
        state.Draw();
        window.display();
    }

    return 0;
}
