--menu.lua

local systems = require "scripts/systems/systems"

local backgroundSystem = systems.createBackgroundSystem()
local movementSystem = systems.createMovementSystem()
local oobSystem = systems.createOobSystem()
local renderSystem = systems.createRenderSystem()

local menuWorld = tiny.world()

local mainFont = "data/fonts/MainFont.ttf"

local screenCenter = {
    x = options.video.w / 2,
    y = options.video.h / 2
}

local function setupMenuScreen()
    tiny.addSystem(menuWorld, backgroundSystem)
    tiny.addSystem(menuWorld, movementSystem)
    tiny.addSystem(menuWorld, oobSystem)
    tiny.addSystem(menuWorld, renderSystem)

    tiny.refresh(menuWorld)

    tiny.setSystemIndex(menuWorld, backgroundSystem, 1)
    tiny.setSystemIndex(menuWorld, movementSystem, 2)
    tiny.setSystemIndex(menuWorld, oobSystem, 3)
    tiny.setSystemIndex(menuWorld, renderSystem, 4)

    interface.createText("menuHeading", "MENUMENU", mainFont)
    interface.setTextColor("menuHeading", 255, 255, 255, 255)
    interface.setTextPosition("menuHeading", screenCenter.x, screenCenter.y)
end

local function drawMenuScreen(dt)
    tiny.update(menuWorld, dt)
    interface.drawText("menuHeading")
end

return {
    setupMenuScreen = setupMenuScreen,
    drawMenuScreen = drawMenuScreen
}
