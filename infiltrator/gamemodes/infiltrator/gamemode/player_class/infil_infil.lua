AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName = "Infiltrator"
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
    if bit.band( self.Player.InfilLoadout[ TEAM_INFIL ][ 3 ], INFILTRATOR.Perks.ARMOR ) == INFILTRATOR.Perks.ARMOR then
        self.Player:SetDR( 0.1 )
    end
    self.Player:CapStamina( 100 )
    if bit.band( self.Player.InfilLoadout[ TEAM_INFIL ][ 3 ], INFILTRATOR.Perks.STAMINA ) == INFILTRATOR.Perks.STAMINA then 
        self.Player:CapStamina( 200 )
    end
    self.Player:SetWalkSpeed( self.WalkSpeed )
    self.Player:SetRunSpeed( self.RunSpeed )
    self.Player:SetCrouchedWalkSpeed( self.CrouchedWalkSpeed )
    self.Player:SetJumpPower( self.JumpPower )
    self.Player:SetSlowWalkSpeed( self.SlowWalkSpeed )
end

function PLAYER:Loadout()
    self.Player:Give( "infil_" .. INFILTRATOR.Primaries[ self.Player.InfilLoadout[ TEAM_INFIL ][ 1 ] ] ).Dropped = true
    self.Player:Give( "infil_" .. INFILTRATOR.Secondaries[ self.Player.InfilLoadout[ TEAM_INFIL ][ 2 ] ] ).Dropped = true
    self.Player:Give( "infil_knife" ).Dropped = true
    if bit.band( self.Player.InfilLoadout[ TEAM_INFIL ][ 3 ], INFILTRATOR.Perks.CAMO ) == INFILTRATOR.Perks.CAMO then
        self.Player:Give( "infil_activecamo" ).Dropped = true
    end
    if bit.band( self.Player.InfilLoadout[ TEAM_INFIL ][ 3 ], INFILTRATOR.Perks.SLAMS ) == INFILTRATOR.Perks.SLAMS then
        self.Player:Give( "weapon_slam" ).Dropped = true
    end
    if bit.band( self.Player.InfilLoadout[ TEAM_INFIL ][ 3 ], INFILTRATOR.Perks.THERMAL ) == INFILTRATOR.Perks.THERMAL then
        self.Player.ThermalInlay = true
    end
    if bit.band( self.Player.InfilLoadout[ TEAM_INFIL ][ 3 ], INFILTRATOR.Perks.AMMO ) == INFILTRATOR.Perks.AMMO then
        self.Player:SetAmmo( self.Player:GetAmmoCount( "ar2" ) * 2, "ar2" )
        self.Player:SetAmmo( self.Player:GetAmmoCount( "pistol" ) * 2, "pistol" )
        self.Player:SetAmmo( self.Player:GetAmmoCount( "smg1" ) * 2, "smg1" )
        self.Player:SetAmmo( self.Player:GetAmmoCount( "357" ) * 2, "357" )
        self.Player:SetAmmo( self.Player:GetAmmoCount( "AlyxGun" ) * 2, "AlyxGun" )
        self.Player:SetAmmo( self.Player:GetAmmoCount( "SniperRound" ) * 2, "SniperRound" )
        self.Player:SetAmmo( self.Player:GetAmmoCount( "SniperPenetratedRound" ) * 2, "SniperPenetratedRound" )
    end
end

function PLAYER:SetModel()
	util.PrecacheModel( "models/player/arctic.mdl" )
    self.Player:SetModel( "models/player/arctic.mdl" )
end

function PLAYER:Death()
end

function PLAYER:GetHandsModel()
	local playermodel = player_manager.TranslateToPlayerModelName( self.Player:GetModel() )
	return player_manager.TranslatePlayerHands( playermodel )
end

player_manager.RegisterClass( "infil_infil", PLAYER, "player_default" )
