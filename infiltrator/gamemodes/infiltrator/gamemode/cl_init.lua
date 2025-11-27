include( "shared.lua" )
include( "sh_boreas_freeze.lua" )
include( "sh_boreascameras.lua" )
include( "sh_limbdamage.lua" )
include( "sh_range_graphs.lua" )
include( "sh_tfalimbshoteffects.lua" )
include( "sh_infilmsg.lua" )
include( "sh_infiltut.lua" )
include( "sh_infilprefs.lua" )
include( "cl_aimvignette.lua" )
include( "cl_boreasfreeze.lua" )
include( "cl_bulletwhizz.lua" )
include( "cl_infilhud.lua" )
include( "cl_loadout.lua" )
include( "cl_infilvision.lua" )
include( "cl_teamkrilla.lua" )
include( "player_class/guard_assault.lua" )
include( "player_class/guard_heavy.lua" )
include( "player_class/guard_marksman.lua" )
include( "player_class/guard_medic.lua" )
include( "player_class/guard_officer.lua" )
include( "player_class/infil_infil.lua" )

CreateClientConVar( "cl_playercolor", "0.24 0.34 0.41", true, true )

function GM:PrePlayerDraw( ply )
    if ply:Team() == TEAM_SPECTATOR then
        ply:DrawShadow( false )
        return true
    end
end

function GM:ChatText( index, name, text, type )
	if ( type == "joinleave" or type == "teamchange" ) then
		return true
	end
end

function GM:HUDDrawTargetID()
	return false
end

hook.Add( "CalcViewModelView", "FixDeathViewmodels", function( wep )
    if IsValid( wep:GetOwner() ) and not wep:GetOwner():Alive() then
        return Vector( 0, 0, -10000 ), Angle( 0, 0, 0 )
    end
end )

function GM:PreDrawPlayerHands( hands, vm, ply, weapon )
    if IsValid( ply ) and not ply:Alive() then
        return true
    end
end

function GM:PlayerStartVoice( ply, i )
    local me = LocalPlayer()

    if me:Team() == TEAM_SPECTATOR then return false end
    if GetRoundState() == ROUND.PREPARING or GetRoundState() == ROUND.ENDING then return false end
    return true
end

hook.Add( "InitPostEntity", "Infil.RequestLoadout", function()
    if GetRoundState() == ROUND.PREPARING then
        net.Start( "Infil.AskForLoadout" )
        net.SendToServer()
    end
end )