require('camera')
function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  camera:setBounds(0, 0, width, height)
  player = {
    x = width / 2,
    y = height / 2,
    width = 50,
    height = 50,
    speed = 300,
    color = { 150, 150, 150 }
  }
  box = {
    x = 0,
    y = 0,
    width = width * 2,
    height = height * 2,
    color = { 255, 20, 20 }
  }
  stuff = {}
  for i = 1, 10 do
    table.insert(stuff, {
      x = math.random(100, width * 2 - 100),
      y = math.random(100, height * 2 - 100),
      width = math.random(100, 300),
      height = math.random(100, 300),
      color = { 255, 255, 255 }
    })
  end
end
function love.update(dt)
  if love.keyboard.isDown('left') then
    player.x = player.x - player.speed * dt
  elseif love.keyboard.isDown('right') then
    player.x = player.x + player.speed * dt
  elseif love.keyboard.isDown('up') then
    player.y = player.y - player.speed * dt
  elseif love.keyboard.isDown('down') then
    player.y = player.y + player.speed * dt
  end
  camera:setPosition(player.x - width / 2, player.y - height / 2)
end
function love.draw()
  camera:set()
  -- box
  love.graphics.setColor(box.color)
  love.graphics.rectangle('line', box.x, box.y, box.width, box.height)
  -- stuff
  for _, v in pairs(stuff) do
    love.graphics.setColor(v.color)
    love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
  end
  -- player
  love.graphics.setColor(player.color)
  love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
  camera:unset()
end
function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end