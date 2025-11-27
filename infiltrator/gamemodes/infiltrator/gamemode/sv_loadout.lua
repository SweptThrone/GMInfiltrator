-- this file is not empty
util.AddNetworkString( "Infil.Loadout" )

hook.Add( "PlayerInitialSpawn", "Infil.LoadoutInitialSpawn", function( ply )
    ply.InfilLoadout = {
        [ TEAM_INFIL ] = {
            INFILTRATOR.Classes.Weapons[ 6 ].min, 4, 1, 1 // primary, secondary, perk, spawn
        },
        [ TEAM_GUARD ] = {
            1, 1, 1 // class, primary, secondary
        }
    }
end )

hook.Add( "ShowSpare1", "Infil.LoadoutMenu", function( ply )
    if ply:Team() == TEAM_SPECTATOR and GetRoundState() ~= ROUND.PREPARING then return end

    net.Start( "Infil.Loadout" )
        net.WriteBool( ply == NextRoundInfil )
    net.Send( ply )
end )

net.Receive( "Infil.Loadout", function( _, ply )
    if table.HasValue( NextRoundGuards, ply ) then
        local plyClass = net.ReadUInt( 3 )
        local prim = net.ReadUInt( 5 )
        local sec = net.ReadUInt( 3 )

        if plyClass < 1 or plyClass > 5 then
            plyClass = 1
        end
        ply.InfilLoadout[ TEAM_GUARD ][ 1 ] = plyClass
        if prim < INFILTRATOR.Classes.Weapons[ plyClass ].min or prim > INFILTRATOR.Classes.Weapons[ plyClass ].max then
            prim = INFILTRATOR.Classes.Weapons[ plyClass ].min
        end
        ply.InfilLoadout[ TEAM_GUARD ][ 2 ] = prim
        if sec < 1 or sec > 3 then
            sec = 1
        end
        ply.InfilLoadout[ TEAM_GUARD ][ 3 ] = sec
    elseif ply == NextRoundInfil then
        local prim = net.ReadUInt( 5 )
        local sec = net.ReadUInt( 3 )
        local perk = net.ReadUInt( 32 )
        local location = net.ReadUInt( 3 )

        if prim < INFILTRATOR.Classes.Weapons[ 6 ].min or prim > INFILTRATOR.Classes.Weapons[ 6 ].max then
            prim = INFILTRATOR.Classes.Weapons[ 6 ].min
        end
        ply.InfilLoadout[ TEAM_INFIL ][ 1 ] = prim
        if sec < 1 or sec > 4 then
            sec = 4
        end
        ply.InfilLoadout[ TEAM_INFIL ][ 2 ] = sec
        if perk == 0 then
            perk = 1
        end
        ply.InfilLoadout[ TEAM_INFIL ][ 3 ] = perk
        if location == 0 then
            locaion = 1
        end
        ply.InfilLoadout[ TEAM_INFIL ][ 4 ] = location
    end
end )

hook.Add( "PlayerFootstep", "Infil.HeavyFootsteps", function( ply )
    if player_manager.GetPlayerClass( ply ) == "guard_heavy" then
        ply:EmitSound( "npc/combine_soldier/gear" .. math.random( 1, 6 ) .. ".wav" )
    end
end )