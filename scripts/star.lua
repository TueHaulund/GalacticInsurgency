--star.lua

local counter = 0

local function createStar(initial)
    counter = counter + 1
    parallaxLevel = math.random(2, 10)

    return {
        position = {
            x = math.random(0, options.video.w),
            y = initial and math.random(-50, options.video.h) or -50
        },

        velocity = {
            x = 0,
            y = 150 / parallaxLevel
        },

        shape = {
            identifier = "star"..counter,
            z = 0,

            rectangle = {
                w = 1,
                h = math.max(1, 6 / parallaxLevel)
            },

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
