--render.lua

local renderSystem = tiny.sortedProcessingSystem()
renderSystem.filter = tiny.requireAll("position", tiny.requireAny("sprite", "shape"))

--Sort entities according to their z-index
function renderSystem:compare(e1, e2)
    local z1 = e1.sprite and e1.sprite.z or e1.shape.z
    local z2 = e2.sprite and e2.sprite.z or e2.shape.z

    return z1 < z2
end

local function drawSprite(e)
    local id = e.sprite.identifier
    local clip = e.sprite.clip

    if clip.update ~= nil then
        clip:update()
        interface.setSpriteClip(id, clip.left, clip.top, clip.width, clip.height)
    end

    interface.setSpritePosition(id, e.position.x, e.position.y)
    interface.drawSprite(id)
end

local function drawShape(e)
    --TODO: Implement interface for drawing shapes
end

function renderSystem:onAdd(e)
    if e.sprite ~= nil then
        local sprite = e.sprite
        local id = sprite.identifier
        local clip = sprite.clip
        local scale = sprite.scale

        interface.loadSprite(id, sprite.path)
        interface.setSpriteClip(id, clip.left, clip.top, clip.width, clip.height)
        interface.setSpriteScale(id, scale.x, scale.y)
    elseif e.shape ~= nil then
        --Setup shape
    end
end

function renderSystem:onRemove(e)
    if e.sprite ~= nil then
        interface.removeSprite(e.sprite.identifier)
    elseif e.shape ~= nil then
        --Remove shape
    end
end

function renderSystem:process(e, dt)
    if e.sprite ~= nil then
        drawSprite(e)
    elseif e.shape ~= nil then
        drawShape(e)
    end
end

return renderSystem
