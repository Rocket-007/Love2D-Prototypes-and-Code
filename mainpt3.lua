function love.load ()
Tileset = love.graphics. newImage('countryside.png' )

TileW, TileH = 32, 32
local tilesetW, tilesetH =Tileset: getWidth(), Tileset: getHeight()
 Quads = {
love.graphics. newQuad (0, 0, TileW, TileH,tilesetW, tilesetH), -- 1 = grass
love.graphics. newQuad (32, 0, TileW, TileH,tilesetW, tilesetH), -- 2 = box
love.graphics. newQuad (0, 32 , TileW, TileH,tilesetW, tilesetH), -- 3 = flowers
love.graphics. newQuad (32, 32, TileW, TileH,tilesetW, tilesetH) -- 4 = boxtop
}


TileTables = {
{ 1, 1, 1 },
{ 1, 2, 1 },
{ 1, 1, 1 } -- notice that the last comma isn't needed here
}

TileTable = {
{
4, 2, 2, 2, 2, 2, 2, 2, 2, 2 , 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 , 2, 2, 2, 2, 4 }
,
  {
4, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 3, 1, 4 }
,
  {
4, 1, 3, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 3, 1, 1, 1, 1 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 1, 1, 1, 1, 1, 2, 1 , 1, 2, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 4, 1, 1, 1, 1, 1, 2 , 2, 1, 1, 4, 1, 1, 1, 4, 1, 4 , 2, 2, 1, 1, 4 }
,
  {
4, 1, 1, 4, 1, 1, 1, 1, 4, 3 , 3, 4, 1, 2, 1, 1, 1, 2, 1, 4 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 4, 1, 1, 1, 1, 4, 3 , 3, 4, 1, 1, 4, 1, 4, 1, 1, 4 , 2, 2, 1, 1, 4 }
,
  {
4, 1, 1, 4, 1, 1, 1, 1, 4, 3 , 3, 4, 1, 1, 2, 1, 2, 1, 1, 4 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 4, 1, 1, 1, 1, 2, 3 , 3, 2, 1, 1, 1, 4, 1, 1, 1, 4 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 2, 2, 2, 2, 1, 1, 2 , 2, 1, 1, 1, 1, 2, 1, 3, 1, 2 , 2, 2, 1, 1, 4 }
,
  {
4, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 1, 1, 1, 1, 1, 1, 2 , 1, 1, 1, 1, 2, 2, 4, 1, 1, 1 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 1, 1, 1, 1, 1, 4, 3 , 4, 1, 1, 1, 1, 1, 2, 1, 1, 1 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 3, 1, 1, 1, 1, 2, 3 , 2, 1, 1, 1, 1, 2, 1, 1, 1, 1 , 1, 1, 1, 1, 4 }
,
  {
4, 1, 1, 1, 1, 1, 1, 1, 1, 2 , 1, 1, 2, 1, 2, 1, 1, 1, 1, 1 , 1, 1, 3, 1, 4 }
,
  {
4, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 4 }
,
  {
2, 2, 2, 2, 2, 2, 2, 2, 2, 2 , 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 , 2, 2, 2, 2, 2 }
}
end

function love.draw ()
function love.draw ()
for rowIndex =1, #TileTable do
local row = TileTable[rowIndex]
for columnIndex =1 , # row do
local number = row[columnIndex]
love.graphics. draw (Tileset, Quads[number], (columnIndex - 1)*TileW, (rowIndex -1)* TileH)
end
end
end
end