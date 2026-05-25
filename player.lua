--create player class
Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("panda.png")

    --moovement
    self.x = 300
    self.y = 20
    self.speed = 500
    self.width = self.image:getWidth()


    function Player:keypressed(key)
    --if space bar is pressed
    if key == "space" then
        --put new instance ng bullet inside ng listofbullet talbe
        table.insert(listOfBullets, Bullet(self.x, self.y))
        end
    end
end

function Player:update(dt)
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    
    elseif love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    end

    --collision out of boundary 
    local window_width = love.graphics.getWidth() -- this gets the width of the window

    --if the x is too far to the left then
    if self.x < 0 then
        self.x = 0

    elseif self.x  + self.width > window_width then -- if the x is too far to the right naman, including our width
        self.x = window_width - self.width -- set x to the window's width

    end

end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
