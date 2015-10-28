--player.lua

player = {
    position = {
        x = 100,
        y = 100
    },

    velocity = {
        x = 0,
        y = 0,
        delta = {x = 0.01, y = 0.01},
        max = {x = 5, y = 5},
        min = {x = -5, y = -5}
    },

    player = {
        controls = {
            left = "a",
            right = "d",
            up = "w",
            down = "s"
        }
    }
}
