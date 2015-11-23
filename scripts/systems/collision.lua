--collision.lua

local tiny = require "scripts/tiny"

local maxDepth = 5
local maxObjects = 3

local function isOverlapping(x1, y1, w1, h1, x2, y2, w2, h2)
    return (x1 < (x2 + w2))
       and ((x1 + w1) > x2)
       and (y1 < (y2 + h2))
       and ((y1 + h1) > y2)
end

local function createQuadTree(depth, x, y, width, height)
    local objects = {}
    local objectCount = 0
    local children = nil

    local childWidth = math.floor(width / 2)
    local childHeight = math.floor(height / 2)

    local function isLeaf()
        return children == nil
    end

    local function subDivide()
        if isLeaf() and depth < maxDepth then
            children = {
                createQuadTree(depth + 1, x,              y,               childWidth, childHeight), --NE child
                createQuadTree(depth + 1, x + childWidth, y,               childWidth, childHeight), --NW child
                createQuadTree(depth + 1, x,              y + childHeight, childWidth, childHeight), --SE child
                createQuadTree(depth + 1, x + childWidth, y + childHeight, childWidth, childHeight)  --SW child
            }
        end
    end

    local quadTree = {
        getBoundingBox = function()
            return x, y, width, height
        end,

        getCount = function()
            if isLeaf() then
                return objectCount
            else
                local count = 0

                for _, child in pairs(children) do
                    count = count + child.getCount()
                end

                return count
            end
        end,

        addObject = function(object)
            if isLeaf() then
                if objectCount == maxObjects and depth < maxDepth then
                    subDivide()
                else
                    objects[object] = object
                    objectCount = objectCount + 1

                    return
                end
            end


            for _, child in pairs(children) do
                local x1, y1, w1, h1 = child.getBoundingBox()
                local x2, y2, w2, h2 = object.position.x, object.position.y, object.size.w, object.size.h

                if isOverlapping(x1, y1, w1, h1, x2, y2, w2, h2) then
                    child.addObject(object)
                end
            end
        end,

        removeObject = function(object)
            if isLeaf() and objects[object] ~= nil then
                objects[object] = nil
                objectCount = objectCount - 1
            else
                local count = 0
                for _, child in pairs(children) do
                    child.removeObject(object)
                    count = count + child.getCount()
                end

                --Collapse if all child nodes are empty
                if count ~= 0 then
                    children = nil
                    objects = {}
                    objectCount = 0
                end
            end
        end,

        query(object)
            if isLeaf() then
                return objects
            else
                local result = {}

                for _, child in pairs(children) do
                    local x1, y1, w1, h1 = child.getBoundingBox()
                    local x2, y2, w2, h2 = object.position.x, object.position.y, object.size.w, object.size.h

                    if isOverlapping(x1, y1, w1, h1, x2, y2, w2, h2) then
                        for _, childObject in child.query(object) do
                            if childObject ~= object then
                                table.insert(result, childObject)
                            end
                        end
                    end
                end

                return result
            end
        end
    }

    return quadTree
end

local function createCollisionSystem()
    local collisionSystem = tiny.processingSystem()
    collisionSystem.filter = tiny.requireAll("position", "size", tiny.rejectAny("background", "particle"))
    local qt = nil

    function collisionSystem:preProcess(dt)
        qt = createQuadTree(0, 0, 0, 800, 600)

        for _, e in pairs(self.entities) do
            qt.addObject(e)
        end
    end

    function collisionSystem:process(e1, dt)
        for _, e2 in qt.query(e1) do
            if e1 ~= e2 then
                local x1, y1, w1, h1 = e1.position.x, e1.position.y, e1.size.w, e1.size.h
                local x2, y2, w2, h2 = e2.position.x, e2.position.y, e2.size.w, e2.size.h
                if isOverlapping(x1, y1, w1, h1, x2, y2, w2, h2) then
                    --Collision
                    print("collision")
                end
            end
        end
    end

    function collisionSystem:postProcess(dt)
        qt = nil
    end

    return collisionSystem
end

return createCollisionSystem
