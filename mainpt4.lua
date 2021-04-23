
-- Include Simple Tiled Implementation into project
local sti = require "sti.sti"

function love.load()
	-- Load map file
	map = sti("Map01.lua")
end

function love.update(dt)
	-- Update world
	map:update(dt)
end

function love.draw()
	-- Draw world
	map:draw()
end