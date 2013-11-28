-- autoloop logic by ixi-audio.net 
-- license : GPL

local Autoloop = pd.Class:new():register("autoloop") -- pd name

function Autoloop:initialize(name, atoms)
  self.inlets = 3
  self.outlets = 3

  self.sequ = {1,1,1,1,1,1,1,1} -- sampling time sequence in 4 float secs
  self.sequIndex = 1
  self.layerIndex = 0 -- next layer to be used
  self.layersStatus = {1,1,1,1,1,1,1,1} -- snd layersStatus active or not
  self.timeOut = 0
  self.start = false
  -- self:error("message")

  return true
end

function Autoloop:postinitialize()
  self.clock = pd.Clock:new():register(self, "bang1")
end

function Autoloop:finalize()
  self.clock:destruct()
end


------------
-- INLETS
------------
function Autoloop:in_1_bang()
  if self.start ~= true then -- init timer
      self:startT()
      self.start = true
  end
end

function Autoloop:in_1_float(value)
  if value == 0 then -- stop timer
      self.start = false
      self.clock:unset()
  else -- init timer
      self:startT()
      self.start = true
  end
end

function Autoloop:in_2_list(list)
    self.layersStatus = list
end

function Autoloop:in_3_list(list)
    self.sequ = list 
end



-- function Autoloop:in_1_stop()
--   self.clock:unset()
-- end  


-----------
-- OUTLETS
-----------

function Autoloop:bang1()
  self:outlet(1, "bang", {})
  self:nextTimeOut() 
end

--------------
--- functions
--------------
function Autoloop:startT()
    self.clock:delay( self.sequ[self.sequIndex] * 1000 ) --  in millisecs
end


function Autoloop:nextTimeOut()
    --calc now next layer and seq to use

    if math.max( unpack( self.sequ )) == 0 then
	pd.post("no sequ is bigger than 0!")
	return true
    end

    self.sequIndex = self.sequIndex + 1

    if self.sequIndex > table.getn(self.sequ) then 
	pd.post("end of seq reached")
	self.sequIndex = 1 -- reset in end
    end
   
    -- if next sequ is 0 then check the following one and so on... until one is not 0
    while self.sequ[self.sequIndex] <= 0 do -- time is zero
       self.sequIndex = self.sequIndex + 1 -- so try next
       if self.sequIndex > table.getn(self.sequ) then --  reset and continue
	    self.sequIndex = 1 -- reset in end
	end
    end

    -- there should be a value in self.sequ[self.sequIndex] 
    -- already or we would not be here

    self:startT() -- calc next timeout

    -- layersStatus. if no item is active
    if math.max( unpack( self.layersStatus )) == 0 then
   	pd.post( "no snd layersStatus active!") 
	return true
    end

    self.layerIndex = self.layerIndex + 1

    if self.layerIndex > table.getn(self.layersStatus) then
	pd.post("last layer reached")
        self.layerIndex = 1 -- reset in end (8)
    end

    while self.layersStatus[self.layerIndex] <= 0 do -- it was off
	self.layerIndex = self.layerIndex + 1 -- try next
	if self.layerIndex > table.getn(self.layersStatus) then
	    self.layerIndex = 1 -- reset in end
	end
    end

    -- broadcast to PD
	--print self.layerIndex, self.sequ[self.sequIndex]
    self:outlet(1, "float", {self.layerIndex} ) -- next layer
    self:outlet(2, "float", {self.sequIndex} ) -- and next seq
    self:outlet(3, "float", {self.sequ[self.sequIndex]}) --currently recording for this long

end


