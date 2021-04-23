--scrollbar = {};
--scrollbar = function()
local temp = {};
temp.x = 0;
temp.y = 0;
temp.w = 20;
temp.h = 200;
temp.minW = 20;
temp.minH = 20 ;
temp.rect = {};
temp.padding = 2;
temp.visible = true ;
temp.contentHeight = 0;
temp.scrollY = 0;
local mouseDown = false ;
function temploadScroll()
temp.rect.x = temp.x;
temp.rect.y = temp.y;
temp.rect.w = temp.w;
temp.rect.h = temp.minH;
end

function tempupdateScroll(dt)
if temp.contentHeight < temp.h then
temp.visible = false ;
return ;
else
temp.visible = true;
end
temp.rect.h = temp.h /temp.contentHeight;
temp.rect.h = math.max(temp.rect.h,temp.minH);
mx = love.mouse.getX();
my = love.mouse.getY();
meat=5
if mouseDown == true then
temp.rect.y = math.max(temp.y, math.min( math.floor(my), (temp.h - temp.y)));
temp.scrollY = temp.rect.y -temp.y;
end
end

function tempmousepressedScroll (x, y, button)
if button == 1 then
if x >= temp.rect.x and x <=
(temp.rect.x + temp.rect.w)+80 and
y >= temp.rect.y
and y <= (temp.rect.y + temp.rect.h)+90 then
mouseDown = true;
end
end
end

function tempmousereleasedScroll (x, y, button)
mouseDown = false ;
end

function tempdrawScroll ()
love.graphics.print(tostring(mx).."   "..tostring(my)..""..tostring(meat),60,20)
--if temp.visible == true then
love.graphics.rectangle( "fill" ,
temp.x, temp.y, temp.w, temp.h);
love.graphics.setColor( 255, 0,
0, 200 );
love.graphics.rectangle( "fill" ,
temp.rect.x, temp.rect.y, temp.rect.w, temp.rect.h);
love.graphics.setColor( 255,
255, 255 , 255);
--end
--end
return temp;
end