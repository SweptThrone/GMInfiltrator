AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName = "Medic"
PLAYER.SlowWalkSpeed = 100
PLAYER.WalkSpeed = 160
PLAYER.RunSpeed = 280
PLAYER.CrouchedWalkSpeed = 0.3
PLAYER.DuckSpeed = 0.3
PLAYER.UnDuckSpeed = 0.3
PLAYER.JumpPower = 200
PLAYER.CanUseFlashlight = true 
PLAYER.MaxHealth = 100
PLAYER.MaxArmor = 100
PLAYER.StartHealth = 100
PLAYER.StartArmor = 0
PLAYER.DropWeaponOnDie = false 
PLAYER.TeammateNoCollide = false 
PLAYER.AvoidPlayers = false 
PLAYER.UseVMHands = true 

function PLAYER:Init()
end

function PLAYER:Spawn()
    self.Player:SetDR( 0 )
    self.Player:CapStamina( 150 )
    self.Player:SetWalkSpeed( self.WalkSpeed )
    self.Player:SetRunSpeed( self.RunSpeed )
    self.Player:SetCrouchedWalkSpeed( self.CrouchedWalkSpeed )
    self.Player:SetJumpPower( self.JumpPower )
    self.Player:SetSlowWalkSpeed( self.SlowWalkSpeed )
end

function PLAYER:Loadout()
    self.Player:Give( "infil_" .. INFILTRATOR.Secondaries[ self.Player.InfilLoadout[ TEAM_GUARD ][ 3 ] ] ).Dropped = true
    self.Player:Give( "infil_medkit" ).Dropped = true
    self.Player:Give( "infil_knife" ).Dropped = true
end

function PLAYER:SetModel()
	util.PrecacheModel( "models/player/gasmask.mdl" )
    self.Player:SetModel( "models/player/gasmask.mdl" )
end

function PLAYER:Death()
end

function PLAYER:GetHandsModel()
	local playermodel = player_manager.TranslateToPlayerModelName( self.Player:GetModel() )
	return player_manager.TranslatePlayerHands( playermodel )
end

player_manager.RegisterClass( "guard_medic", PLAYER, "player_default" )
