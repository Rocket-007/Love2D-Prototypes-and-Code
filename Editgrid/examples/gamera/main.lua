-- fix path so all examples can use editgrid from parent directory.
package.path = [[../../?.lua;]]..package.path
local editgrid = require "editgrid"
local gamera = require "gamera"
-- mouse location
local mx, my = 0, 0
-- location of mouse on the grid
local mWorldx, mWorldy = 0, 0
-- location of grid origin on screen
local oScreenx, oScreeny = 0, 0
local cam = gamera.new(-1000, -1000, 2000, 2000)
function love.draw()
    editgrid.draw(cam)
    local camx, camy = cam:getPosition()
    local scale = cam:getScale()
    local cx, cy = editgrid.convertCoords(cam, nil, "screen", "cell", mx, my)
    love.graphics.printf(
        "Camera position: (" ..
        camx .. ", " .. camy ..
        ")\nCamera zoom: " ..
        scale ..
        "\nMouse position on Grid: (" ..
        mWorldx  .. ", " .. mWorldy ..
        ")\nCell coordinate under mouse: (" ..
        cx .. ", " .. cy ..
        ")\nGrid origin position on screen: (" ..
        oScreenx .. ", " .. oScreeny .. ")",
    30, 30, 800, "left")
end
function love.update(dt)
    local newmx, newmy = love.mouse.getPosition()
    local camx, camy = cam:getPosition()
    local scale = cam:getScale()
    local angle = cam:getAngle()
    if love.mouse.isDown(1) then
        local s, c = cam.sin, cam.cos
        local dx = (-newmx + mx) / scale
        local dy = (-newmy + my) / scale
        cam:setPosition(camx + dx * c - dy * s, camy + dy * c + dx * s)
    end
    if love.keyboard.isDown("q") then
        cam:setAngle(cam:getAngle() + dt)
    end
    if love.keyboard.isDown("e") then
        cam:setAngle(cam:getAngle() - dt)
    end
    mx, my = newmx, newmy
    oScreenx, oScreeny = cam:toScreen(0, 0)
    mWorldx, mWorldy = cam:toWorld(mx, my)
end
function love.wheelmoved(x, y)
    local zoomfactor = nil
    if y > 0 then
        zoomfactor = 1.05
    elseif y < 0 then
        zoomfactor = 1 / 1.05
    end
    if zoomfactor then
        cam:setScale(cam:getScale() * zoomfactor)
    end
end