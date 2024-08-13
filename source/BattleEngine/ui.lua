Ui = {}

local fightbt = {}
fightbt[0] = love.graphics.newImage('assets/images/ui/bt/fight0.png')
fightbt[1] = love.graphics.newImage('assets/images/ui/bt/fight1.png')
local actbt = {}
actbt[0] = love.graphics.newImage('assets/images/ui/bt/act0.png')
actbt[1] = love.graphics.newImage('assets/images/ui/bt/act1.png')
local itembt = {}
itembt[0] = love.graphics.newImage('assets/images/ui/bt/item0.png')
itembt[1] = love.graphics.newImage('assets/images/ui/bt/item1.png')
local mercybt = {}
mercybt[0] = love.graphics.newImage('assets/images/ui/bt/mercy0.png')
mercybt[1] = love.graphics.newImage('assets/images/ui/bt/mercy1.png')

function Ui:buttons()
    love.graphics.draw(fightbt[buttonOn == 0 and 1 or 0], 32, 432)
    love.graphics.draw(actbt[buttonOn == 1 and 1 or 0], 185, 432)
    love.graphics.draw(itembt[buttonOn == 2 and 1 or 0], 345, 432)
    love.graphics.draw(mercybt[buttonOn == 3 and 1 or 0], 500, 432)
end

return Ui