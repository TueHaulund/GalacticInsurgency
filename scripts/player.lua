--player.lua

local function createExhaust(offset)
    return {
        rate = 10,
        lifetime = {0.05, 0.2, 0.05},

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
            g = {144, 200},
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
            height = 26
        }
    },

    emitter = {
        sources = {
            createExhaust({10, 11}),
            createExhaust({22, 23})
        }
    }
}

--Updates the clip for the sprite according to direction of movement
function player.sprite.clip:update()
    if options.focus and not options.pause then
        local leanLeft = interface.isKeyPressed("a")
        local leanRight = interface.isKeyPressed("d")

        if leanLeft and not leanRight then
            self.left = 0
        elseif leanRight and not leanLeft then
            self.left = 68
        else
            self.left = 34
        end
    end
end

return player
