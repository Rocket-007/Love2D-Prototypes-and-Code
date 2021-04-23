require "gooi.gooi"
require "gooi.slider"
require "gooi.component"


function love.load() 
slid = gooi.newSlider({
value = 0 ,
x = 30 ,
y = 50 ,
w = 300 ,
h = 28,
group = "grp1"
})



slid2 = gooi.newSlider({
value = 0 ,
x = 270 ,
y = 90 ,
w = 160 ,
h = 28,
group = "grp1"
})
end



function love.draw() 
gooi.draw("grp1") 
love.graphics.print(slid:getValue() , 30,20) 
love.graphics.print(slid2:getValue(), 30,30) 
end 


--below is 4 singletap
--function love.touchreleased(x, y, button) gooi.released() end
--function love.touchpressed(x, y, button)  gooi.pressed() end

--below is 4 multitap
function love.touchpressed (id, x,y) gooi.pressed(id, x, y) end
function love.touchreleased(id, x, y) gooi.released(id, x, y) end
function love.touchmoved (id, x, y) gooi.moved(id, x, y)
end

function love.update(dt)
gooi.update(dt)
end