enemies = {}

function doAct()
    if Player.chosenEnemy == 0 then
        if enemies.one.acts[global.subChoice+1] == 'Check' then
            Writer:setParams("* you pressed check but i'm too[break]  lazy to actually do something[break]  with acting right now", 52, 274, fonts.determination, 0.02, 1)
        end
        if enemies.one.acts[global.subChoice+1] == 'Pose' then
            Writer:setParams("* you posed               [break]* ok", 52, 274, fonts.determination, 0.02, 1)
        end
        if enemies.one.acts[global.subChoice+1] == 'Kill' then
            Writer:setParams("* kill! your game crashes", 52, 274, fonts.determination, 0.02, 1)
        end
    elseif Player.chosenEnemy == 1 then
        if enemies.one.acts[global.subChoice+1] == 'Check' then
            Writer:setParams("* you pressed check but i'm too[break]  lazy to actually do something[break]  with acting right now", 52, 274, fonts.determination, 0.02, 1)
        end
        if enemies.one.acts[global.subChoice+1] == 'Pose' then
            Writer:setParams("* you posed again              [break]* ok", 52, 274, fonts.determination, 0.02, 1)
        end
    elseif Player.chosenEnemy == 2 then
        -- nothing here because there isn't a third enemy
    end
end

enemies.one = {
    name = 'Poseur',
    x = 200,
    y = 135,
    image = love.graphics.newImage('assets/enemies/images/poseur.png'),
    xOff = 0,
    yOff = 0,
    def = 1,
    atk = 1
}

enemies.two = {
    name = 'Posette',
    x = 440,
    y = 135,
    image = love.graphics.newImage('assets/enemies/images/posette.png'),
    xOff = 0,
    yOff = 0,
    def = 5,
    atk = 5
}

enemies.one.acts = {'Check', 'Pose', 'Kill'}
enemies.two.acts = {'Check', 'Pose'}

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
        drawGraphic(enemies.one.image, enemies.one.x - enemies.one.image:getWidth()/2 + enemies.one.xOff, enemies.one.y - enemies.one.image:getHeight()/2 + enemies.one.yOff, color, {0, 0, 0})
    end
    if enemies.stats.amount > 1 then
        drawGraphic(enemies.two.image, enemies.two.x - enemies.two.image:getWidth()/2 + enemies.two.xOff, enemies.two.y - enemies.two.image:getHeight()/2 + enemies.two.yOff, color, {0, 0, 0})
    end
end

return enemies