
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "RifleShellEject"

SWEP.TracerCount = 1
SWEP.TracerName = "Tracer"
SWEP.Category				= "Infiltrator"
SWEP.Author				= "SweptThrone"
SWEP.Manufacturer = "ES Herstal"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Hailstorm"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 74			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair = true --			= true		-- Set false if you want no crosshair from hip
SWEP.Weight				= 50			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "rpg"
SWEP.IconLetter = "m"

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.ViewModel				= "models/weapons/cstrike/c_smg_p90.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_smg_p90.mdl"	-- Weapon world model
SWEP.Base 				= "tfa_scoped_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true

sound.Add({
	name = 			"SWeapon_P90.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"^weapons/srp6/c90-1_css.wav"
})
sound.Add({
	name = 			"SWeapon_P90.fp.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"weapons/p90/p90-1.wav"
})

if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/p90" ) end
SWEP.Primary.Sound_World			= Sound("SWeapon_P90.1")
SWEP.Primary.Sound			= Sound("SWeapon_P90.fp.1")
SWEP.Primary.RPM				= 800		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 50		-- Size of a clip
SWEP.Primary.DefaultClip			= 100	-- Bullets you start with
SWEP.Primary.KickUp			= .15				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .1			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= .3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "smg1" -- 5.7x28mm
SWEP.Primary.PenetrationMultiplier = 0.575

SWEP.SelectiveFire		= true

SWEP.Secondary.ScopeZoom			= 1.56
SWEP.Secondary.ScopeTable =
	{
		ScopeBorder = Color(0, 0, 0, 0),
		ScopeMaterial = Material("scope/nerf_clearview.png"),
		ScopeOverlay = nil,
		ScopeCrosshair = { -- can also be just a Material() value
			r = 0, g = 0, b = 0, a = 255, -- color
			scale = 0 -- scale or crosshair line width if no material specified
		}
	}

SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.5

SWEP.Primary.NumShots	= 1		--how many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 32	--base damage per bullet
SWEP.Primary.Spread		= 0.025	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0075 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-5.72, -20, 2.24)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(5.75, -6.941, 0)
SWEP.RunSightsAng = Vector(-6.974, 49.881, -5.237)

SWEP.SelectiveFire = false

SWEP.MoveSpeed = 230/250
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8

SWEP.RangeCaliber = "5.7x28mm"

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
	lut = ST_RANGE_GRAPHS[ "5.7x28mm" ]
}

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 2.2, ["type"] = "lua", ["value"] = function( wep, viewmodel, ifp ) 
			wep:CompleteReload()
			wep:SetStatus( TFA.Enum.STATUS_RELOADING_WAIT )
		end, ["client"] = true, ["server"] = true }
	}
}

SWEP.BaseSway = 0.5
SWEP.CurrSway = SWEP.BaseSway
SWEP.AddSway = 0.5
SWEP.MaxSway = 3.5
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

SWEP.Primary.Velocity = 715 * 3.28

