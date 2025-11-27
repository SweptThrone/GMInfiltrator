SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "RifleShellEject"
SWEP.TracerCount = 1
SWEP.TracerName = "Tracer"
SWEP.Category				= "Infiltrator"
SWEP.Author				= "SweptThrone"
SWEP.Manufacturer = "KHSSG"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Karma AR"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 58			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = true
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
SWEP.IconLetter = "b"

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false --should have left it as original, and let everybody do as little change to the coding as necessary. 
	--But no, you just had to go and screw with the viewmodel.
	--goddammit, you're making me spend a lot of time fixing this mess.
SWEP.ViewModel				= "models/weapons/cstrike/c_rif_ak47.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_rif_ak47.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/ak47" ) end

sound.Add( {
	name = 			"SWeapon_AK47.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"^weapons/srp6/cv47-1_css.wav"
} )
sound.Add({
	name = "SWeapon_AK47.fp.1",
	channel = CHAN_WEAPON,
	level = 140,
	sound = "weapons/ak47/ak47-1.wav"
})

SWEP.Primary.Sound = Sound("SWeapon_AK47.fp.1")
SWEP.Primary.Sound_World = Sound("SWeapon_AK47.1")
SWEP.Primary.RPM			= 480			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30		-- Size of a clip
SWEP.Primary.DefaultClip		= 90		-- Bullets you start with
SWEP.Primary.KickUp				= 0.5		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.4		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.2		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2" -- 7.62x39mm
SWEP.Secondary.IronFOV			= 58		-- How much you 'zoom' in. Less is more! 	

SWEP.Primary.PenetrationMultiplier = 0.8

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 44	-- Base damage per bullet
SWEP.Primary.Spread		= 0.035	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.01 -- Ironsight accuracy, should be the same for shotguns

SWEP.SelectiveFire		= true

SWEP.BlowbackEnabled = false
SWEP.BlowbackVector = Vector(0, -2, 0)
SWEP.Blowback_PistolMode = false
SWEP.Blowback_Shell_Effect = SWEP.LuaShellEffect
SWEP.BlowbackBoneMods = {
	["Stars Fell On Alabama"] = { scale = Vector(1, 1, 1), pos = Vector(0, 2.9, 0), angle = Angle(0, 0, 0) },
}

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-6.52, -15, 1.44)
SWEP.IronSightsAng = Vector(1.899, 0.1, 0.6)
SWEP.RunSightsPos = Vector(9.369, -17.244, -3.689)
SWEP.RunSightsAng = Vector(6.446, 62.852, 0)

SWEP.FireModes = {"Auto","Semi"}

SWEP.MoveSpeed = 215/250
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8

SWEP.RangeCaliber = "7.62x39mm"

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
	lut = ST_RANGE_GRAPHS[ "7.62x39mm" ]
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

SWEP.BaseSway = 1
SWEP.CurrSway = SWEP.BaseSway
SWEP.AddSway = 0.75
SWEP.MaxSway = 5

SWEP.Primary.Velocity = 715 * 3.28

