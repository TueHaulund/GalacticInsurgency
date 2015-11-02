--player.lua

local fireLaser = require "scripts/entities/lasers"

local function createExhaust(offset)
    return {
        rate = 10,
        temporary = {0.05, 0.2, 0.05},
        rotate = false,

        offset = {
            x = offset,
            y = 23
        },

        size = {
            w = {1, 2},
            h = {1, 2}
        },

        velocity = {
            x = {-10, 10},
            y = {15, 25}
        },

        color = {
            r = 255,
            g = {50, 255},
            b = 0,
            a = 255
        }
    }
end

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

    control = {
        left = "a",
        right = "d",
        up = "w",
        down = "s",
        fire = "space"
    },

    player = {
        movement = {
            direction = {
                left = false,
                right = false
            },

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
            }
        },

        offensive = {
            level = 1,
            remaining = 0,

            fire = function(world, e)
                if e.player.offensive.remaining <= 0 then
                    fireLaser(world, e, e.player.offensive.level)
                end
            end
        }
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
            left = 34,
            top = 0,
            width = 34,
            height = 26,

            --Updates the clip for the sprite according to direction of movement
            update = function(e)
                local leanLeft = e.player.movement.direction.left
                local leanRight = e.player.movement.direction.right

                if leanLeft and not leanRight then
                    e.sprite.clip.left = 0
                elseif leanRight and not leanLeft then
                    e.sprite.clip.left = 68
                else
                    e.sprite.clip.left = 34
                end
            end
        }
    },

    emitter = {
        sources = {
            createExhaust({10, 11}),
            createExhaust({22, 23})
        }
    }
}

return player
