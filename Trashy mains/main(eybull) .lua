
function love.draw()
love.graphics.setColor ( 1 , 1, 1 )
love.graphics.circle ( 'fill' , 200 , 200 , 50)
love.graphics.setColor ( 0 , 0, .4 )
love.graphics.circle ( 'fill' , 200 , 200 , 15)
end



function love.draw()
local eyeX = 200
local eyeY = 200
local distanceX = love.mouse.getX () - eyeX
local distanceY = love.mouse.getY () - eyeY
love.graphics.setColor ( 1 , 1, 1 )
love.graphics.circle ( 'fill' , eyeX, eyeY, 50)
love.graphics.setColor ( 0 , 0, .4 )
love.graphics.circle ( 'fill' , 200 , 200 , 15)
love.graphics.setColor ( 1 , 1, 1 )
love.graphics.print ( table.concat ({
'111', 
'111', 
'distance x: ' .. distanceX ,
'distance y: ' .. distanceY ,
}, '\n' ))
end



function love.draw()
-- etc.
local distance = math.sqrt ( tonumber (distanceX)  ^ 2 + tonumber (distanceY)  ^ 2 )
-- etc.
love.graphics.print ( table.concat ({
'distance x: ' .. distanceX ,
'distance y: ' .. distanceY ,
'distance: ' .. distance,
}, '\n' ))
end




function love.draw()
-- etc.
local angle = math.atan2 ( distanceY , distanceX )
-- etc.
love.graphics.print ( table.concat ({
'distance x: ' .. distanceX ,
'distance y: ' .. distanceY ,
'distance: ' .. distance,
'angle: ' .. angle ,
}, '\n' ))
end





function love.draw()
-- etc.
local pupilX = eyeX + ( math.cos (angle ) * distance)
local pupilY = eyeY + ( math.sin (angle ) * distance)
-- etc.
love.graphics.setColor ( 0 , 0, .4 )
love.graphics.circle ( 'fill' , pupilX, pupilY, 15)
-- etc.
love.graphics.print ( table.concat ({
'distance x: ' .. distanceX ,
'distance y: ' .. distanceY ,
'distance: ' .. distance,
'angle: ' .. angle ,
'cos(angle): ' .. math.cos ( angle ),
'sin(angle): ' .. math.sin ( angle ),
}, '\n' ))
end






function love.draw()
-- etc.
local distance = math.min ( math.sqrt ( distanceX ^2 + distanceY^ 2 ) , 30)
-- etc.
end




function love.draw()
function drawEye( eyeX, eyeY)
local distanceX = love.mouse.getX () - eyeX
local distanceY = love.mouse.getY () - eyeY
local distance = math.min ( math.sqrt ( distanceX ^2 + distanceY^ 2 ), 30)
local angle = math.atan2 ( distanceY , distanceX )
local pupilX = eyeX + ( math.cos (angle ) * distance)
local pupilY = eyeY + ( math.sin (angle ) * distance)
love.graphics.setColor ( 1 , 1, 1 )
love.graphics.circle ( 'fill' , eyeX, eyeY, 50)
love.graphics.setColor ( 0 , 0, .4 )
love.graphics.circle ( 'fill' , pupilX, pupilY, 15)
end
drawEye (200 , 200 )
drawEye (330 , 200 )
end

