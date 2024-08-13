TestTextRoom = {}
writer = require('source.writer')

function TestTextRoom:load()
    writer:setParams('[clear]* Hello, world![break]* I am so happy I could [yellow][shake]shake![clear][wave][break]* Or I could just chill...', 20, 20, fonts.determination, 1/30)
end

function TestTextRoom:update(dt)
    writer.update(dt)
end

function TestTextRoom:draw()
    writer.draw()
end

return TestTextRoom