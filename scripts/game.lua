--game.lua

local tiny = require "scripts/tiny"
local systems = require "scripts/systems/systems"

local function createGame(stopCallback)
    local gameWorld = tiny.world()

    --Semi-transparent rectangle overlay
    interface.createRectangle("pauseOverlay", 800, 600)
    interface.setShapeFillColor("pauseOverlay", 0, 0, 0, 128)
    interface.setShapePosition("pauseOverlay", 0, 0)

    interface.loadSprite("pauseBox", "data/sprites/pausebox.tga")
    interface.setSpritePosition("pauseBox", 200, 200)

    local isPaused = false

    local function isRenderSystem(_, system)
        return system._isRender
    end

    return {
        start = function(level)
            isPaused = false

            --Create and register systems
            for _, createSystem in pairs(systems) do
                tiny.addSystem(gameWorld, createSystem())
            end

            tiny.refresh(gameWorld)

            --Test explosion
            tiny.addEntity(gameWorld, {
                position = {
                    x = 200,
                    y = 200
                },

                lifetime = 0.5,

                emitter = {
                    sources = {
                        {
                            rate = 200,
                            lifetime = {0.1, 1.0, 0.1},
                            rotate = true,

                            offset = {
                                x = 0,
                                y = 0
                            },

                            size = {
                                w = {1, 2},
                                h = {1, 5}
                            },

                            velocity = {
                                x = {-100, 100},
                                y = {-100, 100}
                            },

                            color = {
                                r = 255,
                                g = {50, 255},
                                b = 0,
                                a = 255
                            }
                        }
                    }
                }
            })
        end,

        stop = function()
            tiny.clearEntities(gameWorld)
            tiny.clearSystems(gameWorld)
        end,

        update = function(dt)
            if isPaused then
                tiny.update(gameWorld, dt, isRenderSystem)
                interface.drawShape("pauseOverlay")
                interface.drawSprite("pauseBox")
            else
                tiny.update(gameWorld, dt)
            end
        end,

        input = function(k)
            if k == "p" then
                isPaused = not isPaused
            elseif k == "escape" then
                stopCallback()
            end
        end
    }
end

return createGame
