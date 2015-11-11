#include <SFML/Graphics.hpp>

#include "GameState.hpp"

int main()
{
    sf::RenderWindow window;
    sf::Clock clock;

    GameState state("scripts/interface.lua", window);

    while(state.IsActive())
    {
        sf::Time dt = clock.restart();
        window.clear();
        state.Update(dt.asSeconds());
        window.display();
    }

    return 0;
}
