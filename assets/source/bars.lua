-- assets/source/bars.lua
local Bars = {}

Bars.list = {}
Bars.selected = 1
Bars.font = nil

function Bars.load()
    -- Fuente VCR.ttf en assets/source
    Bars.font = love.graphics.newFont("assets/source/VCR.ttf", 20)

    local entries = {
        {name="Inky", txt="Inky.txt"},
        {name="Xml.lua", txt="Xml.txt"},
        {name="Algo", txt="Algo.txt"},
        {name="Más", txt="Mas.txt"},
    }

    for i, entry in ipairs(entries) do
        Bars.list[i] = {
            x = 100,
            y = 100 + (i-1)*180,
            w = 400,
            h = 100,
            baseW = 400,
            baseH = 100,
            name = entry.name,
            txt = entry.txt,
            icon = nil
        }

        -- Nueva ubicación de iconos
        local icoPath = "assets/data/icolibs/"..entry.name..".png"
        if love.filesystem.getInfo(icoPath) then
            Bars.list[i].icon = love.graphics.newImage(icoPath)
        else
            Bars.list[i].icon = love.graphics.newImage("assets/data/icolibs/reico.png")
        end
    end
end

function Bars.update()
    for i, bar in ipairs(Bars.list) do
        if i == Bars.selected then
            bar.w = bar.baseW * 1.2
            bar.h = bar.baseH * 1.2
        else
            bar.w = bar.baseW
            bar.h = bar.baseH
        end
    end
end

function Bars.draw()
    for i, bar in ipairs(Bars.list) do
        if i == Bars.selected then
            love.graphics.setColor(0.7, 0.7, 0.7)
        else
            love.graphics.setColor(0.2, 0.2, 0.2)
        end
        love.graphics.rectangle("fill", bar.x, bar.y, bar.w, bar.h, 15, 15)

        -- Icono más pequeño
        if bar.icon then
            love.graphics.setColor(1,1,1)
            love.graphics.draw(bar.icon, bar.x + 10, bar.y + 9, 0, 1, 1)
        end

        -- Nombre con fuente VCR
        love.graphics.setFont(Bars.font)
        love.graphics.setColor(1,1,1)
        love.graphics.print(bar.name, bar.x + 100, bar.y + 35)
    end
end

return Bars