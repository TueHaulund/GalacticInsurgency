--render.lua

local tiny = require "scripts/tiny"

local function drawSprite(e)
    local id = e.sprite.identifier
    local clip = e.sprite.clip

    interface.setSpriteClip(id, clip.left, clip.top, clip.width, clip.height)
    interface.setSpritePosition(id, e.position.x, e.position.y)

    if e.rotation ~= nil then
        interface.setSpriteRotation(id, e.rotation)
    end

    interface.drawSprite(id)
end

local function drawShape(e)
    local id = e.shape.identifier

    interface.setShapePosition(id, e.position.x, e.position.y)

    if e.rotation ~= nil then
        interface.setShapeRotation(id, e.rotation)
    end

    interface.drawShape(id)
end

local function createSprite(e)
    local sprite = e.sprite
    local id = sprite.identifier
    local clip = sprite.clip

    interface.loadSprite(id, sprite.path)
    interface.setSpriteClip(id, clip.left, clip.top, clip.width, clip.height)
end

local function createShape(e)
    local shape = e.shape
    local size = e.size
    local id = shape.identifier
    local fill = shape.fill

    if size.radius ~= nil and size.points ~= nil then
        interface.createCircle(id, size.radius, size.points)
    elseif size.w ~= nil and size.h ~= nil then
        interface.createRectangle(id, size.w, size.h)
    end

    interface.setShapeFillColor(id, fill.r, fill.g, fill.b, fill.a)
end

local function createRenderSystem()
    local renderSystem = tiny.sortedProcessingSystem()
    renderSystem.filter = tiny.requireAll("position", "size", tiny.requireAny("sprite", "shape"))

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

    renderSystem._isRender = true

    return renderSystem
end

return createRenderSystem
