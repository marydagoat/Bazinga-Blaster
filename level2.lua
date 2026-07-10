--level 2 :33
local level2 = {}

--Variables assigned for level 2
local level2Squares = {}
local level2Score = 0

local function spawnLevel2Square()
    local square = {
        x = love.math.random(50, love.graphics.getWidth() - 50)
        y = love.math.random(50, love.graphics.getHeight() - 50)
    }
    table.insert(level2Squares, square)
end 