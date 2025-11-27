--cl_init

include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
end

net.Receive("paydaymethpaynotify", function(len, ply)
	local price = net.ReadInt(32)
	local methBags = net.ReadInt(32)
	local w = Color(255, 255, 255)
	local b = Color(0, 255, 255)
	if methBags == 0 then
		chat.AddText( w, "You don't have any meth to turn in!" )
	elseif methBags == 1 then
		chat.AddText( w, "You turned in ", b, tostring(methBags), " bag ", w, "of meth and got ", b, "$", tostring(methBags * price), w, ".")
	else
		chat.AddText( w, "You turned in ", b, tostring(methBags), " bags ", w, "of meth and got ", b, "$", tostring(methBags * price), w, ".") 
	end
end)