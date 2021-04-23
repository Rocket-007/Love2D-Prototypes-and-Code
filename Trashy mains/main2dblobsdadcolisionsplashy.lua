require "gooi.gooi"
require "gooi.button"
require "gooi.joy"
require "gooi.panel"
require "gooi.layout"
require "gooi.label"
require "gooi.spinner"
require "gooi.component"
require "gooi.checkbox"
draw_world= require "draw_world"
gamera=require "gamera.gamera"
function love . load()
love. physics .setMeter ( 64) --the height of a meter our worlds will be 64px
world = love . physics .newWorld ( 0, 9.81 * 64, true ) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

splash = require "splash"
lock=gooi.newCheck({
text = "Lock" ,
x = 14 ,
y = 48 ,
w = 200 ,
h = 75,
--group = "grp1" ,
checked = true -- default = false
}):change()

ljoy = gooi.newJoy({x=66, y=198, size = 90,})
--:setImage( "/imgs/joys.png" )
:noScaling()
:anyPoint()
--:setDigital()
--:direction)

rjoy = gooi.newJoy({x=332, y=194, size = 90})
--:setImage( "/imgs/joys.png" )
:noScaling()
:anyPoint()
:noSpring() 
--:setDigital()
--:direction()

love .graphics .setBackgroundColor ( 0.21 , 0.67 , 0.97 )
bulletSpeed = 250
bullets = {}

gun = {x = 250 , 
y =250 , 
width =30, 
height = 5, 
speed=200}

blob={
x = 400 , 
y =250 , 
width =30, 
height = 5, 
--body=love . physics .newBody ( world , 650 / 2 , 650 /2 , "dynamic" ), 
speed=200
	
	} 
world = splash. new(225)

guy = world: add ({}, splash. circle (blob.x, blob.y, 15))


 for i = 1, 100 do
        world:add({}, splash.seg(
            math.random(2000) - 1000,
            math.random(2000) - 1000,
            math.random(-50, 50),
            math.random(-50, 50)))
        world:add({}, splash.circle(
            math.random(2000) - 1000,
            math.random(2000) - 1000,
            math.random(50) + 10))
         world:add({}, splash.aabb(
            math.random(2000) - 1000,
            math.random(2000) - 1000,
            math.random(50) + 10,
            math.random(50) + 10))
    
    end
cam = gamera.new(0,0,2130,1460)
cam:setScale(1)
grav=100

end


function love . update(dt)
--world :update (dt)
local dx, dy=0,0--blob.x,blob.y
gooi.update(dt)

    
ang_ljoy=math.atan2(ljoy:yValue(), ljoy:xValue() ) 
if ljoy:xValue() == 0 then --or ljoy:yValue() == 0 then
blob.speed=blob.speed+100*dt
ang_ljoy=1.5
--blob.speed=100
else 
blob.speed=200
end
cos0 = math.cos(ang_ljoy)
sin0 = math.sin(ang_ljoy)

--if ljoy:xValue() == 0 then --or ljoy:yValue() == 0 then
--ang_ljoy=0

--gun.x = blob.x --+ blob.speed * cos0  * dt
--gun.y = blob.y --+ blob.speed * sin0  * dt


ang_rjoy=math.atan2(rjoy:yValue(), rjoy:xValue() ) 

cos = math.cos(ang_rjoy)
sin = math.sin(ang_rjoy)

for i ,v in ipairs (bullets ) do
v .x = v . x + ( v .dx * dt )
v .y = v . y + ( v .dy * dt )
end

if lock.checked == true then
local startX = gun. x+gun . width/ 2
local startY = gun. y+gun . height / 2
local mouseX = x
local mouseY = y
local angle = ang_rjoy--math.atan2 (( mouseY - startY ), (mouseX - startX ))
local bulletDx = bulletSpeed * math.cos ( angle )
local bulletDy = bulletSpeed * math.sin ( angle )
table.insert ( bullets , { x = startX , y = startY , dx = bulletDx , dy = bulletDy })
end

world:update(guy)
x, y = world:pos(guy)
--y=grav*dt
gun.x = x --+ blob.speed * cos0  * dt
gun.y = y
cam:setPosition(x,y)
--if ljoy:xValue() ~= 0 or ljoy:yValue() ~= 0 then
--world:move(guy, x+blob.speed*cos0*dt, y+grav*blob.speed*dt) 
world:move(guy, x + blob.speed*cos0 * dt, y + blob.speed*sin0 * dt)
--else if ljoy:xValue() == 0 or ljoy:yValue() == 0 then
--end
--for i=1,40 do
--y=y+50
--world:move(guy,x,y*dt) -- x + blob.speed*cos0 * dt, y + blob.speed*sin0 * dt)

--end
--end
--end
--grav=grav+100*dt
--world:move(guy, x, y+grav) 

end


function love . draw()
gooi.draw() 
--splash.draw() 
cam:draw(function()
love .graphics .setColor (1 , 0, 0)
--love.graphics.circle("line", guy:unpack() ) 
draw_world(world) 
draw_world.shape(world:shape(guy))
love .graphics .setColor (1 , 1, 1)
love .graphics . rectangle( "fill" , gun. x, gun. y, gun. width , gun . height)
love .graphics .setColor (0.5 , 0.5 , 0.5 )
for i ,v in ipairs (bullets ) do
love. graphics. circle( "fill" , v .x , v . y , 3 )
end
end) 
--love.graphics.print(dx.. "        "..dy, 100,30)
end



function love.touchpressed (id, x, y) gooi.pressed(id, x, y) end
function love.touchreleased(id, x, y) gooi.released(id, x, y) end
function love.touchmoved (id, x, y) gooi.moved(id, x, y)end
