--player.lua

local function createPlayer()
    return {
        position = {
            x = 383,
            y = 500
        },

        size = {
            w = 40,
            h = 46
        },

        movement = {
            velocity = {
                x = 0,
                y = 0
            },

            delta = {
                x = 0,
                y = 0
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
            }
        },

        player = {
            cooldown = 0,
            fire = nil
        },

        sprite = {
            path = "data/sprites/player.tga",
            identifier = "playerShip",
            z = 10,

            clip = {
                left = 0,
                top = 0,
                width = 40,
                height = 46
            }
        },

        emitter = {
            sources = {}
        }
    }
end

return createPlayer
