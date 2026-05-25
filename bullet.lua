Bullet = Object:extend()

function Bullet:new(x, y)
    self.image = love.graphics.newImage("bullet.png")

    --should be moving vertical
    self.x = x
    self.y = y
    --self.speed = 700
    local angleSpeed = 800
    local launcheAngle = math.rad(70) -- 70 degree to rad


    --this will be the calc of initial x and y velo
    self.vx = angleSpeed * math.cos(launcheAngle)

    --to shoot down for vy
    self.vy = angleSpeed * math.sin(launcheAngle) -- now this launches down hopefully, lol 

    --get gravity to pull bullet back down towards postiive y
    self.gravity = 1200


    --collision checking
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

end

function Bullet:checkCollision(obj)
    local self_left = self.x
    local self_right = self.x + self.width
    local self_top = self.y
    local self_bottom = self.y + self.height

    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bottom = obj.y + obj.height

    if self_right > obj_left 
    and self_left < obj_right 
    and self_bottom > obj_top 
    and self_top < obj_bottom then
        self.dead = true
        hits = hits + 1

        --trigger a shake kapag na hit
        shakeDuration = 0.4
        shakeMagnitude = 3
    
        if obj.speed > 0 then
            obj.speed = obj.speed + 50

        else
            obj.speed = obj.speed - 50
        end  -- increase the speed of the enemy when hit by the bullet
    end
end

function Bullet:update(dt)
    --apply gravvity on the y velocity
    self.vy = self.vy +(self.gravity * dt) --pababa

    --upddte pos based sa current vel
    self.x = self.x + (self.vx * dt) -- with gravity
    self.y = self.y + (self.vy * dt) 


    -- remove the bullets if itgoess of the screen
    if self.y > love.graphics.getHeight() or self.x > love.graphics.getWidth()then
        love.load() -- this will mark the bullet for removal when it goes off screen
    end

--removed this to changed with the new changes above
    --if self.y > love.graphics.getHeight() then
    --    love.load() -- this restarts the game when we miss enemy
    --end

    
end

function Bullet:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

