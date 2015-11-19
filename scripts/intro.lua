--intro.lua

local function createIntro(stopCallback, titleIdentifier)
    interface.createRectangle("introOverlay", 800, 600)
    interface.setShapeFillColor("introOverlay", 0, 0, 0, 255)
    interface.setShapePosition("introOverlay", 0, 0)

    --Returns the y position of the title text as a function of time elapsed
    local function getTitlePosition(elapsed)
        if elapsed < 1.3 then
            --Delay before moving
            return 270
        elseif elapsed >= 1.3 and elapsed < 4.175 then
            --Slide title upwards
            local delta = elapsed - 1.3
            return (270 - delta * 80)
        elseif elapsed >= 4.175 then
            --Stop sliding near top of viewport
            return 40
        end
    end

    local elapsed = 0

    return {
        update = function(dt)
            elapsed = elapsed + dt

            --Fade in by reducing alpha as time passes
            local overlayAlpha = 255 - 100 * elapsed

            --Make sure we don't request a negative alpha value
            interface.setShapeFillColor("introOverlay", 0, 0, 0, math.max(0, overlayAlpha))
            interface.drawShape("introOverlay")

            interface.setSpritePosition(titleIdentifier, 30, getTitlePosition(elapsed))

            if elapsed >= 4.175 then
                stopCallback()
            end
        end
    }
end

return createIntro
