enemies = {}

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

enemies[1] = {
    name = 'Poseur',
    x = 200,
    y = 135,
    image = love.graphics.newImage('assets/enemies/images/poseur.png'),
    xOff = 0,
    yOff = 0,
    def = 1,
    atk = 1,
    canSpare = false
}

enemies[2] = {
    name = 'Posette',
    x = 440,
    y = 135,
    image = love.graphics.newImage('assets/enemies/images/posette.png'),
    xOff = 0,
    yOff = 0,
    def = 5,
    atk = 5,
    canSpare = false
}

enemies[1].acts = {'Check', 'Pose', 'Kill'}
enemies[2].acts = {'Check', 'Pose'}

local color

enemies.stats = {amount = 2, canFlee = true}

enemies.encounter = {text = '[clear]* The [weirdRed][shake]potent posers[clear] pose[break]  [cyan][wave]proposterously!'}
enemies.bgm = love.audio.newSource('assets/sound/mus/fortheworld.mp3', 'stream')

enemies.bg = love.graphics.newImage('assets/enemies/images/background.png')

local outlineWidth = 0

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

function enemies:update(dt)

end

function enemies:draw()
    color = {1, 1, 1}

    if enemies.stats.amount > 0 then
        drawGraphic(enemies[1].image, enemies[1].x - enemies[1].image:getWidth()/2 + enemies[1].xOff, enemies[1].y - enemies[1].image:getHeight()/2 + enemies[1].yOff, color, {0, 0, 0})
    end
    if enemies.stats.amount > 1 then
        drawGraphic(enemies[2].image, enemies[2].x - enemies[2].image:getWidth()/2 + enemies[2].xOff, enemies[2].y - enemies[2].image:getHeight()/2 + enemies[2].yOff, color, {0, 0, 0})
    end
end

return enemies