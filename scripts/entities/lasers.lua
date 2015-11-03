--lasers.lua

local counter = 0

local lasers = {
    function(world, e, dt)
        local cooldown = 1.5
        e.player.offensive.remaining = cooldown
        counter = counter + 1
        
        tiny.addEntity(world, {
            position = {
                x = e.position.x + 16,
                y = e.position.y
            },

            size = {
                w = 2,
                h = 4
            },

            velocity = {
                y = -200,
                x = 0
            },

            shape = {
                identifier = "projectile"..counter,
                z = 2,

                rectangle = {
                    w = 2,
                    h = 4
                },

                fill = {
                    r = 0,
                    g = 255,
                    b = 0,
                    a = 255
                }
            }
        })
    end,

    function(world, e, dt)
        local cooldown = 0.8
        e.player.offensive.remaining = cooldown
        counter = counter + 1

        tiny.addEntity(world, {
            position = {
                x = e.position.x + 8,
                y = e.position.y + 7
            },

            size = {
                w = 2,
                h = 4
            },

            velocity = {
                y = -250,
                x = 0
            },

            shape = {
                identifier = "projectile"..counter,
                z = 2,

                rectangle = {
                    w = 2,
                    h = 4
                },

                fill = {
                    r = 0,
                    g = 255,
                    b = 255,
                    a = 255
                }
            }
        })

        counter = counter + 1
        tiny.addEntity(world, {
            position = {
                x = e.position.x + 24,
                y = e.position.y + 7
            },

            size = {
                w = 2,
                h = 4
            },

            velocity = {
                y = -250,
                x = 0
            },

            shape = {
                identifier = "projectile"..counter,
                z = 2,

                rectangle = {
                    w = 2,
                    h = 4
                },

                fill = {
                    r = 0,
                    g = 255,
                    b = 255,
                    a = 255
                }
            }
        })
    end
}

local function fireLaser(world, e, level)
    lasers[level](world, e)
end

return fireLaser
