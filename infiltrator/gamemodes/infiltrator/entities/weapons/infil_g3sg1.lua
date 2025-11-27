SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "RifleShellEject"

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
SWEP.PrintName				= "General-3"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 54		-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair = true --			= true		-- Set false if you want no crosshair from hip
SWEP.Weight				= 50			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair					= false		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.HoldType 				= "ar2"
SWEP.IconLetter = "i"

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.ViewModel				= "models/weapons/cstrike/c_snip_g3sg1.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_snip_g3sg1.mdl"	-- Weapon world model
SWEP.Base 				= "tfa_scoped_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
sound.Add({
	name = 			"SWeapon_G3SG1.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"^weapons/srp6/d3au1-1_css.wav"
})
sound.Add({
	name = 			"SWeapon_G3SG1.fp.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"weapons/g3sg1/g3sg1-1.wav"
})
if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/g3sg1" ) end
SWEP.Primary.Sound_World			= Sound("SWeapon_G3SG1.1")		-- script that calls the primary fire sound
SWEP.Primary.Sound			= Sound("SWeapon_G3SG1.fp.1")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 240		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 8		-- Size of a clip
SWEP.Primary.DefaultClip			= 32	-- Bullets you start with
SWEP.Primary.KickUp			= 1				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 1			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= 1		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "SniperRound" -- 7.62x51mm
SWEP.Primary.PenetrationMultiplier = 0.65

SWEP.Secondary.ScopeZoom			= 6

SWEP.Secondary.ScopeTable =
	{
		ScopeBorder = Color(0, 0, 0, 255),
		ScopeMaterial = Material("scope/nerf_sharpshot.png"),
		ScopeOverlay = nil,
		ScopeCrosshair = { -- can also be just a Material() value
			r = 0, g = 0, b = 0, a = 255, -- color
			scale = 0 -- scale or crosshair line width if no material specified
		}
	}

SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.55

SWEP.Primary.NumShots	= 1		--how many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 98	--base damage per bullet
SWEP.Primary.Spread		= 0.055	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.001 -- ironsight accuracy, should be the same for shotguns
SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 1.5

-- enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-6.2, -11.2, 1.84)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(9.369, -17.244, -3.689)
SWEP.RunSightsAng = Vector(6.446, 62.852, 0)

SWEP.MoveSpeed = 210/250
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.55

SWEP.RangeCaliber = "7.62x51mm"

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
	lut = ST_RANGE_GRAPHS[ "7.62x51mm" ]
}

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 3, ["type"] = "lua", ["value"] = function( wep, viewmodel, ifp ) 
			wep:CompleteReload()
			wep:SetStatus( TFA.Enum.STATUS_RELOADING_WAIT )
		end, ["client"] = true, ["server"] = true }
	}
}

SWEP.BaseSway = 0.25
SWEP.CurrSway = SWEP.BaseSway
SWEP.AddSway = 0.75
SWEP.MaxSway = 1.5

SWEP.Primary.Velocity = 800 * 3.28

