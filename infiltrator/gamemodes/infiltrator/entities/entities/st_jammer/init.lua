AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
 
	self:SetModel( "models/props_lab/reciever01b.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
 
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
	self:SetUseType(SIMPLE_USE)
end
 
function ENT:Use( act, ply )
	if ply:Team() == TEAM_INFIL then
		ply:InfilMsg( "You picked up the jammer." )
		self:Remove()
		ply:SetNWBool( "HasJammer", true )
	else
		ply:InfilMsg( "This looks like some odd computer." )
	end
end

function ENT:UpdateTransmitState()        
	return TRANSMIT_ALWAYS
end