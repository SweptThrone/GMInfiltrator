local RANGE_BUFF = 4

if CLIENT then
    language.Add( "SniperRound_ammo", "Heavy Rifle Ammo" )
    language.Add( "AlyxGun_ammo", "Medium Pistol Ammo" )
    language.Add( "Thumper_ammo", "Shotgun Slugs" )

    surface.CreateFont( "CSKI", {
        font = "csd",
        size = 72,
        additive = true
    } )

    surface.CreateFont( "LiteralKI", {
        font = "coolvetica",
        size = 24,
        additive = true
    } )

    local function AddCSKI( class, char )
        killicon.AddFont( class, "CSKI", char, Color( 255, 96, 0 ) )
    end
    local function AddLiteralKI( class, wep )
        killicon.AddFont( class, "LiteralKI", wep, Color( 255, 96, 0 ) )
    end
    local function AddHLKI( class, char )
        killicon.AddFont( class, "HL2MPTypeDeath", char, Color( 255, 96, 0 ) )
    end
    AddLiteralKI( "strp_annabelle", "[Winfield 92 Holdout]" )
    AddLiteralKI( "strp_d_colt", "[Caldwell M1911]" )
    AddLiteralKI( "strp_d_thompson", "[Thompson M1A1]" )
    AddLiteralKI( "strp_d_bar", "[CKAR]" )
    AddLiteralKI( "strp_d_kar98k", "[Kar98k]" )
    AddLiteralKI( "strp_d_kar98k_scoped", "[Kar98k Scoped]" )
    AddLiteralKI( "strp_d_garand", "[M1 Harland]" )
    AddLiteralKI( "strp_d_m1carbine", "[M1A1 Carbine]" )
    AddLiteralKI( "strp_d_c96", "[Dolch 96]" )
    AddLiteralKI( "strp_d_mp40", "[MP40]" )
    AddLiteralKI( "strp_d_p38", "[P38]" )
    AddLiteralKI( "strp_d_springfield", "[Springfield M1903]" )
    AddLiteralKI( "strp_d_mp44", "[Stg 44]" )

    AddHLKI( "strp_spas12", "0" )
    AddHLKI( "strp_python", "." )
    AddHLKI( "strp_mp7", "/" )
    AddHLKI( "strp_uspmatch", "-" )

    AddCSKI( "strp_elite", "s" )
    AddCSKI( "strp_p228", "a" )
    AddCSKI( "strp_glock", "c" )
    AddCSKI( "strp_glock_auto", "c" )
    AddCSKI( "strp_aug", "e" )
    AddCSKI( "strp_famas", "t" )
    AddCSKI( "strp_ak47", "b" )
    AddCSKI( "strp_g3sg1", "i" )
    AddCSKI( "strp_p90", "m" )
    AddCSKI( "strp_fiveseven", "u" )
    AddCSKI( "strp_galil", "v" )
    AddCSKI( "strp_mac10", "l" )
    AddCSKI( "strp_usp_nosup", "y" )
    AddCSKI( "strp_usp", "y" )
    AddCSKI( "strp_mp5", "x" )
    AddCSKI( "strp_ump45", "q" )
    AddCSKI( "strp_knife", "j" )
    AddCSKI( "strp_sg550", "o" )
    AddCSKI( "strp_sg552", "A" )
    AddCSKI( "strp_m3", "k" )
    AddCSKI( "strp_m3_civ", "k" )
    AddCSKI( "strp_xm1014", "B" )
    AddCSKI( "strp_m249", "z" )
    AddCSKI( "strp_awp", "r" )
    AddCSKI( "strp_m4a1_nosup", "w" )
    AddCSKI( "strp_m4a1_civ", "w" )
    AddCSKI( "strp_m4a1", "w" )
    AddCSKI( "strp_deagle", "f" )
    AddCSKI( "strp_tmp", "d" )
    AddCSKI( "strp_scout", "n" )
end

sound.Add({
	name = 			"mp5_foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/foley.mp3"
})

sound.Add({
	name = 			"mp5_magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/magout.mp3"
})

sound.Add({
	name = 			"mp5_magin1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/magin1.mp3"
})

sound.Add({
	name = 			"mp5_magin2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/magin2.mp3"
})

sound.Add({
	name = 			"mp5_boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/boltback.mp3"
})

sound.Add({
	name = 			"mp5_boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/boltslap.mp3"
})

sound.Add({
	name = 			"mp5_cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/cloth.mp3"
})

sound.Add({
	name = 			"mp5_safety",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/safety.mp3"
})

sound.Add({
	name = 			"Weapon_beretta92.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_clipout.mp3"
})

sound.Add({
	name = 			"Weapon_beretta92.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_clipin.mp3"
})

sound.Add({
	name = 			"Weapon_beretta92.Sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_sliderelease.mp3"
})

sound.Add({
	name = 			"Weapon_beretta92.Slidepull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_slidepull.mp3"
})

