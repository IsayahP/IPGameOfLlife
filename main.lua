--IP's Version Of: Naruto Game Of Life.





local gen=1
local thisgen, nextgen 
local group = display.newGroup()
local lifeCount, prevlifeCount, stabilizedCount = 0,0,0
local gameOver = false
local zoom = 8
local timerText, statusText


function ARRAY2D(w,h)
  local t = {}
  t.w=w
  t.h=h
  while h>0 do
    t[h] = {}
    local x=w
    while x>0 do
      t[h][x]=0
      x=x-1
    end
    h=h-1
  end
  return t
end

_CELLS = {}

-- give birth to a "shape" within the cell array
function _CELLS:spawn(shape,left,top)
  local y=0
  while y<shape.h do
    local x=0
    while x<shape.w do
      self[top+y][left+x] = shape[y*shape.w+x+1]
      x=x+1
    end
    y=y+1
  end
end


-- This is setting next generation of cells to be drawn by updating Matrix.
function _CELLS:evolve(next)
  local  ym1,y,yp1,yi=self.h-1,self.h,1,self.h
  while yi>0 do
    local xm1,x,xp1,xi=self.w-1,self.w,1,self.w
    while xi>0 do
      next[y][x]= self[yi][xm1] 
      xi=xi-1
    end
    yi=yi-1
  end
  return next [y][x]
end

-- Output the array to screen
function _CELLS:draw()
  --By printing the space potentially paces out the program. Can cause a greater delay in refreshing.
  local out="" -- accumulate to reduce flicker
  local y=1

  display.remove(group)
  group = nil 
  group = display.newGroup()
  

  --Just positioning the group that will house the markers
  group.x = -170
  group.y = -100
  
  while y <= self.h do
    local x=1
    while x <= self.w do
      if (self[y][x]>0) then
        --print(x)
        
         local myMarker = display.newCircle(x, y, zoom / 2 )      --circle marker
         --Adjusting the x/y coordinates based on my zoom factor.
         myMarker.x = (zoom * x)
         myMarker.y = (zoom * y)
    
    --Set colors
         myMarker:setFillColor(1,1,1)
         group:insert(myMarker)
         --lifeCount = lifeCount + 1
      end
      x=x+1
    end
    y=y+1
  end
  
end


function CELLS(w,h)
  local c = ARRAY2D(w,h)
  c.spawn = _CELLS.spawn
  c.evolve = _CELLS.evolve
  c.draw = _CELLS.draw
  return c
end

--
-- shapes suitable for use with spawn() above
-- Pretty self explanatory, set the W and H to represent the width and height of your shape
-- 0 = dead cell, 1 = alive cell

-- Many shapes I used.
GUN = { 0,0,1,0,1,
        1,0,0,0,0,
        0,0,0,1,1,
        0,1,1,0,1,
        1,0,1,0,1; w=5,h=5 }
DIEHARD = { 0,0,0,0,0,0,1,0,
            1,1,0,0,0,0,0,0,
            0,1,0,0,0,1,1,1; w=8,h=3 }        
NARUTO = { 1,0,0,0,0,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,0,0,0,0,1,0,1,1,1,1,1,0,1,1,1,1,1,1,
           1,1,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,
           1,1,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,1,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,
           1,0,1,0,0,1,0,1,0,0,0,0,1,0,1,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,
           1,0,1,0,0,1,0,1,1,1,1,1,1,0,1,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,
           1,0,0,1,0,1,0,1,0,0,0,0,1,0,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,
           1,0,0,1,0,1,0,1,0,0,0,0,1,0,1,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,
           1,0,0,0,1,1,0,1,0,0,0,0,1,0,1,0,0,0,1,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,
           1,0,0,0,1,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,1,1,1,1,1,0,0,0,1,0,0,0,1,1,1,1,1,1,
           0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
           0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,1,1,0,0,
           0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1,0,
           0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,0,0,
           0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,
           0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,0,0,0,0; w = 40, h= 15}

--Incorporated a listener function because I am using a array in my code therefore the array must have a timer method because timer events are sent to the listener.
  local function listener( event )

    thisgen:evolve(nextgen)
    thisgen,nextgen = nextgen,thisgen
   
    thisgen:draw() 

    gen = gen + 1

 end

-- the main routine
function LIFE(w,h)
  -- create two arrays

  thisgen = CELLS(w,h)
  nextgen = CELLS(w,h)
  
  bg = display.newImage("darkspace.jpg", 240, 240, true)


  

  -- create some life using the defined shapes from above - experiemnt and see what happens!
  --This is where we create a shape as defined above at the given coordinates within our bounding grid box below,
  --In this example our bounding grid box is 128 x 128 - set when we call LIFE(12,128)
  --Experiement with the size of the bounding box and remember to give your spawn shapes a starting location that 
  --falls within the bounding box
  
  thisgen:spawn(NARUTO,44,64)
  --thisgen:spawn(DIEHARD,64,64)
  
timer.performWithDelay( 100, listener, 0)
  
end

LIFE(110,128) 