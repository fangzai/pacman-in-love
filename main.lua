love.filesystem.load('assets/maps/tiledmap.lua')()
love.filesystem.load('lib/TiledMapLoader.lua')()
love.filesystem.load('lib/AnAL.lua')()
Animations_legacy_support = true

function love.load()
	love.graphics.setMode(640, 480)
	love.graphics.setCaption('PacMan in LOVE')
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.clear()
	
	pacmanSheet = love.graphics.newImage('assets/sprites/pacmansheet.png')
	pacmanAnim = newAnimation(pacmanSheet, 32, 32, 0.04, 0)
	pacmanAnim:setMode("bounce")
	TiledMap_Load('assets/maps/tiledmap.tmx')	
	require('modules.pacman');
end
	
function love.draw()
  pacman.draw();
  TiledMap_DrawNearCam(352,272)	
end

function love.update(dt)
  pacman.update(dt);
  pacmanAnim:update(dt)
end

function love.keypressed(key, unicode)
  pacman.keypressed(key,unicode);
end