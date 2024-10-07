enemies = {}

local color
local outlineWidth = 0
local bgoffset = 0

local bg = {}
bg[0] = love.graphics.newImage('assets/images/spr_battlebg_0.png')
bg[1] = love.graphics.newImage('assets/images/spr_battlebg_1.png')

function doAct()
    if Player.chosenEnemy == 0 then
        if enemies[1].acts[global.subChoice+1] == 'Check' then
            Writer:setParams("[clear]* POSEUR: ATT - 1 DEF - 1          [break]* Passionate poseur and wants[break]  more people to pose with.", 52, 274, fonts.determination, 0.02, 1)
        end
        if enemies[1].acts[global.subChoice+1] == 'Pose' then
            Writer:setParams("[clear]* You posed with Poseur.          [break]* It feels content with you, and[break]  is [yellow][wave]SPARING[clear] you now.", 52, 274, fonts.determination, 0.02, 1)
            enemies[1].canSpare = true
        end
        if enemies[1].acts[global.subChoice+1] == 'Kill' then
            Writer:setParams("[clear]* kill! your game crashes", 52, 274, fonts.determination, 0.02, 1)
        end
    elseif Player.chosenEnemy == 1 then
        if enemies[1].acts[global.subChoice+1] == 'Check' then
            Writer:setParams("[clear]* POSETTE: ATT - 5 DEF - 5          [break]* Poses with Poseur.          [break]* Nothing much more.", 52, 274, fonts.determination, 0.02, 1)
        end
        if enemies[1].acts[global.subChoice+1] == 'Pose' then
            Writer:setParams("[clear]* You posed with Posette.          [break]* It's impressed.", 52, 274, fonts.determination, 0.02, 1)
        end
    elseif Player.chosenEnemy == 2 then
        -- nothing here because there isn't a third enemy
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
        name = 'Poseur',
        x = 200,
        y = 137,
        image = love.graphics.newImage('assets/enemies/images/poseur.png'),
        xOff = 0,
        yOff = 0,
        def = 1,
        atk = 1,
        canSpare = false,
        state = 'alive',
        hp = 50,
        maxhp = 50
    }
    
    enemies[2] = {
        name = 'Posette',
        x = 440,
        y = 137,
        image = love.graphics.newImage('assets/enemies/images/posette.png'),
        xOff = 0,
        yOff = 0,
        def = 5,
        atk = 5,
        canSpare = false,
        state = 'alive',
        hp = 100,
        maxhp = 100
    }
    
    enemies[1].acts = {'Check', 'Pose', 'Kill'}
    enemies[2].acts = {'Check', 'Pose'}
    
    enemies.stats = {amount = 2, canFlee = true}
    
    enemies.encounter = {
        text = '[clear]* The [orange][shake]potent posers[clear] pose[break]  [cyan][wave]proposterously!',
        startFirst = false
    }

    enemies.bgm = love.audio.newSource('assets/enemies/bgm2.mp3', 'stream')
end

function enemies:update(dt)
    bgoffset = bgoffset - dt * 30
    if bgoffset <= -84 then
        bgoffset = 0
    end
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
    love.graphics.setColor(0, .3, .175)
    love.graphics.rectangle('fill', 0, 0, 640, 480)
    love.graphics.setColor(1, 1, 1)
    
    -- love.graphics.draw(bg[1], 0, -1)

    --[[
    love.graphics.setLineWidth(3)
    love.graphics.setLineStyle('rough')
    
    for i = 1, 21 do
        local lineX = i * 42 + bgoffset * 2
        local lineY = 0 + i * 42 + bgoffset / 2

        love.graphics.setColor(0, 1, .5, .15)
        love.graphics.line(lineX, 0, lineX, 480)
        
        love.graphics.setColor(0, 1, .5, .3)
        love.graphics.line(0, lineY, 640, lineY)
    end
    ]]
end

return enemies