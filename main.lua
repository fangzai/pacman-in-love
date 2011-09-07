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

function get_square_position(x, y)
  local pos_x = math.ceil(x / 32);
  local pos_y = math.ceil(y / 32);
  return pos_x, pos_y;
end

function get_tile_index(pos_x, pos_y)
  return TiledMap_GetMapTile(pos_x, pos_y, 1);
end

function create_box()
  box = {};
  for i=1,3 do
    box[i] = {};
    for j=1,3 do
      box[i][j] = {};
    end
  end
  box.update = function (x, y, width, height)
    box[1][1] = {x - width / 2, y - height / 2};
    box[1][2] = {x - width / 2, y};
    box[1][3] = {x - width / 2, y + height / 2};
    
    box[2][1] = {x, y - height / 2};
    box[2][2] = {x, y};
    box[2][3] = {x, y + height / 2};
    
    box[3][1] = {x + width / 2, y - height / 2};
    box[3][2] = {x + width / 2, y};
    box[3][3] = {x + width / 2, y + height / 2};
  end
  return box;
end

function check_colision(box)
  local tile;
  for i=1,3 do
    for j=1,3 do
       print(box[i][j][1] .. ' ' .. box[i][j][2]);
       tile = get_tile_index(get_square_position(box[i][j][1], box[i][j][2]));
      if (tile == 85) then
        print('Colided');
        return true;
      end
    end
  end
  return false;
end