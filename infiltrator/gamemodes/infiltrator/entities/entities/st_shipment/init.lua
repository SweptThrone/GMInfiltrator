AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
 
	self:SetModel( "models/props_junk/wood_crate002a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
	self:SetUseType(SIMPLE_USE)
	self.CurHealth = 250
	self:PrecacheGibs()

end

function ENT:OnTakeDamage( nfo )

	self.CurHealth = self.CurHealth - nfo:GetDamage()
	if self.CurHealth <= 0 then
		nfo:GetAttacker():InfilMsg( "You destroyed the shipment." )
		UpdateObjectives( "shipment", true )
		self:GibBreakServer( Vector() )
		self:Remove()
	end

end
 
function ENT:Use( act, ply )

	if ply:Team() == TEAM_INFIL then
		ply:InfilMsg( "This is a shipment of goods.  It looks fragile." )
	else
		ply:InfilMsg( "This is a shipment of goods for the facility." )
	end

end


function ENT:UpdateTransmitState()        
	return TRANSMIT_ALWAYS
end