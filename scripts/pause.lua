--pause.lua

local mainFont = "data/fonts/MainFont.ttf"

local screenCenter = {
    x = options.video.w / 2,
    y = options.video.h / 2
}

local function setupPauseScreen()
    --Semi-transparent rectangle overlay
    interface.createRectangle("pauseOverlay", options.video.w, options.video.h)
    interface.setShapeFillColor("pauseOverlay", 64, 64, 64, 128)
    interface.setShapePosition("pauseOverlay", 0, 0)

    interface.createRectangle("pauseTextBox", 400, 200)
    interface.setShapeFillColor("pauseTextBox", 0, 0, 0, 255)
    interface.setShapePosition("pauseTextBox", screenCenter.x - 200, screenCenter.y - 100)
    interface.setShapeOutlineColor("pauseTextBox", 255, 255, 255, 255)
    interface.setShapeOutlineThickness("pauseTextBox", 3)

    interface.createText("pauseHeading", "Paused", mainFont)
    interface.setTextColor("pauseHeading", 255, 255, 255, 255)
    interface.setTextSize("pauseHeading", 32)
    interface.setTextPosition("pauseHeading", screenCenter.x - 55, screenCenter.y - 85)

    interface.createText("unpauseText", "Press p to unpause", mainFont)
    interface.setTextColor("unpauseText", 255, 255, 255, 255)
    interface.setTextSize("unpauseText", 20)
    interface.setTextPosition("unpauseText", screenCenter.x - 110, screenCenter.y)

    interface.createText("exitText", "Press escape to exit", mainFont)
    interface.setTextColor("exitText", 255, 255, 255, 255)
    interface.setTextSize("exitText", 20)
    interface.setTextPosition("exitText", screenCenter.x - 117, screenCenter.y + 20)
end

local function drawPauseScreen()
    interface.drawShape("pauseOverlay")
    interface.drawShape("pauseTextBox")
    interface.drawText("pauseHeading")
    interface.drawText("unpauseText")
    interface.drawText("exitText")
end

local function clearPauseScreen()
    interface.removeShape("pauseOverlay")
    interface.removeShape("pauseTextBox")
    interface.removeText("pauseHeading")
    interface.removeText("unpauseText")
    interface.removeText("exitText")
end

return {
    setupPauseScreen = setupPauseScreen, 
    drawPauseScreen = drawPauseScreen,
    clearPauseScreen = clearPauseScreen
}
