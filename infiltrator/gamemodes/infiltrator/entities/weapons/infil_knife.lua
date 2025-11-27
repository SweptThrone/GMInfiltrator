SWEP.Base = "tfa_melee_base"
SWEP.Category = "Infiltrator"
SWEP.PrintName = "Knife"
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.UseHands = true
SWEP.HoldType = "knife"
SWEP.DrawCrosshair = true -- = false
SWEP.Primary.Damage = 35
SWEP.Primary.RPM = 400
SWEP.Slot = 2
SWEP.Primary.Directional = false

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.DisableIdleAnimations = false

SWEP.Secondary.CanBash = false
SWEP.Secondary.MaxCombo = -1
SWEP.Primary.MaxCombo = -1

sound.Add({
	['name'] = "SWeapon_Knife.Draw",
	['channel'] = CHAN_WEAPON,
	['sound'] = { "weapons/knife/knife_deploy1.wav" },
	['pitch'] = {100,100},
    ['level'] = 50
})
sound.Add({
	['name'] = "SWeapon_Knife.Slash1",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/knife/knife_slash1.wav"},
	['pitch'] = {100,100},
    ['level'] = 80
})
sound.Add({
	['name'] = "SWeapon_Knife.Slash2",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/knife/knife_slash2.wav"},
	['pitch'] = {100,100},
    ['level'] = 80
})
sound.Add({
	['name'] = "SWeapon_Knife.HitFleshSlash",
	['channel'] = CHAN_WEAPON,
	['sound'] = { "weapons/knife/knife_hit1.wav", "weapons/knife/knife_hit2.wav",
                    "weapons/knife/knife_hit3.wav", "weapons/knife/knife_hit4.wav" },
	['pitch'] = {100,100},
    ['level'] = 80
})
sound.Add({
	['name'] = "SWeapon_Knife.HitFleshStab",
	['channel'] = CHAN_WEAPON,
	['sound'] = { "weapons/knife/knife_stab.wav" },
	['pitch'] = {100,100},
    ['level'] = 80
})
sound.Add({
	['name'] = "SWeapon_Knife.HitWall",
	['channel'] = CHAN_WEAPON,
	['sound'] = { "weapons/knife/knife_hitwall1.wav" },
	['pitch'] = {100,100},
    ['level'] = 80
})
sound.Add({
    ['name'] = "SWeapon_Knife.Miss",
    ['channel'] = CHAN_WEAPON,
    ['sound'] = {
        "weapons/knife/knife_slash1.wav", "weapons/knife/knife_slash2.wav"
    },
    ['pitch'] = {90,110},
    ['level'] = 50
})

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("SWeapon_Knife.Draw") }
	}
}

SWEP.Primary.Attacks = {
	{
		['act'] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 60, -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dir'] = Vector(50,0,-10), -- Trace dir/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dmg'] = 35, --This isn't overpowered enough, I swear!!
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.15, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "SWeapon_Knife.Miss", -- Sound ID
		['snd_delay'] = 0.15,
		["viewpunch"] = Angle(0,0,0), --viewpunch angle
		['end'] = 0.4, --time before next attack
		['hull'] = 48, --Hullsize
		['direction'] = "W", --Swing dir,
		['hitflesh'] = "SWeapon_Knife.HitFleshSlash",
		['hitworld'] = "SWeapon_Knife.HitWall"
	}
}

SWEP.Secondary.Attacks = {
	{
		['act'] = ACT_VM_SECONDARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 60, -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dir'] = Vector(-30,0,0), -- Trace dir/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dmg'] = 65, --This isn't overpowered enough, I swear!!
		['dmgtype'] = bit.bor(DMG_SLASH,DMG_ALWAYSGIB), --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.2, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "SWeapon_Knife.Miss", -- Sound ID
		['snd_delay'] = 0.2,
		["viewpunch"] = Angle(0,0,0), --viewpunch angle
		['end'] = 1, --time before next attack
		['hull'] = 48, --Hullsize
		['direction'] = "S", --Swing dir,
		['hitflesh'] = "SWeapon_Knife.HitFleshStab",
		['hitworld'] = "SWeapon_Knife.HitWall"
	}
}

SWEP.InspectPos = Vector()
SWEP.InspectAng = Vector()

if CLIENT then SWEP.WepSelectIcon = surface.GetTextureID( "stselect/knife_select" ) end
SWEP.IconLetter = "j"

