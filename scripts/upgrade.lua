--upgrade.lua

--Import tiny-ecs
local tiny = require "scripts/tiny"

local lasers = {
    [1] = function(e)
        e.player.spriteOffset.y = 0
        e.player.fire = function(world, e)
            e.player.cooldown = 1.2

            tiny.addEntity(world, {
                position = {
                    x = e.position.x + 19,
                    y = e.position.y
                },

                size = {
                    w = 2,
                    h = 4
                },

                velocity = {
                    x = 0,
                    y = -200
                },

                shape = {
                    identifier = interface.getUniqueIdentifier(),
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
    end,

    [2] = function(e)
        e.player.spriteOffset.y = 25
        e.player.fire = function(world, e)
            e.player.cooldown = 0.8

            local x, y = e.position.x, e.position.y

            local size = {
                w = 2,
                h = 4
            }

            local velocity = {
                x = 0,
                y = -250
            }

            local color = {
                r = 0,
                g = 255,
                b = 255,
                a = 255
            }

            tiny.addEntity(world, {
                position = {
                    x = x + 8,
                    y = y + 7
                },

                size = size,
                velocity = velocity,

                shape = {
                    identifier = interface.getUniqueIdentifier(),
                    z = 2,

                    rectangle = size,
                    fill = color
                }
            })

            tiny.addEntity(world, {
                position = {
                    x = x + 24,
                    y = y + 7
                },

                size = size,
                velocity = velocity,

                shape = {
                    identifier = interface.getUniqueIdentifier(),
                    z = 2,

                    rectangle = size,
                    fill = color
                }
            })
        end
    end,

    [3] = function(e)
        e.player.spriteOffset.y = 50
        e.player.fire = function(world, e)
            e.player.cooldown = 0.6

            local x, y = e.position.x, e.position.y

            local size = {
                w = 2,
                h = 4
            }

            local velocity = {
                x = 0,
                y = -250
            }

            local color = {
                r = 255,
                g = 0,
                b = 0,
                a = 255
            }

            local function spawn(position)
                tiny.addEntity(world, {
                    position = position,
                    size = size,
                    velocity = velocity,

                    shape = {
                        identifier = interface.getUniqueIdentifier(),
                        z = 2,
                        rectangle = size,
                        fill = color
                    }
                })
            end

            spawn {x = x + 8, y = y + 7}
            spawn {x = x + 24, y = y + 7}
            spawn {x = x + 3, y = y + 8}
            spawn {x = x + 29, y = y + 8}
        end
    end,

    [4] = function(e)
        e.player.spriteOffset.y = 50
        e.player.fire = function(world, e)
            e.player.cooldown = 0.4

            local x, y = e.position.x, e.position.y

            local size = {
                w = 2,
                h = 4
            }

            local color = {
                r = 255,
                g = 0,
                b = 0,
                a = 255
            }

            local function spawn(position, velocity)
                tiny.addEntity(world, {
                    position = position,
                    size = size,
                    velocity = velocity,

                    shape = {
                        identifier = interface.getUniqueIdentifier(),
                        z = 2,
                        rectangle = size,
                        fill = color
                    }
                })
            end

            spawn({x = x + 16, y = y}, {x = 0, y = -250})
            spawn({x = x + 8, y = y + 7}, {x = -15, y = -250})
            spawn({x = x + 24, y = y + 7}, {x = 15, y = -250})
            spawn({x = x + 3, y = y + 8}, {x = -20, y = -250})
            spawn({x = x + 29, y = y + 8}, {x = 20, y = -250})
        end
    end,

    [5] = function(e)
        e.player.spriteOffset.y = 75
        e.player.fire = function(world, e)
            e.player.cooldown = 0.3

            local x, y = e.position.x, e.position.y

            local size = {
                w = 2,
                h = 4
            }

            local color = {
                r = 0,
                g = 255,
                b = 0,
                a = 255
            }

            local function spawn(position, velocity)
                tiny.addEntity(world, {
                    position = position,
                    size = size,
                    velocity = velocity,

                    shape = {
                        identifier = interface.getUniqueIdentifier(),
                        z = 2,
                        rectangle = size,
                        fill = color
                    }
                })
            end

            spawn({x = x + 16, y = y}, {x = 0, y = -250})
            spawn({x = x + 7, y = y + 4}, {x = -15, y = -250})
            spawn({x = x + 7, y = y + 4}, {x = -30, y = -250})
            spawn({x = x + 25, y = y + 4}, {x = 15, y = -250})
            spawn({x = x + 25, y = y + 4}, {x = 30, y = -250})
        end
    end,

    [6] = function(e)
        e.player.spriteOffset.y = 100
        e.player.fire = function(world, e)
            e.player.cooldown = 0.3

            local x, y = e.position.x, e.position.y

            local size = {
                w = 2,
                h = 4
            }

            local color = {
                r = 0,
                g = 255,
                b = 0,
                a = 255
            }

            local function spawn(position, velocity)
                tiny.addEntity(world, {
                    position = position,
                    size = size,
                    velocity = velocity,

                    shape = {
                        identifier = interface.getUniqueIdentifier(),
                        z = 2,
                        rectangle = size,
                        fill = color
                    }
                })
            end

            spawn({x = x + 16, y = y}, {x = 0, y = -250})
            spawn({x = x + 7, y = y + 4}, {x = -15, y = -250})
            spawn({x = x + 7, y = y + 4}, {x = -30, y = -250})
            spawn({x = x + 25, y = y + 4}, {x = 15, y = -250})
            spawn({x = x + 25, y = y + 4}, {x = 30, y = -250})
            spawn({x = x + 2, y = y + 5}, {x = -45, y = -250})
            spawn({x = x + 2, y = y + 5}, {x = -60, y = -250})
            spawn({x = x + 30, y = y + 5}, {x = 45, y = -250})
            spawn({x = x + 30, y = y + 5}, {x = 60, y = -250})
        end
    end,

    [7] = function(e)
        e.player.spriteOffset.y = 125
        e.player.fire = function(world, e)
            e.player.cooldown = 0.2

            local x, y = e.position.x, e.position.y

            local size = {
                w = 2,
                h = 4
            }

            local function spawn(position, velocity, z)
                tiny.addEntity(world, {
                    position = position,
                    size = size,
                    velocity = velocity,

                    shape = {
                        identifier = interface.getUniqueIdentifier(),
                        z = z,
                        rectangle = size,
                        fill = {
                            r = math.random(150, 255),
                            g = math.random(150, 255),
                            b = math.random(150, 255),
                            a = 255
                        }
                    }
                })
            end

            spawn({x = x + 16, y = y}, {x = 0, y = -250}, 2)
            spawn({x = x + 7, y = y + 4}, {x = -15, y = -250}, 2)
            spawn({x = x + 7, y = y + 4}, {x = -30, y = -250}, 2)
            spawn({x = x + 25, y = y + 4}, {x = 15, y = -250}, 2)
            spawn({x = x + 25, y = y + 4}, {x = 30, y = -250}, 2)
            spawn({x = x + 2, y = y + 5}, {x = -45, y = -250}, 2)
            spawn({x = x + 2, y = y + 5}, {x = -60, y = -250}, 2)
            spawn({x = x + 30, y = y + 5}, {x = 45, y = -250}, 2)
            spawn({x = x + 30, y = y + 5}, {x = 60, y = -250}, 2)
            spawn({x = x + 16, y = y + 12}, {x = -100, y = -250}, e.sprite.z + 1)
            spawn({x = x + 16, y = y + 12}, {x = 100, y = -250}, e.sprite.z + 1)
        end
    end
}

local function setLaserLevel(e, level)
    lasers[level](e)
end

local engines = {
    [1] = function(e)
        e.player.spriteOffset.x = 0
        e.emitter.sources = {
            engine = {
                rate = 15,
                lifetime = {0.05, 0.1, 0.05},
                rotate = false,

                offset = {
                    x = {18, 21},
                    y = 46
                },

                size = {
                    w = {1, 2},
                    h = {1, 2}
                },

                velocity = {
                    x = 0,
                    y = {25, 75}
                },

                color = {
                    r = {200, 255},
                    g = 0,
                    b = 0,
                    a = 255
                }
            }
        }
    end,

    [2] = function(e)
        e.player.spriteOffset.x = 102
        e.emitter.sources = {
            engine = {
                rate = 15,
                lifetime = {0.05, 0.1, 0.05},
                rotate = false,

                offset = {
                    x = {15, 18},
                    y = 24
                },

                size = {
                    w = {1, 2},
                    h = {1, 2}
                },

                velocity = {
                    x = {-10, 10},
                    y = {50, 125}
                },

                color = {
                    r = 255,
                    g = {50, 255},
                    b = 0,
                    a = 255
                }
            }
        }
    end,

    [3] = function(e)
        e.player.spriteOffset.x = 102
        e.emitter.sources = {
            engine = {
                rate = 25,
                lifetime = {0.05, 0.2, 0.05},
                rotate = false,

                offset = {
                    x = {14, 19},
                    y = 24
                },

                size = {
                    w = {1, 2},
                    h = {1, 2}
                },

                velocity = {
                    x = {-15, 15},
                    y = {75, 150}
                },

                color = {
                    r = 255,
                    g = {150, 255},
                    b = 0,
                    a = 255
                }
            }
        }
    end,

    [4] = function(e)
        e.player.spriteOffset.x = 204
        e.emitter.sources = {
            leftEngine = {
                rate = 20,
                lifetime = {0.05, 0.1, 0.05},
                rotate = false,

                offset = {
                    x = {9, 12},
                    y = 24
                },

                size = {
                    w = {1, 2},
                    h = {1, 2}
                },

                velocity = {
                    x = {-10, 10},
                    y = {50, 125}
                },

                color = {
                    r = 255,
                    g = {50, 255},
                    b = 0,
                    a = 255
                }
            },

            rightEngine = {
                rate = 20,
                lifetime = {0.05, 0.1, 0.05},
                rotate = false,

                offset = {
                    x = {20, 23},
                    y = 24
                },

                size = {
                    w = {1, 2},
                    h = {1, 2}
                },

                velocity = {
                    x = {-10, 10},
                    y = {50, 125}
                },

                color = {
                    r = 255,
                    g = {50, 255},
                    b = 0,
                    a = 255
                }
            }
        }
    end,

    [5] = function(e)
        e.player.spriteOffset.x = 204
        e.emitter.sources = {
            leftEngine = {
                rate = 25,
                lifetime = {0.05, 0.2, 0.05},
                rotate = false,

                offset = {
                    x = {9, 13},
                    y = 24
                },

                size = {
                    w = {1, 2},
                    h = {1, 2}
                },

                velocity = {
                    x = {-15, 15},
                    y = {75, 150}
                },

                color = {
                    r = 255,
                    g = {150, 255},
                    b = 0,
                    a = 255
                }
            },

            rightEngine = {
                rate = 25,
                lifetime = {0.05, 0.2, 0.05},
                rotate = false,

                offset = {
                    x = {20, 24},
                    y = 24
                },

                size = {
                    w = {1, 2},
                    h = {1, 2}
                },

                velocity = {
                    x = {-15, 15},
                    y = {75, 150}
                },

                color = {
                    r = 255,
                    g = {150, 255},
                    b = 0,
                    a = 255
                }
            }
        }
    end,

    [6] = function(e)
        e.player.spriteOffset.x = 306
        e.emitter.sources = {
            centerEngine = {
                rate = 50,
                lifetime = {0.05, 0.2, 0.05},
                rotate = false,

                offset = {
                    x = {14, 19},
                    y = 24
                },

                size = {
                    w = 2,
                    h = 2
                },

                velocity = {
                    x = {-15, 15},
                    y = {75, 150}
                },

                color = {
                    r = 255,
                    g = {200, 255},
                    b = 0,
                    a = 255
                }
            },

            leftEngine = {
                rate = 20,
                lifetime = {0.05, 0.2, 0.05},
                rotate = false,

                offset = {
                    x = {11, 13},
                    y = 24
                },

                size = {
                    w = {1, 2},
                    h = {1, 2}
                },

                velocity = {
                    x = {-15, 15},
                    y = {50, 125}
                },

                color = {
                    r = 255,
                    g = {50, 150},
                    b = 0,
                    a = 255
                }
            },

            rightEngine = {
                rate = 20,
                lifetime = {0.05, 0.2, 0.05},
                rotate = false,

                offset = {
                    x = {20, 22},
                    y = 24
                },

                size = {
                    w = {1, 2},
                    h = {1, 2},
                },

                velocity = {
                    x = {-15, 15},
                    y = {50, 125}
                },

                color = {
                    r = 255,
                    g = {50, 150},
                    b = 0,
                    a = 255
                }
            }
        }
    end
}

local function setEngineLevel(e, level)
    engines[level](e)
end

local function setHullLevel(e, level)
    e.player.hp.max = 100 + (level * 25)
end

return {
    setLaserLevel = setLaserLevel,
    setEngineLevel = setEngineLevel,
    setHullLevel = setHullLevel
}
