pacman = {}
pacman.width = 32;
pacman.height = 32;
pacman.INITIAL_X = 240;
pacman.INITIAL_Y = 304;
pacman.ORIENTATION_UP = math.rad(270);
pacman.ORIENTATION_DOWN = math.rad(90);
pacman.ORIENTATION_LEFT = math.rad(180);
pacman.ORIENTATION_RIGHT = math.rad(0);
pacman.NORMAL_SPEED = 100;
pacman.SUPER_SPEED = 130;
pacman.QUAD = love.graphics.newQuad(0,0,32,32,32,32);

function pacman.reset()
  pacman.x = pacman.INITIAL_X;
  pacman.y = pacman.INITIAL_Y;
  pacman.speed = pacman.NORMAL_SPEED;
  pacman.dead = false;
  pacman.super = false;
  pacman.starting = true;
  pacman.orientation = nil;
end

function pacman.update(dt)
  function get_speed(dt)
    return dt * pacman.speed;
  end
  
  local x, y = pacman.x, pacman.y;
  local box_x, box_y = pacman.x, pacman.y;
  if pacman.x >= 478 then
    pacman.x = 0;
  else
    if pacman.x <= 0 then
      pacman.x = 478;
    end
  end

  if pacman.orientation == nil then
    return;
  end

  if pacman.orientation == pacman.ORIENTATION_UP then
    y = pacman.y - get_speed(dt);
    box_y = y - pacman.height / 2;
  end
  
  if pacman.orientation == pacman.ORIENTATION_DOWN then
    y = pacman.y + get_speed(dt);
    box_y = y + pacman.height / 2;
  end
  
  if pacman.orientation == pacman.ORIENTATION_LEFT then
    x = pacman.x - get_speed(dt);
    box_x = x - pacman.width / 2;
  end
  
  if pacman.orientation == pacman.ORIENTATION_RIGHT then
    x = pacman.x + get_speed(dt);
    box_x = x + pacman.width / 2;
  end
  if not(pacman.check_colision(box_x, box_y)) then
    pacman.x = x;
    pacman.y = y;
  end
end

function pacman.check_colision(x, y)
  local tile_pos_x, tile_pos_y = get_square_position(x, y);
  local next_tile = get_tile_index(tile_pos_x, tile_pos_y);
  if not(next_tile == 85) then
    return false;
  else
    return true;
  end
end

function pacman.keypressed(key, unicode)
  if key == "up" then
    pacman.orientation = pacman.ORIENTATION_UP;
  end
  
  if key == "down" then
    pacman.orientation = pacman.ORIENTATION_DOWN;
  end
  
  if key == "right" then
    pacman.orientation = pacman.ORIENTATION_RIGHT;
  end
  
  if key == "left" then
    pacman.orientation = pacman.ORIENTATION_LEFT;
  end
end

function pacman.draw()
  pacmanAnim:draw(pacman.x, pacman.y, pacman.orientation, 1, 1, pacman.width/2, pacman.height/2) 
 
end

pacman.reset();