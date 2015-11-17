--menu.lua

--Import tiny-ecs
local tiny = require "scripts/tiny"
local world = tiny.world()

local systems = require "scripts/systems/systems"

local options = require "scripts/options"
local screenCenter = {
    x = options.video.w / 2,
    y = options.video.h / 2
}

local selection = 0

local main

return {
    setupMenu = function()
        --Register systems
        tiny.addSystem(world, systems.createBackgroundSystem())
        tiny.addSystem(world, systems.createMovementSystem())
        tiny.addSystem(world, systems.createOobSystem())
        tiny.addSystem(world, systems.createRenderSystem())

        interface.loadSprite("menuBox", "data/sprites/menubox.tga")
        interface.setSpritePosition("menuBox", screenCenter.x - 150, screenCenter.y - 200)
        main = require "scripts/main"
    end,

    updateMenu = function(dt)
        tiny.update(world, dt)
        interface.setSpriteClip("menuBox", selection * 300, 0, 300, 400)
        interface.drawSprite("menuBox")
    end,

    keyPressed = function(k)
        if k == "down" or k == "s" then
            selection = (selection + 1) % 3
        elseif k == "up" or k == "w" then
            selection = (selection - 1) % 3
        elseif k == "return" then
            if selection == 0 then
                main.start(1)
            elseif selection == 1 then
                main.showControls()
            elseif selection == 2 then
                main.exit()
            end
        end
    end
}
