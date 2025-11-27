SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "ShellEject"

SWEP.TracerCount = 1
SWEP.TracerName = "Tracer"
SWEP.Category				= "Infiltrator"
SWEP.Author				= "SweptThrone"
SWEP.Manufacturer = "K&M USA"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Spec Ops 45"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 45			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair = true 
SWEP.DrawCrosshairIS = true
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
SWEP.IconLetter = "y"

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.ViewModel				= "models/weapons/cstrike/c_pist_usp.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pist_usp.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
sound.Add({
	name = 			"SWeapon_USP.2",
	channel = 		CHAN_WEAPON,
	level = 100,
	sound = 			"^weapons/srp6/tactical-2_css.wav"
})

sound.Add({
	name = 			"SWeapon_USP.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"^weapons/srp6/tactical-1_css.wav"
})

sound.Add({
	name = 			"SWeapon_USP.fp.2",
	channel = 		CHAN_WEAPON,
	level = 100,
	sound = 			"weapons/usp/usp1.wav"
})

sound.Add({
	name = 			"SWeapon_USP.fp.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"weapons/usp/usp_unsil-1.wav"
})

if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/usp45" ) end

SWEP.Primary.Sound_World			= Sound("SWeapon_USP.1")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound_World = Sound("SWeapon_USP.2")
SWEP.Primary.Sound			= Sound("SWeapon_USP.fp.1")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound = Sound("SWeapon_USP.fp.2")
SWEP.Primary.RPM			= 400			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 12		-- Size of a clip
SWEP.Primary.DefaultClip		= 36		-- Bullets you start with
SWEP.Primary.KickUp				= 0.5		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.45		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.2		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "AlyxGun" -- .45 ACP

SWEP.Secondary.IronFOV			= 58		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 41	-- Base damage per bullet
SWEP.Primary.Spread		= 0.02	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.01 -- Ironsight accuracy, should be the same for shotguns

SWEP.CanBeSilenced		= false

SWEP.BlowbackEnabled = false
SWEP.BlowbackVector = Vector(0, -2, -1)
SWEP.BlowbackAngle = Angle(10, 0, 0)
SWEP.Blowback_PistolMode = true
SWEP.Blowback_Shell_Effect = SWEP.LuaShellEffect
SWEP.BlowbackBoneMods = {
	["slide"] = { scale = Vector(1, 1, 1), pos = Vector(-0.91, 0, 0), angle = Angle(0, 0, 0) },
}

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-5.881, -15, 1.879)
SWEP.IronSightsAng = Vector(0.1, 0.1, 0)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-9.469, -1.701, 0)

SWEP.DisableIdleAnimations = false

SWEP.MoveSpeed = 240/250
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8

SWEP.RangeCaliber = ".45 ACP"

SWEP.Primary.FalloffMetricBased = true
SWEP.Primary.RangeFalloffLUT = {
	bezier = true, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "quintic", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "meters", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = ST_RANGE_GRAPHS[ ".45 ACP" ]
}

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 1.6, ["type"] = "lua", ["value"] = function( wep, viewmodel, ifp ) 
			wep:CompleteReload()
			wep:SetStatus( TFA.Enum.STATUS_RELOADING_WAIT )
		end, ["client"] = true, ["server"] = true }
	},

	[ACT_VM_RELOAD_SILENCED] = {
		{ ["time"] = 1.6, ["type"] = "lua", ["value"] = function( wep, viewmodel, ifp ) 
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

SWEP.Primary.Velocity = 250 * 3.28

