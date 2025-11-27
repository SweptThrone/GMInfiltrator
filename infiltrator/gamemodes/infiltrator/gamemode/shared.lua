GM.Name = "Infiltrator"
GM.Author = "SweptThrone"
GM.Email = "im@sweptthr.one"
GM.Website = "sweptthr.one"

TEAM_INFIL = 1
TEAM_GUARD = 2

function GM:Initialize()
    team.SetUp( TEAM_INFIL, "Infiltrators", Color( 255, 0, 0 ) )
	team.SetUp( TEAM_GUARD, "Guards", Color( 0, 0, 255 ) )
end

local function FixPropRenders()
	for k,v in pairs( ents.FindByClass( "prop_*" ) ) do
		v:SetRenderMode( 0 )
	end
end

function GM:InitPostEntity()
    FixPropRenders()
    if SERVER then game.GetWorld():SetNWEntity( "RocketHatch", ents.GetMapCreatedEntity( 1854 ) ) end
end

function GM:PostCleanupMap()
    FixPropRenders()
    if SERVER then game.GetWorld():SetNWEntity( "RocketHatch", ents.GetMapCreatedEntity( 1854 ) ) end
end

ROUND = {
    NOPLAYERS = 0,
    PREPARING = 1,
    ACTIVE = 2,
    ENDING = 3
}

ROUND_STRINGS = {
    [ 0 ] = "Waiting for players",
    [ 1 ] = "Preparing",
    [ 2 ] = "Round active",
    [ 3 ] = "Round ending"
}

CreateConVar( "sv_infil_preptime_sec", "30", bit.bor( FCVAR_ARCHIVE, FCVAR_REPLICATED ), "Length of prep time, in seconds.  During this time, players will be choosing their loadouts.", 0, 86400 )
CreateConVar( "sv_infil_roundtime_sec", "1200", bit.bor( FCVAR_ARCHIVE, FCVAR_REPLICATED ), "Length of one round, in seconds.", 0, 86400 )
CreateConVar( "sv_infil_posttime_sec", "30", bit.bor( FCVAR_ARCHIVE, FCVAR_REPLICATED ), "Length of post-round time, in seconds.", 0, 86400 )

function GetRoundState()
    return game.GetWorld():GetNWInt( "RoundState", 0 )
end
function SetRoundState( state )
    game.GetWorld():SetNWInt( "RoundState", state )
end
function GetStateTime()
    return game.GetWorld():GetNWInt( "StateTime", 0 )
end
function SetStateTime( time )
    game.GetWorld():SetNWInt( "StateTime", time )
end
function NextState()
    if player.GetCount() < 2 then
        SetRoundState( ROUND.NOPLAYERS )
        return
    end

    if GetRoundState() == ROUND.PREPARING then
        SetRoundState( ROUND.ACTIVE )
        SetStateTime( CurTime() + GetConVar( "sv_infil_roundtime_sec" ):GetInt() )
    elseif GetRoundState() == ROUND.ACTIVE then
        SetRoundState( ROUND.ENDING )
        SetStateTime( CurTime() + GetConVar( "sv_infil_posttime_sec" ):GetInt() )
    elseif GetRoundState() == ROUND.ENDING or GetRoundState() == ROUND.NOPLAYERS then
        SetRoundState( ROUND.PREPARING )
        SetStateTime( CurTime() + GetConVar( "sv_infil_preptime_sec" ):GetInt() )
    end
end

INFILTRATOR = {
    Primaries = {
        -- guard assault
        "m4a1_nosup",
        "famas",
        "galil",
        -- guard officer
        "mp5",
        "ump45",
        "p90",
        "glock_auto",
        -- guard marksman
        "aug",
        "scout",
        "sg550",
        "awp",
        -- guard heavy
        "m3",
        "xm1014",
        "m249",
        -- infiltrator
        "ak47",
        "tmp",
        "scouts",
    },
    Secondaries = {
        "fiveseven",
        "p228",
        "deagle",
        "usp"
    },
    Perks = {
        NONE = 0,
        THERMAL = 1,
        SECURITY = 2,
        CAMO = 4,
        ARMOR = 8,
        AMMO = 16,
        SLAMS = 32,
        STAMINA = 64
    },
	Classes = {
		"guard_assault",
		"guard_medic",
		"guard_officer",
		"guard_marksman",
		"guard_heavy",
        "infil_infil",
		Weapons = {
			{ min = 1, max = 3 },
			{ min = 0, max = 0 },
			{ min = 4, max = 7 },
			{ min = 8, max = 11 },
			{ min = 12, max = 14 },
            { min = 15, max = 17 }
		}
	},
    Infiltrations = {
        "Upper Path",
        "Zethes Checkpoint",
        "Ridge Tunnel"
    }
}

local plyMeta = FindMetaTable( "Player" )
function plyMeta:SetDR( dr )
    self:SetNWFloat( "DamageResist", dr )
end
function plyMeta:GetDR()
    return self:GetNWFloat( "DamageResist", 0 )
end