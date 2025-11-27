SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "ShellEject"

SWEP.TracerCount = 1
SWEP.TracerName = "Tracer"
SWEP.Category				= "Infiltrator"
SWEP.Author				= "SweptThrone"
SWEP.Manufacturer = "Gloche"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Galleon-18"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 41			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = true
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
SWEP.IconLetter = "c"

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.ViewModel				= "models/weapons/cstrike/c_pist_glock18.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pist_glock18.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
sound.Add({
	name = 			"SWeapon_Glock.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"^weapons/srp6/sidearm-1_css.wav"
})
sound.Add({
	name = 			"SWeapon_Glock.fp.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"weapons/glock/glock18-1.wav"
})
if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/glock18" ) end
SWEP.Primary.Sound_World			= Sound("SWeapon_Glock.1")		-- Script that calls the primary fire sound
SWEP.Primary.Sound			= Sound("SWeapon_Glock.fp.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 400			-- This is in Rounds Per Minute
SWEP.Primary.RPM_Burst				= 1200
SWEP.Primary.ClipSize			= 20		-- Size of a clip
SWEP.Primary.DefaultClip		= 100		-- Bullets you start with
SWEP.Primary.KickUp				= 0.3		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "pistol" -- 9x19mm
SWEP.FireModes = {"Semi","3Burst"}
SWEP.DefaultFireMode     = "Semi"
SWEP.Secondary.IronFOV			= 58		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 37	-- Base damage per bullet
SWEP.Primary.Spread		= 0.025	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.01 -- Ironsight accuracy, should be the same for shotguns

SWEP.SelectiveFire		= true
SWEP.OnlyBurstFire = true

SWEP.BlowbackEnabled = false
SWEP.BlowbackVector = Vector(0, -2, -2)
SWEP.BlowbackAngle = Angle(10, 0, 0)
SWEP.Blowback_PistolMode = true
SWEP.Blowback_Shell_Effect = SWEP.LuaShellEffect
SWEP.BlowbackBoneMods = {
	["Slide"] = { scale = Vector(1, 1, 1), pos = Vector(0, -1, 0), angle = Angle(0, 0, 0) },
}

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-5.801, -10, 1.879)
SWEP.IronSightsAng = Vector(0.8, -0.101, 0.6)
SWEP.RunSightsPos = Vector(6.736, -2.495, 0)
SWEP.RunSightsAng = Vector(-9.343, 12.324, 0)

SWEP.MoveSpeed = 240/250
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8

SWEP.RangeCaliber = "9x19mm"

SWEP.Primary.FalloffMetricBased = true
SWEP.Primary.RangeFalloffLUT = {
	bezier = true, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "quintic", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "meters", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = ST_RANGE_GRAPHS[ "9x19mm" ]
}

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 1.5, ["type"] = "lua", ["value"] = function( wep, viewmodel, ifp ) 
			wep:CompleteReload()
			wep:SetStatus( TFA.Enum.STATUS_RELOADING_WAIT )
		end, ["client"] = true, ["server"] = true }
	}
}

SWEP.BaseSway = 1.5
SWEP.CurrSway = SWEP.BaseSway
SWEP.AddSway = 2
SWEP.MaxSway = 4.5
SWEP.Attachments = {
	[ 1 ] = {
		atts = {
			"infil_aimtype"
		},
		sel = 0,
		default = nil,
		hidden = nil
	}
}

SWEP.Primary.Velocity = 375 * 3.28

