--player.lua

local player = {
    position = {
        x = 383,
        y = 450
    },

    size = {
        w = 34,
        h = 26
    },

    velocity = {
        x = 0,
        y = 0
    },

    player = {
        delta = {
            x = 450,
            y = 450
        },

        max = {
            x = 200,
            y = 200
        },

        min = {
            x = -200,
            y = -200
        },

        decay = {
            x = 0.95,
            y = 0.95
        },

        cooldown = 0
    },

    sprite = {
        path = "data/sprites/player.tga",
        identifier = "playerShip",
        z = 10,

        scale = {
            x = 1,
            y = 1
        },

        clip = {
            left = 0,
            top = 0,
            width = 34,
            height = 25,
            offset = 0
        }
    },

    emitter = {
        sources = {
            engine = {
                rate = 15,
                temporary = {0.05, 0.1, 0.05},
                rotate = false,

                offset = {
                    x = {15, 18},
                    y = 22
                },

                size = {
                    w = {1, 2},
                    h = {1, 2}
                },

                velocity = {
                    x = 0,
                    y = {25, 75}
                },

                color = {
                    r = {200, 255},
                    g = 0,
                    b = 0,
                    a = 255
                }
            }
        }
    }
}

return player
