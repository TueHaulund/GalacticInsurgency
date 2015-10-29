--render.lua

renderSystem = tiny.processingSystem()
renderSystem.filter = tiny.requireAll("position", tiny.requireAny("sprite", "shape"))

local draw_sprite = function(e)
    interface.set_sprite_position(e.sprite.identifier, e.position.x, e.position.y)
    interface.draw_sprite(e.sprite.identifier)
end

local draw_shape = function(e)

end

function renderSystem:process(e, dt)
    if(e.sprite ~= nil) then
        draw_sprite(e)
    elseif (e.shape ~= nil) then
        draw_shape(e)
    end
end
