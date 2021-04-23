--[[function love.load() 
x= 100
y= 100
angle=1
speed=2
anglespeed=1
end
function love.update(dt) 
x=x+math.cos(angle)*dt*speed
y=y+math.sin(angle)*dt*speed
if love.mouse.isDown  then
angle=angle+anglespeed*dt
--end
--if keytrue then
else 
angle=angle+anglespeed*dt
end
end
function love.draw() 
love.graphics.circle("fill", x, y, 20) 
end
--]] 








require "gooi.gooi"
require "gooi.button"
require "gooi.joy"
require "gooi.layout"
require "gooi.label"
require "gooi.slider"
require "gooi.component"
function love.load ()
 
rjoy = gooi.newJoy({x=332, y=194, size = 90})
:noScaling()
:anyPoint()
--:noSpring() 
--:setDigital()
--:direction()
squ=love.graphics.newImage("imgs/gun.png") 
--Create an object called circle
circle = {}
--Give it the properties x, y, radius and speed
circle.x = 100
circle.y = 100
circle.radius = 25
circle.speed =100
end
function love.update (dt)
anglejoy=math.atan2(rjoy:yValue(), rjoy:xValue() ) 
--love.mouse.getPosition returns the x and y position of the cursor.
mouse_x, mouse_y =love.mouse.getPosition()
angle = anglejoy--math.atan2(mouse_y - circle.y, mouse_x - circle.x)
cos = math.cos(angle)
sin = math.sin(angle)
if rjoy:xValue() ~= 0 or rjoy:yValue() ~= 0 then
circle.x = circle.x + circle.speed * cos  * dt
circle.y = circle.y + circle.speed * sin  * dt
end

gooi.update(dt) 
end
function love.draw ()

love.graphics.circle( "line" , circle.x, circle.y, circle.radius)
love.graphics.draw(squ,200,200,angle,0.1,0.1) 
--Print the angle
love.graphics. print ("angle: " .. angle .."     ".. angle*180/math.pi.."   "..anglejoy  , 10, 30)
love.graphics. print (rjoy:yValue().."    "..  rjoy:xValue() , 10,46)
--Here are some lines to visualize the velocities
love.graphics.line(circle.x, circle.y, mouse_x, circle.y)
love.graphics.line(circle.x, circle.y, circle.x, mouse_y)
--The angle
love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
gooi.draw() 
end

function love.touchpressed (id, x, y) gooi.pressed(id, x, y) end
function love.touchreleased(id, x, y) gooi.released(id, x, y) end
function love.touchmoved (id, x, y) gooi.moved(id, x, y)end




