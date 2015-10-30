--player.lua

player = {
    position = {
        x = 100,
        y = 100
    },

    size = {
        w = 34,
        h = 26
    },

    velocity = {
        x = 0,
        y = 0,
        delta = {x = 40, y = 40},
        max = {x = 50, y = 50},
        min = {x = -50, y = -50}
    },

    control = {
        left = "a",
        right = "d",
        up = "w",
        down = "s"
    },

    sprite = {
        path = "data/sprites/player.tga",
        identifier = "player_ship",
        clip = {left = 34, top = 0, width = 34, height = 26}
    }
}
