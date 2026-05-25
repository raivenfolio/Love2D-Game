-- vx = v cos(theta)
-- vy = v sin(theta)
--initial velocity

function love.load()
    Object = require "classic"
    require "player"
    require "enemy"
    require "bullet"


    player = Player() --instantiate here
    enemy = Enemy()
    listOfBullets = {} 

    hits = 0
    gameFont = love.graphics.newFont(36) -- make the shi bigger
    love.graphics.setFont(gameFont)

    shakeDuration = 0
    shakeMagnitude = 0



end

function love:keypressed(key)
    player:keypressed(key) -- call the keypressed function inside the player class    
end 

function love.update(dt)

    if shakeDuration > 0 then
        shakeDuration = shakeDuration - dt -- decreate the shake timer every framae
    end

    player:update(dt)
    enemy:update(dt)
    
    for i =#listOfBullets,1,-1 do
        local everybullet = listOfBullets[i]
        everybullet:update(dt)
        everybullet:checkCollision(enemy) -- each bullet will check collision with the enemy

        if everybullet.dead then
            table.remove(listOfBullets, i)
        end
    end 
end

function love.draw()

    love.graphics.push() -- camera shake

    -- this will shake in random amounts
    if shakeDuration > 0 then
        local dx = love.math.random(-shakeMagnitude, shakeMagnitude)
        local dy = love.math.random(-shakeMagnitude, shakeMagnitude)
        love.graphics.translate(dx, dy)
    end

    player:draw()
    enemy:draw()

    love.graphics.print("Hits: " .. hits, 10, 10)
    

    for i, everybullet in ipairs(listOfBullets) do
        everybullet:draw()
    end

    --end camera transformation
    love.graphics.pop()

end