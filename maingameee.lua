--require "strict.strict"
gamera = require "gamera.gamera"
require "gooi.gooi"
require "gooi.button"
require "gooi.joy"
--require "gooi.panel"
require "gooi.layout"
require "gooi.label"
require "gooi.slider"
require "gooi.component"
require "gooi.checkbox"

local sti = require "sti.sti"
function love.load() 
blob={
x=500
, 
y=300
, 
speed = 200,
width=17,
height=17
} 
gun={
x= blob.x, 
y= blob.y
	} 

bulletSpeed = 800
bullets={} 
lock=gooi.newCheck({

text = "Lock" ,

x = 14 ,

y = 48 ,

w = 200 ,

h = 55,

--group = "grp1" ,

checked = true -- default = false

}):change()

gooi.newButton({text = "Exit", x=440, y=30}):onRelease(function() 
love.event.quit()end)

slid = gooi.newSlider({

value = 0.9 ,

x = 137 ,

y = 254 ,

w = 227 ,

h = 27,

--group = "grp1"
})



ljoy = gooi.newJoy({x=41, y=198, size = 90,})
--:setImage( "/imgs/joys.png" )
:noScaling()
:anyPoint()
--:setDigital()
--:direction)
 
rjoy = gooi.newJoy({x=366, y=194, size = 90})
--:setImage( "/imgs/joys.png" )

:noScaling()
:anyPoint()
:noSpring() 
--:setDigital()
--:direction()

cam = gamera.new(0,0,2130,1460)
--cam:setWindow(0,0,575,760)
love.graphics.setBackgroundColor(0.21 , 0.67 , 0.97) 

image = love.graphics.newImage("imgs/joysf.png")
image2 = love.graphics.newImage("imgs/gun.png")
bullet = love.graphics.newImage("imgs/bullet.png")

	-- Load map file
	map = sti("1outpost_new.lua")

end
 
 
function love.update(dt)

--if rjoy:overIt()== true then
gooi.update(dt)


ang_ljoy=math.atan2(ljoy:yValue(), ljoy:xValue() ) 

cos0 = math.cos(ang_ljoy)

sin0 = math.sin(ang_ljoy)

if ljoy:xValue() ~= 0 and ljoy:yValue() ~= 0 then

blob.x = blob.x + blob.speed * cos0  * dt

blob.y = blob.y + blob.speed * sin0  * dt

end


gun={
x= blob.x, 
y= blob.y+12
	} 
ll=slid:getValue() 
--if slid:getValue() == 0.2 or 0.6 or 1.0 then 
--ll=0.2,0.4,0.9 end
cam:setScale(ll+0.2)

ang_rjoy=math.atan2(rjoy:yValue(), rjoy:xValue() ) 

cos = math.cos(ang_rjoy)

sin = math.sin(ang_rjoy)

 
len = math.sqrt(rjoy:xValue()*rjoy:xValue()+rjoy:yValue()*rjoy:yValue() )
if not (ang_rjoy >= -1.5870796 and ang_rjoy <= 1.5870796) then
flip=-0.1
else flip=0.1
end
cam:setPosition(blob.x,blob.y)


for i ,v in ipairs (bullets ) do

v .x = v . x + ( v .dx * dt )

v .y = v . y + ( v .dy * dt )

end

if lock.checked == true then

if len >= 0.94 then
local startX = gun.x--+0.1*image2:getWidth()  / 2

local startY = gun.y--+0.1*image2:getHeight() / 2

--local mouseX = x

--local mouseY = y

local angle = ang_rjoy --math.atan2 (( mouseY - startY ), (mouseX - startX ))

local bulletDx = bulletSpeed * math.cos ( angle )

local bulletDy = bulletSpeed * math.sin ( angle )

table.insert ( bullets , { x = startX , y = startY , dx = bulletDx , dy = bulletDy })

end 
end
end

function love.draw() 
cam:draw(function()
love.graphics.draw(image, 0,0,0,0.91,0.9)
--love.graphics.setBackgroundColor(0.2,0.2,0.6,0.1) 
love.graphics.print (5+2,20,40)
--love.graphics.rectangle("fill",60,70,50,60) 
map:draw()
love.graphics.circle("fill", blob.x,blob.y,blob.width,blob.height)
--love .graphics .setColor (1 , 0, 0)
--love .graphics.rectangle ("fill" , px, py, 50,20,math.deg(degg) )
--love .graphics .setColor (255 , 255, 255)
--if deg1 >=0 then
--love.graphics.draw(image2, px,py+9,(degg-90)*math.pi/180, 0.1,0.1,250,150)--, 350,150)

--love.graphics.draw(bull, bulx,buly, 0,0.1,0.1) --(degg-90)*math.pi/180, 0.1,flip,150,250) --, 350,150)

for i ,v in ipairs (bullets ) do

love. graphics. draw(bullet , v .x , v .y ,ang_rjoy, 0.4,0.2, 0.1*image2:getWidth()-1.7*(0.1*image2:getWidth()) ,flip *image2:getHeight()  )

end

love.graphics.draw(image2, gun.x,gun.y,ang_rjoy, 0.1,flip,image2:getWidth() /2,image2:getHeight() /2) --, 350,150)

end) 
--love.graphics.print(slid:getValue(), 30,20)
--love.graphics.print(ljoy:direction(), 280,70) 


love.graphics.print(rjoy:xValue(), 280,90) 


love.graphics.print(rjoy:yValue(), 315,90) 


--love.graphics.print(math.atan(math.(rjoy:yValue(),rjoy:xValue()) ),280,120)
love.graphics.print(ang_rjoy,280,110) 
love.graphics.print("blobxy.  ".. blob.x.."  "..blob.y,280,130) 
love.graphics.print("            len  ".. "Made you look 😡 😄 ".. len, 290,150) 

gooi.draw() 


end


function love.touchpressed (id, x,
 y) gooi.pressed(id, x, y) end

function love.touchreleased(id, x, y) gooi.
released(id, x, y) end

function love.touchmoved (
id, x, y) gooi.moved(id, x, y)
end




