-- assets/source/panel.lua
local Panel = {}

Panel.x, Panel.y, Panel.w, Panel.h = 550, 100, 400, 400
Panel.font = nil
Panel.icon = nil
Panel.text = ""
Panel.repoLink = ""

function Panel.load()
    Panel.font = love.graphics.newFont("assets/source/VCR.ttf", 16)
end

function Panel.loadFromTxt(txtFile)
    local file = love.filesystem.read("assets/data/libs/"..txtFile)
    if not file then return end

    -- Nueva ubicación de iconos
    local icoPath = file:match("Ico://([^\n]+)")
    if icoPath and love.filesystem.getInfo(icoPath) then
        Panel.icon = love.graphics.newImage(icoPath)
    else
        Panel.icon = love.graphics.newImage("assets/data/icolibs/reico.png")
    end

    local desc = file:match("Desc:%s*(.-)\nReLnk")
    Panel.text = desc or ""

    local link = file:match("ReLnk:'(.-)'")
    Panel.repoLink = link or ""
end

function Panel.draw()
    love.graphics.setColor(0.3,0.3,0.3)
    love.graphics.rectangle("fill", Panel.x, Panel.y, Panel.w, Panel.h, 15, 15)

    -- Icono más pequeño en esquina izquierda
    if Panel.icon then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(Panel.icon, Panel.x + 20, Panel.y + 20, 0, 1.5, 1.5)
    end

    love.graphics.setFont(Panel.font)
    love.graphics.setColor(1,1,1)
    love.graphics.printf(Panel.text, Panel.x + 120, Panel.y + 20, Panel.w - 140, "left")

    local btnW, btnH = 150, 40
    local btnX = Panel.x + (Panel.w - btnW)/2
    local btnY = Panel.y + Panel.h - btnH - 20

    love.graphics.setColor(0.6,0.6,0.6)
    love.graphics.rectangle("fill", btnX, btnY, btnW, btnH, 10, 10)

    love.graphics.setColor(0,0,0)
    love.graphics.printf("Open repo", btnX, btnY + 10, btnW, "center")

    Panel.btnX, Panel.btnY, Panel.btnW, Panel.btnH = btnX, btnY, btnW, btnH
end

function Panel.mousepressed(x,y,button)
    if button == 1 then
        if x >= Panel.btnX and x <= Panel.btnX+Panel.btnW and
           y >= Panel.btnY and y <= Panel.btnY+Panel.btnH then
            if Panel.repoLink ~= "" then
                love.system.openURL(Panel.repoLink)
            end
        end
    end
end

return Panel