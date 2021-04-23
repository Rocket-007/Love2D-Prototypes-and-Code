

function initCanvas (width, height)
--local c = love.graphics.newCanvas(width, height)
--love.graphics.setCanvas(c) -- Switch to drawing oncanvas 'c'
   love.graphics.setBlendMode( "alpha" )
love.graphics.setColor( 255, 255, 255, 255 )
love.graphics.circle( "fill" , width / 2, height / 2, 10, 100)
--love.graphics.setCanvas() -- Switch back to drawing onmain screen
--return c
end
-- Returns particle system with given image andmaximum particles to mimic fire
function initPartSys (image, maxParticles)
local ps = love.graphics.newParticleSystem(image,maxParticles)
   ps:setParticleLifetime( 0.1, 0.5) -- (min, max)
ps:setSizeVariation( 1 )
ps:setLinearAcceleration(200, 2000, -200, -100 ) -- (minX,minY, maxX, maxY)
   ps:setColors( 234 , 217, 30, 128 , 224, 21, 21 , 0) -- (r1, g1,b1, a1, r2, g2, b2, a2 ...)
return ps
end


function loadBlobsmoke ()
--love.window.setTitle( "Left-click to make fire!" )
--local canvas = initCanvas( 20, 40)
--psystem = --initPartSys (canvas, 1500 )
love.graphics.setBlendMode( "alpha" )
love.graphics.setColor( 255, 255, 255, 255 )

local cImg = love.graphics.newImage("imgs/tilee3.png" )
cTmp = love.graphics.newParticleSystem(cImg,29)
  cTmp:setParticleLifetime( 0.1, 0.5) -- (min, max)
cTmp:setSizeVariation( 1 )
cTmp:setLinearAcceleration(200, 2000, -200, -100 ) -- (minX,minY, maxX, maxY)
 cTmp:setColors( 234 , 217, 30, 128 , 224, 21, 21 , 0) -- (r1, g1,b1, a1, r2, g2, b2, a2 ...)

--cTmp: setAreaSpread( "uniform" , 10, 10)
--cTmp: setEmissionRate(299)
--cTmp: setEmitterLifetime( 0.1 )
--cTmp: setLinearAcceleration( 0, 125, 0, 125 )
--cTmp: setParticleLifetime(1 )
--cTmp: setRadialAcceleration(- 1, - 400 )
--cTmp: setRotation(-math.pi, math.pi)
--cTmp: setSpeed( 300 , 300)
--cTmp: setSpread( 4*math.pi)
--cTmp: setSpin(-math.pi, math.pi)
--cTmp: setSizes(0.1, 0.1)
--cTmp: setSizeVariation( 1)

end

function updateBlobsmoke(self,dt)
-- Only emit particles when left mouse button is down
--psystem:setDirection(2)

cTmp:setPosition(self.x,self.y)
if not self.onGround then
cTmp:setEmissionRate( 3000 )
else
cTmp:setEmissionRate( 0)
end
-- Particle system should usually be updated fromwithin love.update
   cTmp:update(dt)
end
function drawBlobSmoke()
--love.graphics.draw( psystem, player.xPos ,player.yPos )
-- Try different blend modes out - https://love2d.org/wiki/BlendMode
   love.graphics.setBlendMode( "add" )
-- Redraw particle system every frame
love.graphics.draw(cTmp)
end