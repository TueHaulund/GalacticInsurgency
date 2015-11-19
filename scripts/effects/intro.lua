--intro.lua

local options = require "scripts/options"

local titlePosition = options.video.h / 2 - 30
local titleVelocity = -80
local titleDelay = 1.3

local overlayAlpha = 255
local alphaDecay = 100

local function createIntro(stopCallback, titleIdentifier)
    interface.createRectangle("introOverlay", options.video.w, options.video.h)
    interface.setShapeFillColor("introOverlay", 0, 0, 0, overlayAlpha)
    interface.setShapePosition("introOverlay", 0, 0)

    return {
        update = function(dt)
            if overlayAlpha >= 0 then
                overlayAlpha = overlayAlpha - alphaDecay * dt
                interface.setShapeFillColor("introOverlay", 0, 0, 0, math.max(0, overlayAlpha))
                interface.drawShape("introOverlay")
            elseif titleDelay >= 0 then
                titleDelay = titleDelay - dt
            else
                titlePosition = titlePosition + titleVelocity * dt

                if titlePosition <= 40 then
                    stopCallback()
                end

                interface.setSpritePosition(titleIdentifier, options.video.w / 2 - 370, titlePosition)
            end
        end
    }
end

return createIntro
