AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
 
	self:SetModel( "models/props_lab/reciever_cart.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
 
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
	self:SetUseType(SIMPLE_USE)
	self.IsJammed = false
end
 
function ENT:Use( act, ply )
	if ply:Team() == TEAM_INFIL then
		if self.IsJammed then
			ply:InfilMsg( "You already attached the receiver to the server." )
		else
			if ply:GetNWBool( "HasJammer", false ) then
				ply:InfilMsg( "You attached the receiver to the server.  You can now hear guard comms." )
				ply:SetNWBool( "HasJammer", false )
				self.IsJammed = true
				self:EmitSound( "ambient/energy/weld1.wav" )
				self:EmitSound( "npc/attack_helicopter/aheli_damaged_alarm1.wav" )
				UpdateObjectives( "jammer", true )
				self:SetCompleted( true )
				ents.FindByClass( "st_camerabox" )[ 1 ]:SetCompleted( true )
			else
				ply:InfilMsg( "You need to get the receiver first." )
			end
		end
	else
		if self.IsJammed then
			ply:InfilMsg( "You think you hear a slight static buzz coming from the server." )
		else
			ply:InfilMsg( "This is a large server cart." )
		end
	end
end

function ENT:UpdateTransmitState()        
	return TRANSMIT_ALWAYS
end