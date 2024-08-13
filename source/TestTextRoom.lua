TestTextRoom = {}
writer = require('source.writer')

function TestTextRoom:load()
    writer:setParams('[clear]* Hello, world![break]* I am so happy I could [shake]shake![clear][wave][break]* Or I could just chill...', 20, 300, fonts.determination)
end

function TestTextRoom:update(dt)

end

function TestTextRoom:draw()
    writer.draw()
end

return TestTextRoom