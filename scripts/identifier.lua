--identifier.lua

local idCounter = 1

local function generateIdentifier(s)
    idCounter = idCounter + 1
    return s..idCounter
end

return generateIdentifier
