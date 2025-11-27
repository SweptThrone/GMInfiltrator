AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
 
	self:SetModel( "models/props_pipes/valvewheel002.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
	self:SetUseType(SIMPLE_USE)
	self.Pressure = 100
	self.Blown = false

end
 
function ENT:Use( act, ply )
	if ply:Team() == TEAM_GUARD then
		if self.Blown then
			ply:InfilMsg( "The pipes are blown." )
		else
			ply:InfilMsg( "The pressure is at a normal level." )
		end
	else
		self.Pressure = self.Pressure + 25
		if !self.Blown then
			self:EmitSound( "ambient/levels/canals/toxic_slime_sizzle3.wav" )
		end
		if self.Pressure >= 600 then
			if !self.Blown then
				self:EmitSound( "physics/metal/metal_solid_impact_bullet1.wav" )
			end
			ply:InfilMsg( "You have successfully overloaded the pressure." )
			UpdateObjectives( "pressure", true )
			self:SetCompleted( true )
			self.Blown = true
		end
	end
end

function ENT:Think()
	if self.Blown then return end
	self.Pressure = math.Clamp( self.Pressure - 10, 100, 700 )
end

function ENT:UpdateTransmitState()        
	return TRANSMIT_ALWAYS
end