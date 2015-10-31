--star.lua

local counter = 0

local function createStar(y)
    counter = counter + 1
    parallaxLevel = math.random(10)

    return {
        position = {
            x = math.random(options.video.w),
            y = y
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
                h = 6 / parallaxLevel
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
