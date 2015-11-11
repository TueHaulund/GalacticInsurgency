--render.lua

--Import tiny-ecs
local tiny = require "scripts/tiny"

local function drawSprite(e)
    local id = e.sprite.identifier
    local clip = e.sprite.clip

    interface.setSpriteClip(id, clip.left, clip.top, clip.width, clip.height)
    interface.setSpritePosition(id, e.position.x, e.position.y)
    interface.drawSprite(id)
end

local function drawShape(e)
    local id = e.shape.identifier

    interface.setShapePosition(id, e.position.x, e.position.y)
    interface.drawShape(id)
end

local function createSprite(e)
    local sprite = e.sprite
    local id = sprite.identifier
    local clip = sprite.clip
    local scale = sprite.scale

    interface.loadSprite(id, sprite.path)
    interface.setSpriteClip(id, clip.left, clip.top, clip.width, clip.height)
    interface.setSpriteScale(id, scale.x, scale.y)

    if sprite.rotation ~= nil then
        interface.setSpriteRotation(id, sprite.rotation)
    end
end

local function createShape(e)
    local shape = e.shape
    local id = shape.identifier
    local fill = shape.fill

    if shape.rectangle ~= nil then
        interface.createRectangle(id, shape.rectangle.w, shape.rectangle.h)
    elseif shape.circle ~= nil then
        interface.createCircle(id, shape.circle.radius, shape.circle.points)
    end

    if shape.rotation ~= nil then
        interface.setShapeRotation(id, shape.rotation)
    end

    interface.setShapeFillColor(id, fill.r, fill.g, fill.b, fill.a)
end

local function createRenderSystem()
    local renderSystem = tiny.sortedProcessingSystem()
    renderSystem.filter = tiny.requireAll("position", tiny.requireAny("sprite", "shape"))
    renderSystem.systemIndex = 7

    --Sort entities according to their z-index
    function renderSystem:compare(e1, e2)
        local z1 = e1.sprite and e1.sprite.z or e1.shape.z
        local z2 = e2.sprite and e2.sprite.z or e2.shape.z

        return z1 < z2
    end

    function renderSystem:onAdd(e)
        if e.sprite ~= nil then
            createSprite(e)
        elseif e.shape ~= nil then
            createShape(e)
        end
    end

    function renderSystem:onRemove(e)
        if e.sprite ~= nil then
            interface.removeSprite(e.sprite.identifier)
        elseif e.shape ~= nil then
            interface.removeShape(e.shape.identifier)
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
end

return createRenderSystem
