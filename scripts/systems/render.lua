--render.lua

renderSystem = tiny.processingSystem()
renderSystem.filter = tiny.requireAll("position", tiny.requireAny("sprite", "shape"))

function renderSystem:process(e, dt)
    --call cpp render functions
end
