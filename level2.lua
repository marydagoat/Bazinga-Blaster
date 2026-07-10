currentLevel = 0

-- Runs once when the game starts
function love.load()
    -- 1. Load your PNG image (remember the png needs to be inside ur game folder)
    playerImage = love.graphics.newImage("sheldon.jpg")

    --collect sound load--
    collectSound = love.audio.newSource("bazinga.mp3", "static")
    
    
    
    
    
    
    -- Size scaling 
    playerScale = 0.27

    -- Create variables for player position
    playerX = 100
    playerY = 100
    playerSpeed = 900
    
    -- Calculate scaled player dimensions for collision detection
    playerWidth = playerImage:getWidth() * playerScale
    playerHeight = playerImage:getHeight() * playerScale

    -- Score Counter
    score = 0

    -- Table to hold our collectible squares
    squares = {}
    
    -- Spawn initial squares
    for i = 1, 5 do
        spawnSquare()
    end
end


-- Function to create a new square at a random position
function spawnSquare()
    local square = {
        x = love.math.random(50, love.graphics.getWidth() - 50),
        y = love.math.random(50, love.graphics.getHeight() - 50),
        size = 20
    }
    table.insert(squares, square)
end

-- Simple AABB collision detection function
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
end

-- Runs every frame (dt stands for "delta time", the time since the last frame)
function love.update(dt)
    -- Move left/right&up/down with arrow keys
    if love.keyboard.isDown("right") then
        playerX = playerX + playerSpeed * dt
    elseif love.keyboard.isDown("left") then
        playerX = playerX - playerSpeed * dt
    end

    if love.keyboard.isDown("down") then
        playerY = playerY + playerSpeed * dt
    elseif love.keyboard.isDown("up") then
        playerY = playerY - playerSpeed * dt
    end

    -- --- BOUNDARY CHECKS ---
    -- Left wall
    if playerX < 0 then
        playerX = 0
    -- Right wall
    elseif playerX > love.graphics.getWidth() - playerWidth then
        playerX = love.graphics.getWidth() - playerWidth
    end

    -- Top wall
    if playerY < 0 then
        playerY = 0
    -- Bottom wall
    elseif playerY > love.graphics.getHeight() - playerHeight then
        playerY = love.graphics.getHeight() - playerHeight
    end
    -- -------------------------------------------------

    -- Check for collisions with squares (looping backwards safely for removal)
    for i = #squares, 1, -1 do
        local s = squares[i]
        if checkCollision(playerX, playerY, playerWidth, playerHeight, s.x, s.y, s.size, s.size) then
            table.remove(squares, i) -- Remove the collected square
            score = score + 1-- Increase score
            collectSound:clone():play() --bazinga sound
            spawnSquare()            -- Spawn a new one somewhere else!
        end
    end
end

-- Runs every frame to draw graphics on screen
function love.draw()
    -- Draw the collectible squares (Green squares)
    love.graphics.setColor(0, 1, 0) -- Set color to green
    for i, s in ipairs(squares) do
        love.graphics.rectangle("fill", s.x, s.y, s.size, s.size)
    end

    -- 2. Reset color to full white so your PNG retains its original colors
    love.graphics.setColor(1, 1, 1) 
    
    -- 3. Draw your PNG sprite at the player's position with scaling factors applied
    love.graphics.draw(playerImage, playerX, playerY, 0, playerScale, playerScale)
    
    -- Draw UI Text (Score and Instructions)
    love.graphics.setColor(1, 1, 1) -- Ensure text is white
    love.graphics.print("Use Arrow Keys to move!", 10, 10)
    love.graphics.print("Squares Collected: " .. score, 10, 30)
    --print level
  love.graphics.print("Level: " .. tostring(currentLevel+2), 10,50)
end

return level2