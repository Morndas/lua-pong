pad = {}
pad.x = 0
pad.y = 0
pad.width = 20
pad.height = 80
pad.speed = 10

ball = {}
ball.x = 0
ball.y = 0
ball.width = 20
ball.height = 20
ball.speed = 10
ball.x_speed = 30
ball.y_speed = 30

function love.load()
  ball.x = love.graphics.getWidth()/2 - ball.width/2
  ball.y = love.graphics.getHeight()/2 - ball.height/2
end

function love.update()
  if love.keyboard.isDown("down") and pad.y < love.graphics.getHeight() - pad.height then
    pad.y = pad.y + pad.speed
  elseif love.keyboard.isDown("up") and pad.y > 0 then
    pad.y = pad.y - pad.speed
  end
  
  // TODO : ball bouge pas
  ball.x = ball.x + ball.x_speed
  ball.x = ball.y + ball.y_speed
  
  if ball.x == 0 or ball.x == love.graphics.getWidth() then
    ball.x_speed = -ball.x_speed
  end
  if ball.y == 0 or ball.y == love.graphics.getHeight() then
    ball.y_speed = -ball.y_speed
  end
end

function love.draw()
  love.graphics.rectangle("fill", pad.x, pad.y, pad.width, pad.height)
  love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end