--menu.lua

local tiny = require "scripts/tiny"
local background = tiny.world()

local menuSelection = 0
local showControls = false

local main

return {
    setupMenu = function()
        local systems = require "scripts/systems/systems"

        --Register systems
        tiny.addSystem(background, systems.createBackgroundSystem())
        tiny.addSystem(background, systems.createMovementSystem())
        tiny.addSystem(background, systems.createCullingSystem())
        tiny.addSystem(background, systems.createRenderSystem())

        local options = require "scripts/options"

        local screenCenter = {
            x = options.video.w / 2,
            y = options.video.h / 2
        }

        interface.loadSprite("menuBox", "data/sprites/menubox.tga")
        interface.setSpritePosition("menuBox", screenCenter.x - 150, screenCenter.y - 200)

        interface.loadSprite("controlBox", "data/sprites/controlbox.tga")
        interface.setSpritePosition("controlBox", screenCenter.x - 250, screenCenter.y - 250)

        main = require "scripts/main"
    end,

    updateMenu = function(dt)
        tiny.update(background, dt)
        interface.setSpriteClip("menuBox", menuSelection * 300, 0, 300, 400)
        interface.drawSprite("menuBox")

        if showControls then
            interface.drawSprite("controlBox")
        end
    end,

    input = function(k)
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
                    main.startGame(1)
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
}
