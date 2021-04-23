function love.load()
image = love.graphics.newImage("imgs/joys.png")
end

function love.draw()
love.graphics.draw(image)
love.graphics.scale( 0.9 , 1.3 )
end