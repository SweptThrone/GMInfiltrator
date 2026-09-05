include( "shared.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "sh_boreas_freeze.lua" )
include( "sh_boreascameras.lua" )
include( "sh_limbdamage.lua" )
include( "sh_range_graphs.lua" )
include( "sh_tfalimbshoteffects.lua" )
include( "sh_infilmsg.lua" )
include( "sh_infiltut.lua" )
include( "sh_infilprefs.lua" )
include( "sv_bulletwhizz.lua" )
include( "sv_damageresistance.lua" )
include( "sv_dropweaponondeath.lua" )
include( "sv_loadout.lua" )
include( "sv_objectives.lua" )
include( "sv_teamkrilla.lua" )
include( "sv_infilworkshop.lua" )
AddCSLuaFile( "sh_boreas_freeze.lua" )
AddCSLuaFile( "sh_boreascameras.lua" )
AddCSLuaFile( "sh_limbdamage.lua" )
AddCSLuaFile( "sh_range_graphs.lua" )
AddCSLuaFile( "sh_tfalimbshoteffects.lua" )
AddCSLuaFile( "sh_infilmsg.lua" )
AddCSLuaFile( "sh_infiltut.lua" )
AddCSLuaFile( "sh_infilprefs.lua" )
AddCSLuaFile( "cl_aimvignette.lua" )
AddCSLuaFile( "cl_boreasfreeze.lua" )
AddCSLuaFile( "cl_bulletwhizz.lua" )
AddCSLuaFile( "cl_infilhud.lua" )
AddCSLuaFile( "cl_loadout.lua" )
AddCSLuaFile( "cl_infilvision.lua" )
AddCSLuaFile( "cl_teamkrilla.lua" )

include( "player_class/guard_assault.lua" )
include( "player_class/guard_heavy.lua" )
include( "player_class/guard_marksman.lua" )
include( "player_class/guard_medic.lua" )
include( "player_class/guard_officer.lua" )
include( "player_class/infil_infil.lua" )
AddCSLuaFile( "player_class/guard_assault.lua" )
AddCSLuaFile( "player_class/guard_heavy.lua" )
AddCSLuaFile( "player_class/guard_marksman.lua" )
AddCSLuaFile( "player_class/guard_medic.lua" )
AddCSLuaFile( "player_class/guard_officer.lua" )
AddCSLuaFile( "player_class/infil_infil.lua" )

infilPrint( "Initializing..." )

util.AddNetworkString( "Infil.Music" )

LAST_INFILTRATOR = NULL

local function PosAng( str )
	local posStr = str:sub( 8, str:find( ";" ) )
	local angStr = str:sub( str:find( "setang" ) + 7 )

	return { pos = Vector( posStr ) - Vector( 0, 0, 64 ), ang = Angle( angStr ) }
end

GUARD_SPAWNS = {
	PosAng( "setpos 216.259323 2595.334473 -6335.968750;setang 4.168088 -88.987083 0.000000" ),
	PosAng( "setpos 222.271118 2261.762451 -6335.968750;setang 2.760077 90.788925 0.000000" ),
	PosAng( "setpos 313.568024 2557.687256 -6335.968750;setang 2.056059 -91.546921 0.000000" ),
	PosAng( "setpos 300.570435 2261.679688 -6335.968750;setang 1.000055 88.581146 0.000000" ),
	PosAng( "setpos 459.367493 2560.133301 -6335.968750;setang 2.408062 -89.531021 0.000000" ),
	PosAng( "setpos 461.815094 2241.763672 -6335.968750;setang 2.056029 91.748795 0.000000" ),
	PosAng( "setpos 539.072449 2545.740234 -6335.968750;setang 2.408046 -90.587143 0.000000" ),
	PosAng( "setpos 667.153503 2588.254639 -6335.968750;setang 3.816002 -76.250946 0.000000" ),
	PosAng( "setpos 700.631592 2234.931641 -6335.968750;setang 1.351984 89.093048 0.000000" ),
	PosAng( "setpos 781.275696 2564.007080 -6335.968750;setang 2.407967 -90.427063 0.000000" ),
	PosAng( "setpos 794.990845 2252.538574 -6335.968750;setang 2.056015 94.629044 0.000000" ),
	PosAng( "setpos 941.324768 2559.125732 -6335.968750;setang 0.296014 -90.522865 0.000000" ),
	PosAng( "setpos 945.227051 2224.501953 -6335.968750;setang 1.704016 91.461075 0.000000" )
}

MEDBAY_SPAWNS = {
	[ 0 ] = PosAng( "setpos 302.154572 2057.878906 -6335.962891;setang 2.408074 -89.722710 0.000000" ),
	[ 1 ] = PosAng( "setpos 399.255371 2052.505615 -6335.962891;setang 2.760134 -90.778763 0.000000" ),
	[ 2 ] = PosAng( "setpos 498.392853 2055.608643 -6335.962891;setang 5.224134 -148.506958 0.000000" ),
	[ 3 ] = PosAng( "setpos 478.660126 1904.684692 -6335.968750;setang 3.112121 179.461227 0.000000" ),
	[ 4 ] = PosAng( "setpos 477.626892 1823.611450 -6335.968750;setang 3.464190 150.597031 0.000000" ),
	[ 5 ] = PosAng( "setpos 484.651154 1749.031250 -6335.968750;setang 3.112217 179.109207 0.000000" ),
	[ 6 ] = PosAng( "setpos 448.808197 1664.581299 -6335.968750;setang 5.928284 133.349060 0.000000" )
}
CurrentMedbaySpawn = 0

INFILTRATOR_SPAWNS = {
	PosAng( "setpos -14759.146484 -14871.685547 -8128.762695;setang 0.032297 57.538120 0.000000" ),
	PosAng( "setpos -8828.904297 -14866.281250 -10426.716797;setang -1.375680 93.089920 0.000000" ),
	PosAng( "setpos 13250.408203 15304.802734 544.031250;setang -1.375701 -135.006134 0.000000" )
}

util.AddNetworkString( "Infil.AskForLoadout" ) -- :/
net.Receive( "Infil.AskForLoadout", function( len, ply )
	if GetRoundState() == ROUND.PREPARING and ply ~= NextRoundInfil then
		net.Start( "Infil.Loadout" )
			net.WriteBool( false )
        	net.WriteBool( true )
		net.Send( ply )
		NextRoundGuards[ ply ] = true
	end
end )

util.AddNetworkString( "Infil.ReSpectate" )
net.Receive( "Infil.ReSpectate", function( len, ply )
	if GetRoundState() == ROUND.PREPARING and NextRoundGuards[ ply ] then
		NextRoundGuards[ ply ] = nil
	end
	if ply == NextRoundInfil then
		NextRoundInfil = NULL

		local getInstantaneousPlayersWhoCanPlay = GetPlayersWhoCanPlay()
		for k, pl in pairs( getInstantaneousPlayersWhoCanPlay ) do
			if pl == ply then
				getInstantaneousPlayersWhoCanPlay[ k ] = nil
			end
		end

		if #getInstantaneousPlayersWhoCanPlay > 1 then
			InfilMsg( "The infiltrator started spectating, re-rolling..." )
			SetStateTime( CurTime() + GetConVar( "sv_infil_preptime_sec" ):GetInt() )		
			nextRoundTimeCached = GetStateTime()

			RollTeams()
		else
			InfilMsg( "The infiltrator started spectating.  There are not enough eligible players." )
        	SetRoundState( ROUND.NOPLAYERS )
		end

	end
end )

function GM:PlayerSpawnAsSpectator( ply )
	ply:StripWeapons()

	if ( ply:Team() == TEAM_UNASSIGNED ) then
		ply:Spectate( OBS_MODE_FIXED )
		return
	end

	ply:SetTeam( TEAM_SPECTATOR )
	ply:Spectate( OBS_MODE_ROAMING )

	ply:SetNoDraw( true )
	ply:SetMoveType( MOVETYPE_NOCLIP )
end

function GM:PlayerInitialSpawn( ply )
	local col = ply:GetInfo( "cl_playercolor" )
	ply:SetPlayerColor( Vector( col ) )
	ply:SetNWVector( "TruePlayerColor", Vector( col ) )
	GAMEMODE:PlayerSpawnAsSpectator( ply )
end

function GM:PlayerJoinTeam( ply, t )
	ply:SetTeam( t )
	self:OnPlayerChangedTeam( ply, ply:Team(), t )
end

hook.Add( "CanPlayerSuicide", "AllowOwnerSuicide", function( ply )
	return false
end )

hook.Add( "PlayerUse", "SpecsCantUse", function( ply )
	if ply:Team() == TEAM_SPECTATOR then
		return false
	end
end )

local nextRoundTimeCached = 0

NextRoundGuards = {}
NextRoundInfil = NULL

local hasSentLoadout = false

function GetPlayersSortedByTime()
	local plys = player.GetAll()
	local sortedPlys = {}
	for _, ply in pairs( plys ) do
		sortedPlys[ ply ] = ply:TimeConnected()
	end
	table.sort( sortedPlys, function( a, b ) return a > b end )
	return sortedPlys
end

function GetPlayersWhoCanPlay()
	local plys = {}
	local sortedPlys = GetPlayersSortedByTime()
	local i = 1
	for ply, time in pairs( sortedPlys ) do
		if ply:GetInfoNum( "cl_infil_spectateonly", 0 ) == 0 and i <= #GUARD_SPAWNS then
			table.insert( plys, ply )
			i = i + 1
		end
	end
	return plys
end

function GetPlayersInQueue()
	local plys = {}
	local sortedPlys = GetPlayersWhoCanPlay()
	local i = 1
	for _, ply in pairs( sortedPlys ) do
		if ply:GetInfoNum( "cl_infil_spectateonly", 0 ) == 0 and i > #GUARD_SPAWNS then
			table.insert( plys, ply )
		end
		i = i + 1
	end
	return plys
end

function RollTeams()
	-- all players who are not spectate-only
	local valid_infiltrators = {}
	for _, ply in pairs( GetPlayersWhoCanPlay() ) do
		valid_infiltrators[ ply ] = true
	end
	-- prevent last round's infiltrator from being it again
	if IsValid( LAST_INFILTRATOR ) then
		valid_infiltrators[ LAST_INFILTRATOR ] = nil
	end
	-- remove all players who do not want to be the infiltrator
	for ply, _ in pairs( valid_infiltrators ) do
		if ply:GetInfoNum( "cl_infil_avoidinfil", 0 ) == 1 then
			valid_infiltrators[ ply ] = nil
		end
	end

	-- if no one wants to be infiltrator except the previous infiltrator, let them be it again
	if table.IsEmpty( valid_infiltrators ) and IsValid( LAST_INFILTRATOR ) and LAST_INFILTRATOR:GetInfoNum( "cl_infil_avoidinfil", 0 ) ~= 1 then
		valid_infiltrators[ LAST_INFILTRATOR ] = true
	end

	-- if absolutely no one wants to be infiltrator, we have to just pick from everyone
	if table.IsEmpty( valid_infiltrators ) then
		for _, ply in pairs( GetPlayersWhoCanPlay() ) do
			valid_infiltrators[ ply ] = true
		end
	end

	_, NextRoundInfil = table.Random( valid_infiltrators )
	NextRoundInfil:InfilMsg( "You are the infiltrator!" )
	LAST_INFILTRATOR = NextRoundInfil
	infilPrint( "Next round infil @ 154", NextRoundInfil )

	NextRoundGuards = {}
	for k,v in pairs( GetPlayersWhoCanPlay() ) do
		if v ~= NextRoundInfil then
			NextRoundGuards[ v ] = true
			v:InfilMsg( "You are a guard." )
		end
	end

	for k,v in pairs( GetPlayersInQueue() ) do
		v:InfilMsg( "You are number " .. k .. " in queue." )
	end

	net.Start( "Infil.Loadout" )
		net.WriteBool( true )
        net.WriteBool( true )
	net.Send( NextRoundInfil )
	
	local guardsRF = RecipientFilter()
	for ply, b in pairs( NextRoundGuards ) do
		if b then
			guardsRF:AddPlayer( ply )
		end
	end

	net.Start( "Infil.Loadout" )
		net.WriteBool( false )
        net.WriteBool( true )
	net.Send( guardsRF )
end

hook.Add( "PlayerDisconnected", "CheckForInfilLeaving", function( ply )
	if ply == NextRoundInfil and GetRoundState() == ROUND.PREPARING then
		NextRoundInfil = NULL

		if #GetPlayersWhoCanPlay() > 1 then
			InfilMsg( "The infiltrator left the server, re-rolling..." )
			SetStateTime( CurTime() + GetConVar( "sv_infil_preptime_sec" ):GetInt() )		
			nextRoundTimeCached = GetStateTime()

			RollTeams()
		else
			InfilMsg( "The infiltrator left the server.  There are not enough eligible players." )
        	SetRoundState( ROUND.NOPLAYERS )
		end
	end

	if ply:Team() == TEAM_INFIL and GetRoundState() == ROUND.ACTIVE then
		InfilMsg( "The infiltrator left the server." )
		net.Start( "Infil.Music" )
			net.WriteBool( true )
		net.Broadcast()
		NextState()
		nextRoundTimeCached = GetStateTime()
	end

	if ply:Team() == TEAM_GUARD and #team.GetPlayers( TEAM_GUARD ) == 1 then
		InfilMsg( "All guards have left the server." )
		net.Start( "Infil.Music" )
			net.WriteBool( false )
		net.Broadcast()
		NextState()
		nextRoundTimeCached = GetStateTime()
	end
end )

function GM:PlayerDeath( vic )
	vic.NextSpawnTime = CurTime() + 30
	if vic:Team() == TEAM_GUARD then
		vic.NextSpawnTime = CurTime() + math.max( 30, team.NumPlayers( TEAM_GUARD ) * 10 )
	end

	vic:SetNWInt( "Freezing", 0 )
	vic:SetNWBool( "HasJammer", false )
	vic:SetNWBool( "IsDisguised", false )

	if vic:Team() == TEAM_INFIL then
		InfilMsg( "The infiltrator has been killed!" )
		net.Start( "Infil.Music" )
			net.WriteBool( true )
		net.Broadcast()
		NextState()
		nextRoundTimeCached = GetStateTime()
		vic.Active = false
	end
end

G_MUTE = false

function GM:Think()
	if nextRoundTimeCached == 0 then
		nextRoundTimeCached = GetStateTime()
	end

	if GetRoundState() == ROUND.NOPLAYERS then
		if #GetPlayersWhoCanPlay() > 1 and not hasSentLoadout then
			infilPrint( "Proceeding to next due to no players..." )
			hasSentLoadout = true
			NextState()
			nextRoundTimeCached = GetStateTime()

			for k,v in pairs( player.GetAll() ) do
				v:StripWeapons()
				v:RemoveAllAmmo()
				v.Active = false
				GAMEMODE:PlayerSpawnAsSpectator( v )
				v:Spawn()
				if v:GetInfoNum( "cl_infil_spectateonly", 0 ) == 1 then
					v:InfilMsg( "You are set to spectate only.  Hit F2 to change this." )
				elseif v:GetInfoNum( "cl_infil_avoidinfil", 0 ) == 1 then
					v:InfilMsg( "You are set to never be the infiltrator.  Hit F2 to change this." )
				end
			end

			game.CleanUpMap()

			RollTeams()
		end
	elseif CurTime() >= nextRoundTimeCached then
		hasSentLoadout = false
		infilPrint( "Proceeding to next due to time expiring..." )
		NextState()
		nextRoundTimeCached = GetStateTime()

		if GetRoundState() == ROUND.PREPARING then
			for k,v in pairs( player.GetAll() ) do
				v:StripWeapons()
				v:RemoveAllAmmo()
				v.Active = false
				GAMEMODE:PlayerSpawnAsSpectator( v )
				v:Spawn()
			end

			infilPrint( "We are now preparing..." )
			game.CleanUpMap()

			RollTeams()
		elseif GetRoundState() == ROUND.ACTIVE then
			G_MUTE = true
			timer.Simple( 1, function()
				G_MUTE = false
			end )

			infilPrint( "Game is now active" )

			local i = 1
			for ply, b in pairs( NextRoundGuards ) do
				if IsValid( ply ) and b then
					ply.Active = true
					player_manager.SetPlayerClass( ply, INFILTRATOR.Classes[ ply.InfilLoadout[ TEAM_GUARD ][ 1 ] ] )
					ply:Spawn()
					ply:UnSpectate()
					ply:SetObserverMode( OBS_MODE_NONE )
					ply:SetNoDraw( false )
					ply:SetMoveType( MOVETYPE_WALK )
					GAMEMODE:PlayerJoinTeam( ply, TEAM_GUARD )
					ply:SetPos( GUARD_SPAWNS[ i ].pos )
					ply:SetAngles( GUARD_SPAWNS[ i ].ang )
					i = i + 1
				end
			end
			NextRoundInfil.Active = true
			infilPrint( "Next round infil @ 262", NextRoundInfil )
			player_manager.SetPlayerClass( NextRoundInfil, "infil_infil" )
			NextRoundInfil:Spawn()
			NextRoundInfil:UnSpectate()
			NextRoundInfil:SetObserverMode( OBS_MODE_NONE )
			NextRoundInfil:SetNoDraw( false )
			NextRoundInfil:SetMoveType( MOVETYPE_WALK )
			GAMEMODE:PlayerJoinTeam( NextRoundInfil, TEAM_INFIL )
			NextRoundInfil:SetPos( INFILTRATOR_SPAWNS[ NextRoundInfil.InfilLoadout[ TEAM_INFIL ][ 4 ] ].pos )
			NextRoundInfil:SetAngles( INFILTRATOR_SPAWNS[ NextRoundInfil.InfilLoadout[ TEAM_INFIL ][ 4 ] ].ang )
			NextRoundInfil:InfilMsg( "Hold your Suit Zoom key to use Infil-Vision." )
		elseif GetRoundState() == ROUND.ENDING then
			InfilMsg( "The infiltrator has failed their mission!" )
			net.Start( "Infil.Music" )
				net.WriteBool( true )
			net.Broadcast()
		end
	end
end

function GM:PlayerSpawn( ply )
	ply:SetNWInt( "Freezing", 0 )
	
	if not ply.Active then
		GAMEMODE:PlayerSpawnAsSpectator( ply )
	else
        ply:DrawShadow( true )

		if ply:Team() == TEAM_GUARD then
			ply:SetPos( MEDBAY_SPAWNS[ CurrentMedbaySpawn ].pos )
			ply:SetAngles( MEDBAY_SPAWNS[ CurrentMedbaySpawn ].ang )
			CurrentMedbaySpawn = ( CurrentMedbaySpawn + 1 ) % 7
		end

		ply.ThermalInlay = false

		player_manager.RunClass( ply, "Spawn" )
		player_manager.RunClass( ply, "Loadout" )
		player_manager.RunClass( ply, "SetModel" )

		ply:SetupHands()
	end
end

function GM:PlayerSwitchFlashlight( ply )
	return ply:Team() ~= TEAM_SPECTATOR
end

hook.Add( "PlayerDeathThink", "Infil.RespawnTimer", function( ply )
	if CurTime() < ply.NextSpawnTime then return true end
end )

local plyMeta = FindMetaTable( "Player" )
function plyMeta:Exfiltrate()
	NextState()
	nextRoundTimeCached = GetStateTime()
	InfilMsg( "The infiltrator has completed the mission!" )
	net.Start( "Infil.Music" )
		net.WriteBool( false )
	net.Broadcast()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetNWBool( "CamoEnabled", false )
	GAMEMODE:PlayerSpawnAsSpectator( self )
end