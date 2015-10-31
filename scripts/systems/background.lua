--background.lua

local backgroundSystem = tiny.processingSystem()
backgroundSystem.filter = tiny.requireAll("position", "velocity", "background")

local starCounter = 0

local function createStar()
    starCounter = starCounter + 1
    starDistance = math.random(3)

    return {
        position = {
            x = math.random(options.video.w),
            y = -50
        },

        velocity = {
            x = 0,
            y = 150 / starDistance
        },

        sprite = {
            path = "data/sprites/star.tga",
            identifier = "star_"..starCounter,
            z = 0,
            clip = {
                left = 0,
                top = 0,
                width = 38,
                height = 34
            },

            scale = {
                x = 1 / starDistance,
                y = 1 / starDistance
            }
        }
    }
end

function backgroundSystem:onAddToWorld(world)
    for i = 1, 30 do
        tiny.addEntity(world, createStar())
    end
end

function backgroundSystem:process(e, dt)

end

return backgroundSystem
