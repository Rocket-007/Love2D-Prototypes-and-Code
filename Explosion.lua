function love.load()

local cImg = love.graphics.newImage("imgs/tilee3.png" )
cTmp = love.graphics.newParticleSystem(cImg,29)
cTmp: setAreaSpread( "uniform" , 10, 10)
cTmp: setEmissionRate(299)
cTmp: setEmitterLifetime( 0.1 )
cTmp: setLinearAcceleration( 0, 125, 0, 125 )
cTmp: setParticleLifetime(1 )
cTmp: setRadialAcceleration(- 1, - 400 )
cTmp: setRotation(-math.pi, math.pi)
cTmp: setSpeed( 300 , 300)
cTmp: setSpread( 4*math.pi)
cTmp: setSpin(-math.pi, math.pi)
cTmp: setSizes(0.1, 0.1)
cTmp: setSizeVariation( 1)
end

function love.mousemoved (x, y, dx, dy)
-- To move the particles along with the emitter, do thisoffset in love.graphics.draw instead of setPosition
   cTmp:setPosition(x, y)
end

function love.update (dt)
cTmp:update(dt)
end

function love.draw ()
   love.graphics.setBlendMode( "add" )
love.graphics.draw(cTmp)
end