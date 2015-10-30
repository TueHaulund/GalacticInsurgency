--render.lua

local renderSystem = tiny.processingSystem()
renderSystem.filter = tiny.requireAll("position", tiny.requireAny("sprite", "shape"))

local function drawSprite(e)
    local clip = e.sprite.clip
    if clip.update ~= nil then
        clip:update()
        interface.setSpriteClip(e.sprite.identifier, clip.left, clip.top, clip.width, clip.height)
    end

    interface.setSpritePosition(e.sprite.identifier, e.position.x, e.position.y)
    interface.drawSprite(e.sprite.identifier)
end

local function drawShape(e)
    --TODO: Implement interface for drawing shapes
end

function renderSystem:onAdd(e)
    if(e.sprite ~= nil) then
        local sprite = e.sprite
        local clip = sprite.clip

        interface.loadSprite(sprite.identifier, sprite.path)
        interface.setSpriteClip(sprite.identifier, clip.left, clip.top, clip.width, clip.height)
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
