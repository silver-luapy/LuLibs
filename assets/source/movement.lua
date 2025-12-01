-- assets/source/movement.lua
local Movement = {}

function Movement.keypressed(key, Bars)
    if key == "up" then
        Bars.selected = math.max(1, Bars.selected - 1)
    elseif key == "down" then
        Bars.selected = math.min(#Bars.list, Bars.selected + 1)
    end
end

return Movement