sound.Add({
	name = 			"Weapon_beretta92.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_slideback.mp3"
})

hook.Add( "TFA_GetStat", "PenetrationNerfs", function(wep,stat,value)
    if string.find( wep.Category, "STRP" ) and stat == "Primary.PenetrationPower" then
        if wep:GetPrimaryAmmoType() == 12 then -- .45 ammo
            return value * 0.4
        end
        if wep:GetPrimaryAmmoType() == 7 then -- buckshot
            return 5 -- const, goes through glass and like nothing else
        end
        return value / 2
    end

    if wep.Category == "CS:S Worldmodels" and stat == "Primary.SpreadMultiplierMax" then
        return 1
    end
end )

local function FMJify( tab )
    local newTab = table.Copy( tab )
    local highestRange = newTab[ #newTab ].range
    highestRange = highestRange * 1.45
    local roundedHighest = ( highestRange / 25 ) - ( ( highestRange % 25 ) / 25 )
    roundedHighest = roundedHighest * 25
    for i = #newTab, 1, -1 do
        newTab[ i ].range = roundedHighest - 25 * ( #newTab - i )
    end
    table.insert( newTab, 1, { damage = 1, range = 0 } )
    return newTab
end

local function Antiquify( tab )
    local newTab = table.Copy( tab )
    for k,v in pairs( newTab ) do
        v.range = v.range * 0.95
    end
    return newTab
end

local function Explosify( tab )
    local newTab = table.Copy( tab )
    for k,v in pairs( newTab ) do
        v.range = v.range * 0.45
    end
    return newTab
end

local function Poisonify( tab )
    local newTab = table.Copy( tab )
    for k,v in pairs( newTab ) do
        v.range = v.range * 0.8
    end
    return newTab
end

local function Dragonify( tab )
    local newTab = table.Copy( tab )
    for k,v in pairs( newTab ) do
        v.range = v.range * 0.5
    end
    return newTab
end

local function Flechettify( tab )
    local newTab = table.Copy( tab )
    for k,v in pairs( newTab ) do
        v.range = v.range * 0.75
    end
    return newTab
end

ST_RANGE_GRAPHS = {
    [ "5.56x45mm" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.95 },
        { range = 50, damage = 0.9 },
        { range = 75, damage = 0.85 },
        { range = 100, damage = 0.8 },
        { range = 125, damage = 0.75 },
        { range = 150, damage = 0.65 },
        { range = 175, damage = 0.55 },
        { range = 200, damage = 0.5 },
        { range = 225, damage = 0.45 },
        { range = 250, damage = 0.4 },
        { range = 300, damage = 0.3 },
        { range = 350, damage = 0.2 },
        { range = 400, damage = 0.1 },
        { range = 450, damage = 0 },
    },

    [ "7.62x39mm" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.975 },
        { range = 50, damage = 0.95 },
        { range = 75, damage = 0.925 },
        { range = 100, damage = 0.9 },
        { range = 125, damage = 0.8 },
        { range = 150, damage = 0.7 },
        { range = 175, damage = 0.55 },
        { range = 200, damage = 0.45 },
        { range = 250, damage = 0.35 },
        { range = 300, damage = 0.25 },
        { range = 350, damage = 0.15 },
        { range = 400, damage = 0.075 },
        { range = 450, damage = 0 },
    },

    [ "Pulse Plugs" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.95 },
        { range = 50, damage = 0.9 },
        { range = 75, damage = 0.85 },
        { range = 100, damage = 0.75 },
        { range = 125, damage = 0.65 },
        { range = 150, damage = 0.55 },
        { range = 175, damage = 0.4 },
        { range = 200, damage = 0.25 },
        { range = 225, damage = 0 }
    },

    [ ".338 Lapua" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.975 },
        { range = 50, damage = 0.95 },
        { range = 75, damage = 0.925 },
        { range = 100, damage = 0.9 },
        { range = 125, damage = 0.875 },
        { range = 150, damage = 0.85 },
        { range = 175, damage = 0.825 },
        { range = 200, damage = 0.8 },
        { range = 225, damage = 0.75 },
        { range = 250, damage = 0.7 },
        { range = 275, damage = 0.65 },
        { range = 300, damage = 0.6 },
        { range = 325, damage = 0.55 },
        { range = 350, damage = 0.5 },
        { range = 375, damage = 0.45 },
        { range = 400, damage = 0.4 },
        { range = 450, damage = 0.3 },
        { range = 500, damage = 0.2 },
        { range = 550, damage = 0.1 },
        { range = 600, damage = 0 }
    },

    [ ".50 AE" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.975 },
        { range = 50, damage = 0.95 },
        { range = 75, damage = 0.925 },
        { range = 100, damage = 0.9 },
        { range = 125, damage = 0.75 },
        { range = 150, damage = 0.6 },
        { range = 175, damage = 0.45 },
        { range = 200, damage = 0.3 },
        { range = 225, damage = 0.15 },
        { range = 250, damage = 0 }
    },

    [ "5.7x28mm" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.95 },
        { range = 50, damage = 0.9 },
        { range = 75, damage = 0.85 },
        { range = 100, damage = 0.8 },
        { range = 125, damage = 0.75 },
        { range = 150, damage = 0.65 },
        { range = 175, damage = 0.5 },
        { range = 200, damage = 0.35 },
        { range = 225, damage = 0.2 },
        { range = 250, damage = 0.05 },
        { range = 275, damage = 0 }
    },

    [ "7.62x51mm" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.975 },
        { range = 50, damage = 0.95 },
        { range = 75, damage = 0.9 },
        { range = 100, damage = 0.85 },
        { range = 125, damage = 0.8 },
        { range = 150, damage = 0.75 },
        { range = 175, damage = 0.7 },
        { range = 200, damage = 0.65 },
        { range = 225, damage = 0.6 },
        { range = 250, damage = 0.55 },
        { range = 275, damage = 0.5 },
        { range = 300, damage = 0.4 },
        { range = 350, damage = 0.3 },
        { range = 400, damage = 0.2 },
        { range = 450, damage = 0.1 },
        { range = 500, damage = 0 },
    },

    [ "9x19mm" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.9 },
        { range = 50, damage = 0.8 },
        { range = 75, damage = 0.7 },
        { range = 100, damage = 0.55 },
        { range = 125, damage = 0.4 },
        { range = 150, damage = 0.25 },
        { range = 175, damage = 0.1 },
        { range = 200, damage = 0 }
    },

    [ "12 Gauge" ] = {
        { range = 0, damage = 1 },
        { range = 10, damage = 1 },
        { range = 12, damage = 0.9 },
        { range = 25, damage = 0.75 },
        { range = 32, damage = 0.65 },
        { range = 50, damage = 0.5 },
        { range = 62, damage = 0.3 },
        { range = 75, damage = 0 }
    },

    [ "12 Gauge Penny Shot" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 15, damage = 0.75 },
        { range = 20, damage = 0.7 },
        { range = 25, damage = 0.6 },
        { range = 30, damage = 0.5 },
        { range = 50, damage = 0.35 },
        { range = 75, damage = 0.2 },
        { range = 100, damage = 0.05 },
        { range = 125, damage = 0 }
    },

    [ ".45 ACP" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.95 },
        { range = 50, damage = 0.85 },
        { range = 75, damage = 0.7 },
        { range = 100, damage = 0.55 },
        { range = 125, damage = 0.4 },
        { range = 150, damage = 0.2 },
        { range = 175, damage = 0 }
    },

    [ "4.6x30mm" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.95 },
        { range = 50, damage = 0.9 },
        { range = 75, damage = 0.85 },
        { range = 100, damage = 0.8 },
        { range = 125, damage = 0.75 },
        { range = 150, damage = 0.65 },
        { range = 175, damage = 0.5 },
        { range = 200, damage = 0.35 },
        { range = 225, damage = 0.2 },
        { range = 250, damage = 0.05 },
        { range = 275, damage = 0 }
    },

    [ ".357 Magnum" ] = {
        { range = 0, damage = 1 },
        { range = 20, damage = 1 },
        { range = 25, damage = 0.95 },
        { range = 50, damage = 0.85 },
        { range = 75, damage = 0.75 },
        { range = 100, damage = 0.6 },
        { range = 125, damage = 0.45 },
        { range = 150, damage = 0.30 },
        { range = 175, damage = 0.15 },
        { range = 200, damage = 0 }
    }
}

if RANGE_BUFF then
    for k,v in pairs( ST_RANGE_GRAPHS ) do
        for a,b in pairs( v ) do
            if not string.find( a, "12 Gauge" ) then
                b.range = b.range * RANGE_BUFF
            end
        end
    end
end

ST_SPECIAL_RANGE_GRAPHS = {}
for k,v in pairs( ST_RANGE_GRAPHS ) do
    ST_SPECIAL_RANGE_GRAPHS[ k .. " FMJ" ] = FMJify( v )
    ST_SPECIAL_RANGE_GRAPHS[ k .. " Vintage" ] = Antiquify( v )
    ST_SPECIAL_RANGE_GRAPHS[ k .. " Explosive" ] = Explosify( v )
    ST_SPECIAL_RANGE_GRAPHS[ k .. " Poison" ] = Poisonify( v )
    ST_SPECIAL_RANGE_GRAPHS[ k .. " Dragon's Breath" ] = Dragonify( v )
    ST_SPECIAL_RANGE_GRAPHS[ k .. " Flechettes" ] = Flechettify( v )
end

for k,v in pairs( ST_SPECIAL_RANGE_GRAPHS ) do
    ST_RANGE_GRAPHS[ k ] = v
end