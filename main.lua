local TEXTURE = nil
local SHADER = nil
local CANVAS = nil
local CANVAS2 = nil
local FILENAME = nil
local FLIPSHADER = nil

function love.load(args)
  SHADER = love.graphics.newShader("shaders/normal_gen.glsl")
  FLIPSHADER = love.graphics.newShader("shaders/flip.glsl")
  if args[1] ~= nil then
    TEXTURE = love.graphics.newImage(args[1])
    FILENAME = args[1]
  else
    TEXTURE = love.graphics.newImage("default.jpg")
    FILENAME = "default.jpg"
  end
  CANVAS = love.graphics.newCanvas(TEXTURE:getWidth(),TEXTURE:getHeight())
  CANVAS2 = love.graphics.newCanvas(TEXTURE:getWidth(),TEXTURE:getHeight())
  SHADER:send("ImageSize",{TEXTURE:getWidth(),TEXTURE:getHeight()})
end

function love.draw()
  love.graphics.setShader(SHADER)
  love.graphics.setCanvas(CANVAS)
  love.graphics.draw(TEXTURE)
  love.graphics.setCanvas()
  love.graphics.setShader(FLIPSHADER)
  love.graphics.setCanvas(CANVAS2)
  love.graphics.draw(CANVAS)
  love.graphics.setCanvas()
  love.graphics.setShader()
  CANVAS2:newImageData():encode("png", getFileName(FILENAME).."_normal"..".png")
  love.event.quit()
end

function getFileName(str)
  local ext = getFileExtension(str)
  return str:gsub(ext, "")
end

function getFileExtension(str)
  return str:match("^.+(%..+)$")
end
