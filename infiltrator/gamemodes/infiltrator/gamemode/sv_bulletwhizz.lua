util.AddNetworkString( "stcrack" )

hook.Add( "PostEntityFireBullets", "TestCracks", function( ply, data )
    local tr = data.Trace
    net.Start( "stcrack" )
        net.WriteVector( tr.StartPos )
        net.WriteVector( tr.HitPos )
        net.WritePlayer( ply )
    net.Broadcast()
end )