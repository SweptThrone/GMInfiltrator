AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName = "Heavy"
PLAYER.SlowWalkSpeed = 100 * 0.8
PLAYER.WalkSpeed = 160 * 0.8
PLAYER.RunSpeed = 280 * 0.8
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
    self.Player:SetDR( 0.5 )
    self.Player:CapStamina( 100 )
    self.Player:SetWalkSpeed( self.WalkSpeed )
    self.Player:SetRunSpeed( self.RunSpeed )
    self.Player:SetCrouchedWalkSpeed( self.CrouchedWalkSpeed )
    self.Player:SetJumpPower( self.JumpPower )
    self.Player:SetSlowWalkSpeed( self.SlowWalkSpeed )
end

function PLAYER:Loadout()
    self.Player:Give( "infil_" .. INFILTRATOR.Primaries[ self.Player.InfilLoadout[ TEAM_GUARD ][ 2 ] ] ).Dropped = true
    self.Player:Give( "infil_" .. INFILTRATOR.Secondaries[ self.Player.InfilLoadout[ TEAM_GUARD ][ 3 ] ] ).Dropped = true
    self.Player:Give( "infil_knife" ).Dropped = true
end

function PLAYER:SetModel()
	util.PrecacheModel( "models/player/swat.mdl" )
    self.Player:SetModel( "models/player/swat.mdl" )
end

function PLAYER:Death()
end

function PLAYER:GetHandsModel()
	local playermodel = player_manager.TranslateToPlayerModelName( self.Player:GetModel() )
	return player_manager.TranslatePlayerHands( playermodel )
end

player_manager.RegisterClass( "guard_heavy", PLAYER, "player_default" )
