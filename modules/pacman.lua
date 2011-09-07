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
pacman.BLANK_SPACE = 1;
pacman.QUAD = love.graphics.newQuad(0,0,32,32,32,32);

function pacman.reset()
  pacman.x = pacman.INITIAL_X;
  pacman.y = pacman.INITIAL_Y;
  pacman.speed = pacman.NORMAL_SPEED;
  pacman.dead = false;
  pacman.super = false;
  pacman.starting = true;
  pacman.orientation = nil;
  pacman.orientation_buffer = nil;
  pacman.box = create_box();
  pacman.box_buffer = nil;
end

function pacman.update(dt)
  local colided, x, y = pacman.calc_position(pacman.orientation_buffer,
      dt * pacman.speed);
      
  if not(colided) then
    pacman.box.update(x, y, pacman.width, pacman.height);
    pacman.orientation = pacman.orientation_buffer;
    pacman.x = x;
    pacman.y = y;
  else
    colided, x, y = pacman.calc_position(pacman.orientation,
        dt * pacman.speed);
    if not(colided) then
      pacman.box.update(x, y, pacman.width, pacman.height);
      pacman.x = x;
      pacman.y = y;
    end
  end
end

function pacman.calc_position(orientation, speed)
  local x, y = pacman.x, pacman.y;
  if pacman.x >= 478 then
    pacman.x = 0;
  else
    if pacman.x <= 0 then
      pacman.x = 478;
    end
  end

  if orientation == nil then
    return false, pacman.x, pacman.y;
  end

  if orientation == pacman.ORIENTATION_UP then
    y = pacman.y - speed;
  end
  
  if orientation == pacman.ORIENTATION_DOWN then
    y = pacman.y + speed;
  end
  
  if orientation == pacman.ORIENTATION_LEFT then
    x = pacman.x - speed;
  end
  
  if orientation == pacman.ORIENTATION_RIGHT then
    x = pacman.x + speed;
  end
  box = create_box();
  box.update(x, y, pacman.width - pacman.BLANK_SPACE, 
      pacman.height - pacman.BLANK_SPACE);
  return check_colision(box), x, y;
end

function pacman.keypressed(key, unicode)
  if key == "up" then
    pacman.orientation_buffer = pacman.ORIENTATION_UP;
  end
  
  if key == "down" then
    pacman.orientation_buffer = pacman.ORIENTATION_DOWN;
  end
  
  if key == "right" then
    pacman.orientation_buffer = pacman.ORIENTATION_RIGHT;
  end
  
  if key == "left" then
    pacman.orientation_buffer = pacman.ORIENTATION_LEFT;
  end
end

function pacman.draw()
  pacmanAnim:draw(pacman.x, pacman.y, pacman.orientation, 1, 1, pacman.width/2,
      pacman.height/2);
end

pacman.reset();