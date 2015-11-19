--transition.lua

local function createTransition(stopCallback)
    interface.loadSprite("topShutter", "data/sprites/transition.tga")
    interface.setSpriteClip("topShutter", 0, 0, 800, 300)

    interface.loadSprite("bottomShutter", "data/sprites/transition.tga")
    interface.setSpriteClip("bottomShutter", 0, 300, 800, 300)

    --Returns the y positions of both shutters as a function of time elapsed
    local function getShutterPositions(elapsed)
        if elapsed < 1 then
            --Close shutters
            return (300 * (elapsed - 1)), (300 * (2 - elapsed))
        elseif elapsed >= 1 and elapsed < 1.5 then
            --Delay before opening
            return 0, 300
        elseif elapsed >= 1.5 then
            --Open shutters
            local delta = elapsed - 1.5
            return (-delta * 300), (300 * (delta + 1))
        end
    end

    local elapsed = 0
    local transitionCallback = nil

    return {
        start = function(transitionCallback_)
            elapsed = 0
            transitionCallback = transitionCallback_
        end,

        update = function(dt)
            elapsed = elapsed + dt
            y1, y2 = getShutterPositions(elapsed)

            interface.setSpritePosition("topShutter", 0, y1)
            interface.setSpritePosition("bottomShutter", 0, y2)
            interface.drawSprite("topShutter")
            interface.drawSprite("bottomShutter")

            if elapsed > 1 and transitionCallback ~= nil then
                transitionCallback()
                transitionCallback = nil
            elseif elapsed > 2.5 then
                stopCallback()
            end
        end
    }
end

return createTransition
