--render.lua

local renderSystem = tiny.processingSystem()
renderSystem.filter = tiny.requireAll("position", tiny.requireAny("sprite", "shape"))

local function drawSprite(e)
    interface.setSpritePosition(e.sprite.identifier, e.position.x, e.position.y)
    interface.drawSprite(e.sprite.identifier)
end

local function drawShape(e)

end

function renderSystem:onAdd(e)
    if(e.sprite ~= nil) then
        local s = e.sprite
        interface.loadSprite(s.identifier, s.path)
        interface.setSpriteClip(s.identifier, s.clip.left, s.clip.top, s.clip.width, s.clip.height)
    end
end

function renderSystem:onRemove(e)
    if(e.sprite ~= nil) then
        interface.clearSprite(e.sprite.identifier)
    end
end

function renderSystem:process(e, dt)
    if(e.sprite ~= nil) then
        drawSprite(e)
    elseif (e.shape ~= nil) then
        drawShape(e)
    end
end

return renderSystem
