enemies = {}

local color
local outlineWidth = 0

local bg = {}
bg[0] = love.graphics.newImage('assets/images/spr_battlebg_0.png')
bg[1] = love.graphics.newImage('assets/images/spr_battlebg_1.png')

function enemies:doAct()
    if Player.chosenEnemy == 0 then
        if enemies[1].acts[global.subChoice+1] == 'Check' then
            Writer:setParams("[clear]* Sans: ATT - 1 DEF - 1     [break]* The easiest enemy.     [break]* Can't dodge forever.", 52, 274, fonts.determination, 0.02, 1)
        end
    end
end

local function drawGraphic(image, x, y, color, outlineColor)
    for i = -outlineWidth, outlineWidth do
        love.graphics.setColor(outlineColor)
        for j = -outlineWidth, outlineWidth do
            if i ~= 0 then
                love.graphics.draw(image, x + i, y + j)
            end
        end
    end
    love.graphics.setColor(color)
    love.graphics.draw(image, x, y)
end

function enemies:load()
    enemies[1] = {
        name = 'Sans',
        x = 320,
        y = 137,
        image = love.graphics.newImage('assets/enemies/images/poseur.png'),
        xOff = 0,
        yOff = 0,
        def = 1,
        atk = 1,
        canSpare = false,
        state = 'alive',
        hp = 1,
        maxhp = 1
    }
    
    enemies[1].acts = {'Check'}
    
    enemies.stats = {amount = 1, canFlee = false}
    
    enemies.encounter = {
        text = "[clear]* You feel like you're going[break]  to have a [red][shake]bad time.",
        startFirst = true,
        showHPbar = false
    }

    enemies.bgm = love.audio.newSource('assets/enemies/bgm2.mp3', 'stream')
end

function enemies:update(dt)
    --[[
    bgoffset = bgoffset - dt * 30
    if bgoffset <= -84 then
        bgoffset = 0
    end
    ]]
end

function enemies:draw()
    for i = 1, math.min(enemies.stats.amount, 3) do
        local enemy = enemies[i]
        if enemy.state == 'alive' then
            color = {1, 1, 1}
        elseif enemy.state == 'spared' then
            color = {1, 1, 1, .5}
        elseif enemy.state == 'dead' then
            color = {1, 1, 1, .0}
        end
        drawGraphic(enemy.image, enemy.x - enemy.image:getWidth()/2 + enemy.xOff, enemy.y - enemy.image:getHeight()/2 + enemy.yOff, color, {0, 0, 0})
    end
end

function enemies:background()

end

return enemies