SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "RifleShellEject"

SWEP.TracerCount = 1
SWEP.TracerName = "Tracer"
SWEP.Category				= "Infiltrator"
SWEP.Author				= "SweptThrone"
SWEP.Manufacturer = "Schmidt"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Baron Bullpup"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 60			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair = true --			= true		-- Set false if you want no crosshair from hip
SWEP.Weight				= 50			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair					= true		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.HoldType 				= "smg"
SWEP.IconLetter = "e"

if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/aug" ) end

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.ViewModel				= "models/weapons/cstrike/c_rif_aug.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_rif_aug.mdl"	-- Weapon world model
SWEP.Base 				= "tfa_scoped_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true

sound.Add({
	name = 			"SWeapon_AUG.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"^weapons/srp6/bullpup-1_css.wav"
						
})
sound.Add({
	name = 			"SWeapon_AUG.fp.1",
	channel = 		CHAN_WEAPON,
	level = 140,
	sound = 			"weapons/aug/aug-1.wav"
						
})

SWEP.Primary.Sound_World = Sound("SWeapon_AUG.1")		-- script that calls the primary fire sound
SWEP.Primary.Sound = Sound("SWeapon_AUG.fp.1")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 540		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30		-- Size of a clip
SWEP.Primary.DefaultClip			= 60	-- Bullets you start with
SWEP.Primary.KickUp			= .4				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .4			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= .1		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "ar2" -- 5.56x45mm

SWEP.Secondary.ScopeZoom			= 4	
SWEP.Secondary.ScopeTable =
	{
		ScopeBorder = Color(0, 0, 0, 255),
		ScopeMaterial = Material("scope/nerf_deadeye.png"),
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
SWEP.Primary.Damage		= 38	--base damage per bullet
SWEP.Primary.Spread		= 0.04	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-7.56, -15, 2.099)
SWEP.IronSightsAng = Vector(1.6, -2.3, -8.7)
SWEP.RunSightsPos = Vector(9.369, -10.908, -3.689)
SWEP.RunSightsAng = Vector(6.446, 64.627, 0)
SWEP.SelectiveFire = true
SWEP.FireModes = {"Auto","Semi"}

SWEP.MoveSpeed = 220/250
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.6

SWEP.RangeCaliber = "5.56x45mm"

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
	lut = ST_RANGE_GRAPHS[ "5.56x45mm" ]
}
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 2.6, ["type"] = "lua", ["value"] = function( wep, viewmodel, ifp ) 
			wep:CompleteReload()
			wep:SetStatus( TFA.Enum.STATUS_RELOADING_WAIT )
		end, ["client"] = true, ["server"] = true }
	}
}

--[[SWEP.Attachments = {
	[ 1 ] = {
		atts = {
			"hunt_poison",
			"hunt_fmj"
		},
		sel = 0,
		default = nil,
		hidden = nil
	}
}
]]--

SWEP.BaseSway = 0.25
SWEP.CurrSway = SWEP.BaseSway
SWEP.AddSway = 0.5
SWEP.MaxSway = 2

SWEP.Primary.Velocity = 970 * 3.28

