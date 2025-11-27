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
SWEP.PrintName				= "Mayhem MP-45"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 78			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = true
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "smg"		-- how others view you carrying the weapon
SWEP.IconLetter = "q"

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.ViewModel				= "models/weapons/cstrike/c_smg_ump45.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_smg_ump45.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/ump45" ) end
sound.Add({
	name = 			"SWeapon_UMP45.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"^weapons/srp6/ump-1_css.wav"
})
sound.Add({
	name = 			"SWeapon_UMP45.fp.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"weapons/ump45/ump45-1.wav"
})
SWEP.Primary.Sound_World			= Sound("SWeapon_UMP45.1")		-- Script that calls the primary fire sound
SWEP.Primary.Sound			= Sound("SWeapon_UMP45.fp.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 600			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 25		-- Size of a clip
SWEP.Primary.DefaultClip		= 75		-- Bullets you start with
SWEP.Primary.KickUp				= 0.5		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.4		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.1		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "AlyxGun" -- .45 ACP

SWEP.Secondary.IronFOV			= 58		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 36	-- Base damage per bullet
SWEP.Primary.Spread		= 0.02	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.01 -- Ironsight accuracy, should be the same for shotguns
SWEP.FireModes = {"Auto","Semi"}
SWEP.SelectiveFire		= true

SWEP.BlowbackEnabled = false
SWEP.BlowbackVector = Vector(0, -1, 0)
SWEP.Blowback_PistolMode = false
SWEP.Blowback_Shell_Effect = SWEP.LuaShellEffect
SWEP.BlowbackBoneMods = nil

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-8.761, -12, 2.799)
SWEP.IronSightsAng = Vector(-1.3, -0.301, -1.803)
SWEP.RunSightsPos = Vector(8.135, -7.776, 0)
SWEP.RunSightsAng = Vector(-5.575, 39.759, 0)

SWEP.MoveSpeed = 230/250
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8

SWEP.RangeCaliber = ".45 ACP"

DEFINE_BASECLASS( SWEP.Base )
function SWEP:Think2()
	BaseClass.Think2( self )
	if self:GetOwner():Crouching() and self:GetHoldType() == "passive" then
		self:SetHoldType( "normal" )
	end
end

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
		{ ["time"] = 2.1, ["type"] = "lua", ["value"] = function( wep, viewmodel, ifp ) 
			wep:CompleteReload()
			wep:SetStatus( TFA.Enum.STATUS_RELOADING_WAIT )
		end, ["client"] = true, ["server"] = true }
	}
}

SWEP.BaseSway = 1
SWEP.CurrSway = SWEP.BaseSway
SWEP.AddSway = 0.5
SWEP.MaxSway = 5
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

SWEP.Primary.Velocity = 260 * 3.28

