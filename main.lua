-- main.lua
local Bars = require("assets.source.bars")
local Movement = require("assets.source.movement")
local Panel = require("assets.source.panel")

function love.load()
    Bars.load()
    Panel.load()
    love.graphics.setBackgroundColor(0.4,0.4,0.4)
    Panel.loadFromTxt(Bars.list[Bars.selected].txt)
end

function love.update(dt)
    Bars.update()
end

function love.draw()
    Bars.draw()
    Panel.draw()
end

function love.keypressed(key)
    Movement.keypressed(key, Bars)
    Panel.loadFromTxt(Bars.list[Bars.selected].txt)
end

function love.mousepressed(x,y,button)
    Panel.mousepressed(x,y,button)
end