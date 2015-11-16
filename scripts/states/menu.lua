--menu.lua

--Import tiny-ecs
local tiny = require "scripts/tiny"
local world = tiny.world()

local systems = require "scripts/systems/systems"
local menuSystems = {
    movementSystem = systems.createMovementSystem(),
    backgroundSystem = systems.createBackgroundSystem(),
    oobSystem = systems.createOobSystem(),
    renderSystem = systems.createRenderSystem()
}

local mainFont = "data/fonts/MainFont.ttf"
local options = require "scripts/options"
local screenCenter = {
    x = options.video.w / 2,
    y = options.video.h / 2
}

local selection = 1

local main

return {
    setupMenu = function()
        --Register systems
        for _, system in pairs(menuSystems) do
            tiny.addSystem(world, system)
        end

        tiny.refresh(world)

        tiny.setSystemIndex(world, menuSystems.backgroundSystem, 1)
        tiny.setSystemIndex(world, menuSystems.movementSystem, 2)
        tiny.setSystemIndex(world, menuSystems.oobSystem, 3)
        tiny.setSystemIndex(world, menuSystems.renderSystem, 4)

        interface.loadSprite("menuBox", "data/sprites/menubox.tga")
        interface.setSpritePosition("menuBox", screenCenter.x - 150, screenCenter.y - 200)

        interface.createText("menuHeading", "Menu", mainFont)
        interface.setTextColor("menuHeading", 0, 0, 0, 255)
        interface.setTextSize("menuHeading", 32)
        interface.setTextPosition("menuHeading", screenCenter.x - 35, screenCenter.y - 185)
        main = require "scripts/main"
    end,

    updateMenu = function(dt)
        tiny.update(world, dt)
        interface.drawSprite("menuBox")
        interface.drawText("menuHeading")
    end,

    keyPressed = function(k)
        if k == "down" or k == "s" then
            selection = selection + 1
        elseif k == "up" or k == "w" then
            selection = selection - 1
        end

        if selection == 0 then
            selection = 3
        end

        if selection == 4 then
            selection = 1
        end

        print(selection)

        if k == "y" then
            main.start(1)
        end

        if k == "l" then
            main.showControls()
        end

        if k == "j" then
            main.exit()
        end
    end
}
