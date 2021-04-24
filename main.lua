local graphics = love.graphics
local TAU = math.pi * 2

local p, pe

local MS=1
local PSIZE=40

function love.load()
  graphics.setDefaultFilter('linear', 'linear', 4)

  --local p = graphics.newImage "particle.png"

  p = graphics.newCanvas(PSIZE, PSIZE)

  p:renderTo(function()
    --graphics.clear(255,255,255,0)
    --graphics.rectangle('fill', 0, 0, PSIZE, PSIZE)
    graphics.circle('fill', PSIZE/2, PSIZE/2, PSIZE/2-2, 100)
  end)

  --p = graphics.newImage "particle.png"

  --graphics.setBackgroundColor(9, 25, 27)

  pe = {}
  for i=1,2 do
    pe[i] = graphics.newParticleSystem(p, 4096)
    pe[i]:setParticleLifetime(5) -- Particles live at least 2s and at most 5s.
    pe[i]:setEmissionRate(150)
    pe[i]:setSizes(1, 0.1)
    --pe:setSizeVariation(1)
    --pe:setLinearAcceleration(-10*MS, -20*MS, 10*MS, 0) -- Random movement in all directions.
    pe[i]:setLinearDamping(0.4)
    --pe:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.
    pe[i]:setAreaSpread('uniform', 0, graphics.getHeight()/2)
    --pe:setDirection(3/4 * TAU)
    pe[i]:setRotation(0, TAU/4)
  end
  pe[1]:setPosition(-PSIZE/2, graphics.getHeight()/2)
  pe[2]:setPosition(graphics.getWidth()+PSIZE/2, graphics.getHeight()/2)

  pe[1]:setSpeed(600, 400)
  --pe[2]:setSpeed(-150, 0)

	pe[1]:setColors(255, 255, 150, 200,   255, 0, 0, 200,  0, 0, 0, 0)
	pe[2]:setColors(150, 255, 255, 200,   0, 255, 0, 200,   0, 0, 0, 0)

  local w, h = graphics.getDimensions()
  canvas = graphics.newCanvas(w*MS, h*MS)
end

 
function love.update(dt)
  for i=1,2 do pe[i]:update(dt) end
end

function love.draw()
  canvas:renderTo(function()
    --graphics.clear(0,0,0,0.01)

    graphics.setBlendMode('subtract', 'premultiplied') 
    graphics.setColor(1,1,1,5)
    graphics.rectangle('fill', 0, 0, 800*MS, 600*MS)

    graphics.setColor(255,255,255,255)
    --graphics.setColor(255,0,255,255)
    --graphics.setColor(HSL(h, 200, 200, 255))
    graphics.setBlendMode('alpha', 'premultiplied') 
    --for i=1,2 do graphics.draw(pe[i]) end
    graphics.draw(pe[1])
  end)

  graphics.setBlendMode('alpha', 'alphamultiply') 
  graphics.setColor(255,255,255,255)
  --graphics.draw(pe)
  graphics.draw(canvas, 0, 0, 0, 1/MS, 1/MS)
end