-- autoloop logic by ixi-audio.net 
-- license : GPL

local Rpitch = pd.Class:new():register("rpitch") -- pd name

function Rpitch:initialize(name, atoms)
    self.inlets = 4
    self.outlets = 1

    self.state = 0
    self.pmin = 0.5
    self.prange = 2
    self.floatyes = 1

    math.randomseed( os.time() )
    -- self:error("message")

    return true
end

function Rpitch:postinitialize()

end

function Rpitch:finalize()
 
end


	
function Rpitch:in_1_float(n)
	self.state = n
	pd.post(tostring(n))
end

function Rpitch: in_1_bang()
	self:calcRandPitch()
end

function Rpitch:in_2_float(n)
	pd.post(tostring(n))
	self.pmin = n
end

function Rpitch:in_3_float(n)
	pd.post(tostring(n))
	self.prange = n
end
		
function Rpitch:in_4_float(n)
	if n < 1 then
		n = 1
	end
	self.floatyes = n
end
		
function Rpitch:calcRandPitch()
	    if self.state then
	    	--if self.pmin==0 and self.pmax==1:
		--	self._outlet(1, seed.random())
		--	return
		--r = seed.randint(self.pmin, self.pmax)
		--if self.floatyes : r += seed.random()
		--r = seed.uniform(self.pmin, self.pmin+self.prange)
		r = math.random() + math.random(self.pmin, self.pmin+self.prange-1)
		if self.floatyes == 0 then
		   r = math.floor(r)
		end
		if r == 0 then
			r = 1 -- avoid 0
		end
		self:outlet(1, "float", {r} ) 
	end
end
		
