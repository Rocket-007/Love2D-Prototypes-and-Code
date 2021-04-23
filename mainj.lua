require "gooi.gooi"
require "gooi.button"
require "gooi.joy"
require "gooi.panel"
require "gooi.layout"
require "gooi.label"
require "gooi.spinner"
require "gooi.component"


function love.load()

ljoy = gooi.newJoy({x=66, y=170, size = 90,})
--:setImage( "/imgs/joys.png" )
:noScaling()
:anyPoint()
:setDigital()
--:direction)
 
rjoy = gooi.newJoy({x=363, y=170, size = 90,})
--:setImage( "/imgs/joys.png" )

:noScaling()
:anyPoint()
:setDigital()
--:direction()
 

gooi.newButton({text = "Exit", x=440, y=40}):onRelease(function() 
love.event.quit()end)
  
spin=gooi.newSpinner({
min = -20,
max = 20,
value = 0,
x = 4,
y = 8,
w = 120,
h = 25,
group = "grp1", 
x=40,y=50
})



xx=270
yy=50
pp =20
s = 200
end



function love.draw()
love.graphics.print(ljoy:direction(), 280,70) 
love.graphics.print(rjoy:direction(), 280,90) 
love.graphics.rectangle("fill", xx,yy,pp,pp) 
gooi.draw("grp1")
gooi.draw() 
end


--function love.touchreleased(x, y, button) gooi.released() end
--function love.touchpressed(x, y, button)  gooi.pressed() end


function love.touchpressed (id, x,
y) gooi.pressed(id, x, y) end
function love.touchreleased(id, x, y) gooi.
released(id, x, y) end
function love.touchmoved (
id, x, y) gooi.moved(id, x, y)
end

function love.update(dt)
gooi.update(dt)
if ljoy:direction() == "t" then
yy=yy-s*dt
elseif ljoy:direction() == "tr" then
xx=xx+s*dt;yy=yy-s*dt
elseif ljoy:direction() == "r" then
xx=xx+s*dt
elseif ljoy:direction() == "br" then
xx=xx+s*dt;yy=yy+s*dt
elseif ljoy:direction() == "b" then
yy=yy+s*dt
elseif ljoy:direction() == "bl" then
xx=xx-s*dt;yy=yy+s*dt
elseif ljoy:direction() == "l" then
xx=xx-s*dt
elseif ljoy:direction() == "tl" then
xx=xx-s*dt;yy=yy-s*dt
end


end
