SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "ShellEject"

SWEP.TracerCount = 1
SWEP.TracerName = "Tracer"
SWEP.Category				= "Infiltrator"
SWEP.Author				= "SweptThrone"
SWEP.Manufacturer = "Magnum Research"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Desert Falcon"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 35			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = true
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
SWEP.IconLetter = "f"

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.ViewModel				= "models/weapons/cstrike/c_pist_deagle.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pist_deagle.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

sound.Add({
	name = 			"SWeapon_DEagle.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"^weapons/srp6/nighthawk-1_css.wav"
})
sound.Add({
	name = 			"SWeapon_DEagle.fp.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"weapons/deagle/deagle-1.wav"
})
if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/deserteagle" ) end
SWEP.Primary.Sound_World			= Sound("SWeapon_DEagle.1")		-- Script that calls the primary fire sound
SWEP.Primary.Sound			= Sound("SWeapon_DEagle.fp.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 267			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 7		-- Size of a clip
SWEP.Primary.DefaultClip		= 21		-- Bullets you start with
SWEP.Primary.KickUp				= 4		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 3.5		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 2		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "357" -- .50 AE

SWEP.Secondary.IronFOV			= 58		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 66	-- Base damage per bullet
SWEP.Primary.Spread		= 0.03	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.02 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-6.281, -9.681, 0.239)
SWEP.IronSightsAng = Vector(2.5, 0.1, 0)
SWEP.RunSightsPos = Vector(2.405, -17.334, -15.011)
SWEP.RunSightsAng = Vector(70, 0, 0)

SWEP.MoveSpeed = 230/250
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8

SWEP.RangeCaliber = ".50 AE"

SWEP.Primary.FalloffMetricBased = true
SWEP.Primary.RangeFalloffLUT = {
	bezier = true, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "quintic", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "meters", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = ST_RANGE_GRAPHS[ ".50 AE" ]
}

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 1.6, ["type"] = "lua", ["value"] = function( wep, viewmodel, ifp ) 
			wep:CompleteReload()
			wep:SetStatus( TFA.Enum.STATUS_RELOADING_WAIT )
		end, ["client"] = true, ["server"] = true }
	}
}

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

SWEP.BaseSway = 1.5
SWEP.CurrSway = SWEP.BaseSway
SWEP.AddSway = 3
SWEP.MaxSway = 6

SWEP.Primary.Velocity = 470 * 3.28

