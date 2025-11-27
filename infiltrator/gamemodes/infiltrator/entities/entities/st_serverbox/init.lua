AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
 
	self:SetModel( "models/props_lab/monitor02.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNWBool( "BeingHacked", false )
	self:SetNWBool( "FilesReady", false )
	self:SetNWBool( "Completed", false )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then phys:Wake() end
	self:SetUseType(SIMPLE_USE)
end
 
function ENT:Use( act, ply )
	if ply:Team() == TEAM_INFIL then
		if !self:GetNWBool( "Completed" ) then
			if !self:GetNWBool( "FilesReady" ) then
				if !self:GetNWBool( "BeingHacked" ) then
					ply:InfilMsg( "You started downloading the data.  It will take a few minutes." )
					self:SetNWBool( "BeingHacked", true )
					self:SetSkin( 1 )
					timer.Create( "fileshacking", math.random( 120, 180 ), 1, function()
						if not IsValid( self ) then return end
						self:SetSkin( 0 )
						self:SetNWBool( "BeingHacked", false )
						self:SetNWBool( "FilesReady", true )
					end )
				else
					ply:InfilMsg( "The files are still downloading." )
				end
			else
				self:SetSkin( 0 )
				ply:InfilMsg( "You collected the files." )
				UpdateObjectives( "files", true )
				self:SetNWBool( "Completed", true )
				self:SetNWBool( "FilesReady", false )
				self:SetCompleted( true )
			end
		else
			ply:InfilMsg( "You have already collected the files." )
		end
	else
		if self:GetNWBool( "BeingHacked" ) then
			ply:InfilMsg( "You unplug and confiscate a suspicious drive." )
			self:SetNWBool( "BeingHacked", false )
			self:SetSkin( 0 )
		else
			if self:GetNWBool( "FilesReady" ) then
				ply:InfilMsg( "You unplug and confiscate a suspicious drive." )
				self:SetNWBool( "FilesReady", false )
				self:SetSkin( 0 )
			else
				if self:GetNWBool( "Completed" ) then
					ply:InfilMsg( "It seems like many sensitive files are missing." )
				else
					ply:InfilMsg( "The computer seems to be completely untouched." )
				end
			end
		end
	end
end

function ENT:UpdateTransmitState()        
	return TRANSMIT_ALWAYS
end