--gui.lua

local function setupGUI()
    interface.createRectangle("pause", options.video.w, options.video.h)
    interface.setShapeFillColor("pause", 64, 64, 64, 128)
    interface.setShapePosition("pause", 0, 0)
end

local function updateGUI(dt)
    --Draw gui here

    if options.pause then
        interface.drawShape("pause")
    end
end

local function clearGUI()
    interface.removeShape("pause")
end

return {
    setupGUI = setupGUI, 
    updateGUI = updateGUI,
    clearGUI = clearGUI
}
