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

local main

return {
    update = function(dt)
        main = main or require "scripts/main"

        tiny.update(world, dt)
        interface.drawSprite("menuBox")
        interface.drawText("menuHeading")

        if interface.isKeyPressed("y") then
            main.newGame()
        end
    end
}
