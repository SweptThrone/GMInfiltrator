--init.lua
--all the goods go here
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props/CS_militia/van.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end
	self:SetUseType(SIMPLE_USE)
	
	local child = ents.Create( "prop_dynamic" )
	child:SetModel( "models/props/CS_militia/van_glass.mdl" )
	child:SetPos(self:GetPos())
	child:SetAngles(self:GetAngles())
	child:SetParent(self)
	self:DeleteOnRemove( child )
	child:Spawn()
end

function ENT:OnRemove()
	
end

function ENT:Use(act, ply)
	if ply:Team() == TEAM_INFIL then
		if BOREAS_OBJECTIVES[ "files" ] and BOREAS_OBJECTIVES[ "log" ] and BOREAS_OBJECTIVES[ "pressure" ]
		and BOREAS_OBJECTIVES[ "shipment" ] and BOREAS_OBJECTIVES[ "notes" ] and BOREAS_OBJECTIVES[ "rocket" ] then
			ply:Exfiltrate()

			self:EmitSound("doors/default_stop.wav")
		else
			ply:InfilMsg( "You have not completed all of the objectives yet." )
		end
	else
		ply:InfilMsg( "It's a suspicious van..." )	
	end

end

function ENT:UpdateTransmitState()        
	return TRANSMIT_ALWAYS
end