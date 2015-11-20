--star.lua

local function createStar(initial)
    parallaxLevel = math.random(2, 10)

    local size = {
        w = 1,
        h = math.max(1, 6 / parallaxLevel)
    }

    local top = 1 - size.h

    return {
        position = {
            x = math.random(0, 800),
            y = initial and math.random(top, 600) or top
        },

        size = size,

        velocity = {
            x = 0,
            y = 150 / parallaxLevel
        },

        shape = {
            identifier = interface.getUniqueIdentifier(),
            z = 0,
            rectangle = size,

            fill = {
                r = 255,
                g = 255,
                b = 255,
                a = 255
            }
        },

        background = true
    }
end

return createStar
