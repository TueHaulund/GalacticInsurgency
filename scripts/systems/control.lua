--control.lua

controlSystem = tiny.processingSystem()
controlSystem.filter = tiny.requireAll("velocity", "player")

function controlSystem:process(e, dt)
    if(interface.is_key_pressed(e.player.controls.left)) then
        e.velocity.x = e.velocity.x - e.velocity.delta.x 
    end

    if(interface.is_key_pressed(e.player.controls.right)) then
        e.velocity.x = e.velocity.x + e.velocity.delta.x
    end

    if(interface.is_key_pressed(e.player.controls.up)) then
        e.velocity.y = e.velocity.y - e.velocity.delta.y
    end

    if(interface.is_key_pressed(e.player.controls.down)) then
        e.velocity.y = e.velocity.y + e.velocity.delta.y
    end

    if(e.velocity.x < e.velocity.min.x) then
        e.velocity.x = e.velocity.min.x
    end

    if(e.velocity.x > e.velocity.max.x) then
        e.velocity.x = e.velocity.max.x
    end

    if(e.velocity.y < e.velocity.min.y) then
        e.velocity.y = e.velocity.min.y
    end

    if(e.velocity.y > e.velocity.max.y) then
        e.velocity.y = e.velocity.max.y
    end
end
