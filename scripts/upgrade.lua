--upgrade.lua

local lasers = {
    [2] = function(e)
        
    end,

    [3] = function(e)

    end
}

local function setLaserLevel(e, level)
    lasers[level](e)
end

local engines = {
    [2] = function(e)
        e.sprite.clip.offset = 102
        e.emitter.sources = {
            engine = {
                rate = 15,
                temporary = {0.05, 0.1, 0.05},
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
        e.sprite.clip.offset = 102
        e.emitter.sources = {
            engine = {
                rate = 25,
                temporary = {0.05, 0.2, 0.05},
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
        e.sprite.clip.offset = 204
        e.emitter.sources = {
            leftEngine = {
                rate = 20,
                temporary = {0.05, 0.1, 0.05},
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
                temporary = {0.05, 0.1, 0.05},
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
        e.sprite.clip.offset = 204
        e.emitter.sources = {
            leftEngine = {
                rate = 25,
                temporary = {0.05, 0.2, 0.05},
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
                temporary = {0.05, 0.2, 0.05},
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
        e.sprite.clip.offset = 306
        e.emitter.sources = {
            engine = {
                rate = 1,
                temporary = {0.05, 0.3, 0.05},
                rotate = false,

                offset = {
                    x = {11, 22},
                    y = 24
                },

                size = {
                    w = 1,
                    h = 2
                },

                velocity = {
                    x = 0,
                    y = {30, 60}
                },

                color = {
                    r = 0,
                    g = 255,
                    b = 0,
                    a = 255
                }
            }
        }
    end,

    [7] = function(e)
        e.sprite.clip.offset = 306
        e.emitter.sources = {
            centerEngine = {
                rate = 50,
                temporary = {0.05, 0.2, 0.05},
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
                temporary = {0.05, 0.2, 0.05},
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
                temporary = {0.05, 0.2, 0.05},
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

end

return {
    setLaserLevel = setLaserLevel,
    setEngineLevel = setEngineLevel,
    setHullLevel = setHullLevel
}
