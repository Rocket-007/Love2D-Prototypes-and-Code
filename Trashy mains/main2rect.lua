--[[
function love.draw ()
love.graphics. print ( "Hello World!" , 100 , 100 )
a =    9
b = 5
love.graphics. print(a+b,90,90)


love.graphics.circle( "fill" , 10, 190, 50 , 25)

love. graphics. rectangle( "fill" , 20, 50, 60, 120 )
end
--]] 






function love.load ()
x = 100
end


function love.update (dt)
if 1<5 then
    x = x + 70 *dt
end
end

function love.draw ()
local touches = love . touch. getTouches()
love.graphics. print(a, b) 
love.graphics.rectangle( "line" , x , 50, 200 , 150 )
end
