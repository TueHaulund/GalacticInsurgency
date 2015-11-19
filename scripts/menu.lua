--menu.lua

local tiny = require "scripts/tiny"
local systems = require "scripts/systems/systems"
local options = require "scripts/options"

local function createMenu(startCallback)
    local background = tiny.world()

    --Register systems
    tiny.addSystem(background, systems.createBackgroundSystem())
    tiny.addSystem(background, systems.createMovementSystem())
    tiny.addSystem(background, systems.createCullingSystem())
    tiny.addSystem(background, systems.createRenderSystem())

    local screenCenter = {
        x = options.video.w / 2,
        y = options.video.h / 2
    }

    interface.loadSprite("menuTitle", "data/sprites/title.tga")
    interface.setSpritePosition("menuTitle", screenCenter.x - 370, screenCenter.y - 30)

    interface.loadSprite("menuBox", "data/sprites/menubox.tga")
    interface.setSpritePosition("menuBox", screenCenter.x - 150, screenCenter.y - 150)

    interface.loadSprite("controlBox", "data/sprites/controlbox.tga")
    interface.setSpritePosition("controlBox", screenCenter.x - 250, screenCenter.y - 250)

    local introEffect = createIntro(function() showIntro = false end, "menuTitle")

    local menuSelection = 0
    local showControls = false
    local showIntro = true

    return {
        update = function(dt)
            tiny.update(background, dt)
            interface.drawSprite("menuTitle")

            if showIntro then
                introEffect.update(dt)
            else
                interface.setSpriteClip("menuBox", menuSelection * 300, 0, 300, 400)
                interface.drawSprite("menuBox")

                if showControls then
                    interface.drawSprite("controlBox")
                end
            end
        end,

        input = function(k)
            if not showIntro then
                if showControls then
                    if k == "escape" then
                        showControls = false
                    end
                else
                    if k == "down" or k == "s" then
                        menuSelection = (menuSelection + 1) % 3
                    elseif k == "up" or k == "w" then
                        menuSelection = (menuSelection - 1) % 3
                    elseif k == "return" then
                        if menuSelection == 0 then
                            startCallback()
                        elseif menuSelection == 1 then
                            showControls = true
                        elseif menuSelection == 2 then
                            interface.exit()
                        end
                    elseif k == "escape" then
                        interface.exit()
                    end
                end
            end
        end
    }
end

return createMenu
