camera = {}
camera.x = -100
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0
camera.speed= 100

function camera:set()
love.graphics.push()
love.graphics.rotate(-self.rotation)
love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
love.graphics.pop()
end