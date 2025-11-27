SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0.0 --The delay to actually eject things
SWEP.LuaShellEffect = "ShotgunShellEject"

SWEP.TracerCount = 1
SWEP.TracerName = "Tracer"
SWEP.Category				= "Infiltrator"
SWEP.Author				= "SweptThrone"
SWEP.Manufacturer = "Leone"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Serpent Shotgun"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 62			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = true
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"
SWEP.IconLetter = "B"

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.ViewModel				= "models/weapons/cstrike/c_shot_xm1014.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_shot_xm1014.mdl"	-- Weapon world model
SWEP.Base 				= "tfa_shotty_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
sound.Add({
	name = 			"SWeapon_XM1014.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"^weapons/srp6/yg1265auto-1_css.wav"
})
sound.Add({
	name = 			"SWeapon_XM1014.fp.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"weapons/xm1014/xm1014-1.wav"
})

if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/xm1014" ) end
SWEP.Primary.Sound_World			= Sound("SWeapon_XM1014.1")		-- script that calls the primary fire sound
SWEP.Primary.Sound			= Sound("SWeapon_XM1014.fp.1")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 240		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 7			-- Size of a clip
SWEP.Primary.DefaultClip			= 14	-- Default number of bullets in a clip
SWEP.Primary.KickUp			= 3.75 * 0.666			-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 3.25 * 0.666		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= 1 * 0.666	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot" -- 12 Gauge

SWEP.Secondary.IronFOV			= 58		-- How much you 'zoom' in. Less is more! 

SWEP.ShellTime			= 0.75

SWEP.Primary.NumShots	= 9		-- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage		= 18	-- Base damage per bullet
SWEP.Primary.Spread		= 0.055	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.055	-- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.SpreadMultiplierMax = 1
-- Because irons don't magically give you less pellet spread!
-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-6.841, -12, 1.08)
SWEP.IronSightsAng = Vector(0, -0.801, 0)
SWEP.RunSightsPos = Vector(5.748, -13.78, 4.015)
SWEP.RunSightsAng = Vector(-20.67, 46.023, 0)
SWEP.MoveSpeed = 215/250
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.Primary.Force = 0

SWEP.RangeCaliber = "12 Gauge"

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
	lut = ST_RANGE_GRAPHS[ "12 Gauge" ]
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

SWEP.Primary.Velocity = 400 * 3.28

