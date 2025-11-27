AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
 
	self:SetModel( "models/props_wasteland/controlroom_storagecloset001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
 
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
	self:SetUseType(SIMPLE_USE)
end

local disguises = {
	{ model = "models/player/gasmask.mdl", class = "a medic guard" },
	{ model = "models/player/riot.mdl", class = "an officer guard" },
	{ model = "models/player/swat.mdl", class = "a heavy guard" },
	{ model = "models/player/urban.mdl", class = "an assault guard" },
	{ model = "models/boreas_cbrn/boreas_cbrn.mdl", class = "a marksman guard" }
}

function ENT:Use( act, ply )
	if ply:Team() == TEAM_INFIL then
		if self:GetCompleted() then
			ply:InfilMsg( "You are already disguised." )
		else
			local rand = math.random( 1, #disguises )
			ply:SetModel( disguises[ rand ].model )
			ply:SetupHands()
			ply:InfilMsg( "You are now disguised as " .. disguises[ rand ].class ..  "." )
			self:EmitSound( "items/ammopickup.wav" )
			self:SetCompleted( true )
			ply:SetNWBool( "IsDisguised", true )
		end
	else
		if self:GetCompleted() then
			ply:InfilMsg( "It seems like a uniform is missing." )
		else
			ply:InfilMsg( "You are already wearing your uniform." )
		end
	end
end

function ENT:UpdateTransmitState()        
	return TRANSMIT_ALWAYS
end