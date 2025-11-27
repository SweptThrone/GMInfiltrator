AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
 
	self:SetModel( "models/props/cs_office/file_box.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
 
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
	self:SetUseType(SIMPLE_USE)
end
 
function ENT:Use( act, ply )
	if ply:Team() == TEAM_INFIL then
		ply:InfilMsg( "You stole the visitor log." )
		UpdateObjectives( "log", true )
		ply.HasLog = true
		self:Remove()
	else
		ply:InfilMsg( "This is the visitor log." )
	end
end

function ENT:UpdateTransmitState()        
	return TRANSMIT_ALWAYS
end