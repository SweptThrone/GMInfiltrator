AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
 
	self:SetModel( "models/props_lab/clipboard.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
 
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
	self:SetUseType(SIMPLE_USE)
end
 
function ENT:Use( act, ply )
	if ply:Team() == TEAM_INFIL then
		ply:InfilMsg( "You stole the research notes." )
		UpdateObjectives( "notes", true )
		ply.HasNotes = true
		self:Remove()
	else
		ply:InfilMsg( "These are research notes." )
	end
end

function ENT:UpdateTransmitState()        
	return TRANSMIT_ALWAYS
end