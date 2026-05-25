function love.load()
    Object = require "classic"
    require "player"
    require "enemy"
    require "bullet"


    player = Player() --instantiate here
    enemy = Enemy()
    listOfBullets = {} 
end

function love:keypressed(key)
    player:keypressed(key) -- call the keypressed function inside the player class    
end 

function love.update(dt)
    player:update(dt)
    enemy:update(dt)
    
    for i,everybullet in ipairs(listOfBullets) do
        everybullet:update(dt)
        everybullet:checkCollision(enemy) -- each bullet will check collision with the enemy

        if everybullet.dead then
            table.remove(listOfBullets, i)
        end
    end 
end

function love.draw()
    player:draw()
    enemy:draw()
    

    for i, everybullet in ipairs(listOfBullets) do
        everybullet:draw()
    end

end