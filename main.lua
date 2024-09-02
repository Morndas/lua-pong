padL = {}
padL.x = 0
padL.y = 0
padL.width = 20
padL.height = 80
padL.speed = 10

padR = {}
padR.x = 0
padR.y = 0
padR.width = 20
padR.height = 80
padR.speed = 10

ball = {}
ball.x = 0
ball.y = 0
ball.width = 20
ball.height = 20
ball.x_speed = 5
ball.y_speed = 5

scorePlayerL = 0
scorePlayerR = 0

function centerBall()
  ball.x = love.graphics.getWidth()/2 - ball.width/2
  ball.y = love.graphics.getHeight()/2 - ball.height/2
  ball.x_speed = 5
  ball.y_speed = 5
end

function love.load()
  -- On positionne les deux raquettes aux bonnes coordonnées selon la taille de la fenêtre
  padL.x = 0
  padL.y = 0
  padR.x = love.graphics.getWidth() - padR.width
  padR.y = love.graphics.getHeight() - padR.height
  
  centerBall()
end

function love.update()
  -- Gestion du déplacement de la raquette gauche
  if love.keyboard.isDown("s") and padL.y < (love.graphics.getHeight() - padL.height) then
    padL.y = padL.y + padL.speed
  elseif love.keyboard.isDown("z") and padL.y > 0 then
    padL.y = padL.y - padL.speed
  end
  -- Gestion du déplacement de la raquette droite
  if love.keyboard.isDown("down") and padR.y < (love.graphics.getHeight() - padR.height) then
    padR.y = padR.y + padR.speed
  elseif love.keyboard.isDown("up") and padR.y > 0 then
    padR.y = padR.y - padR.speed
  end
  
  -- Calcul de la position de la balle
  ball.x = ball.x + ball.x_speed
  ball.y = ball.y + ball.y_speed
  
  local hasTouchedPadL = ball.x <= (padL.x + padL.width) and ball.y < (padL.y + padL.height) and (ball.y + ball.height) > padL.y
  local hasTouchedPadR = (ball.x + ball.width) >= padR.x and ball.y < (padR.y + padR.height) and (ball.y + ball.height) > padR.y
  local hasTouchedLeftEdge = not hasTouchedPadL and ball.x <= 0
  local hasTouchedRightEdge = not hasTouchedPadR and (ball.x + ball.width) >= love.graphics.getWidth()
  
  -- Si la balle ricoche contre une raquette
  if hasTouchedPadL or hasTouchedPadR then
    -- Inversion de la vitesse X de la balle
    ball.x_speed = -ball.x_speed
    
    -- Repositionnement de la balle aux coordonnées X de collision avec la raquette
    if hasTouchedPadL then
      ball.x = padL.x + padL.width
    elseif hasTouchedPadR then
      ball.x = padR.x - ball.width
    end
  -- Sinon, si la balle sort du bord gauche/droite de l'écran -> Game Over pour l'un des joueurs
  elseif hasTouchedLeftEdge or hasTouchedRightEdge then
    -- Calcul des scores selon le bord touché
    scorePlayerL = hasTouchedRightEdge and scorePlayerL+1 or scorePlayerL
    scorePlayerR = hasTouchedLeftEdge and scorePlayerR+1 or scorePlayerR
    -- On recentre la balle
    centerBall()
  end
  
  -- Si la balle ricoche contre le bord inférieur ou supérieur de l'écran
  if ball.y <= 0 or ball.y >= love.graphics.getHeight() - ball.height then
    -- Inversion de la vitesse Y de la balle
    ball.y_speed = -ball.y_speed
  end
end

function love.draw()
  love.graphics.rectangle("fill", padL.x, padL.y, padL.width, padL.height) -- Raquette gauche
  love.graphics.rectangle("fill", padR.x, padR.y, padR.width, padR.height) -- Raquette droite
  love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height) -- balle
  
  -- Affichage du score au mileu en haut de l'écran
  local scores = scorePlayerL.." - "..scorePlayerR
  local scoresWidth = love.graphics.getFont():getWidth(scores)
  love.graphics.print(scores, (love.graphics.getWidth()/2 - scoresWidth/2), 0)
end