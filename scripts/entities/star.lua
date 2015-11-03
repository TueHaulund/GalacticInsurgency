--star.lua

local counter = 0

local function createStar(initial)
    counter = counter + 1
    parallaxLevel = math.random(2, 10)

    local size = {
        w = 1,
        h = math.max(1, 6 / parallaxLevel)
    }

    local top = 1 - size.h

    return {
        position = {
            x = math.random(0, options.video.w),
            y = initial and math.random(top, options.video.h) or top
        },

        size = size,

        velocity = {
            x = 0,
            y = 150 / parallaxLevel
        },

        shape = {
            identifier = "star"..counter,
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
