--sap.lua

--Sweep and Prune algorithm for broad-phase collision detection
local function createSAP()
    --Continually updated arrays with collidables sorted by starting points projected on X/Y axis
    local horizontalProjection = {}
    local verticalProjection = {}

    local function compare(e1, e2)
        return getBounds(e1).start > getBounds(e2).start
    end

    local function getBoundingRadius(e)
    --Get diagonal length using Pythagorean theorem
        return 0.5 * math.sqrt(e.size.w ^ 2 + e.size.h ^ 2)
    end

    --Insertion sort, efficient with high temporal coherence between frames (O(n) for nearly sorted arrays)
    local function sortProjection(projection)
        for j = 2, #projection do
            local key = projection[j]
            local i = j - 1
            while i > 0 and compare(projection[i], key) do
                projection[i + 1] = projection[i]
                i = i - 1
            end
            projection[i + 1] = key
        end

        return projection
    end

    local function insert(projection, e1)
        for i, e2 in ipairs(projection) do
            if not compare(e1, e2) then
                table.insert(projection, e1, i)
                return
            end
        end

        table.insert(projection, e1)
    end

    local function remove(projection, e1)
        for i, e2 in ipairs(projection) do
            if e1 == e2 then
                table.remove(projection, i)
                return projection
            end
        end
    end

    local function sweep(projection)
        local intersections = {}

        if #projection > 1 then
            local active = {projection[1]}

            for i = 2, #projection do
                local j = 1
                while j <= #active do
                    local start = getBounds(projection[i]).start --FIX
                    local stop = getBounds(active[j]).stop --FIX

                    if start > stop then
                        table.remove(active, j)
                    else
                        table.insert(intersections, {projection[i], active[j]})
                        j = j + 1
                    end
                end

                table.insert(active, projection[i])
            end
        end

        return intersections
    end

    local function prune(horizontalIntersections, verticalIntersections)
        local function compare(c1, c2)
            return (c1[1] == c2[1] and c1[2] == c2[2])
                or (c1[2] == c2[1] and c1[1] == c2[2])
        end

        local candidates = {}

        for _, c1 in ipairs(horizontalIntersections) do
            for _, c2 in ipairs(verticalIntersections) do
                if compare(c1, c2) then
                    table.insert(candidates, c1)
                end
            end
        end

        return candidates
    end

    return {
        insertEntity = function(e1)
            insert(horizontalProjection, e1)
            insert(verticalProjection, e1)
        end,

        removeEntity = function(e)
            remove(horizontalProjection, e1)
            remove(verticalProjection, e1)
        end,

        getCandidates = function()

        end
    }
end

return createSAP