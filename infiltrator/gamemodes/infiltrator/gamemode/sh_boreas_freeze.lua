if SERVER then util.AddNetworkString( "FreezeSound" ) end

if SERVER then require( "getsoundscapefn" ) end

hook.Add( "PlayerTick", "PrintActiveSS", function( ply )

    ply.NextFreezeCheck = ply.NextFreezeCheck or 0

    if SERVER and game.GetMap() == "gm_boreas" and ply:Alive() and not ply:IsBot() and ply:Team() ~= TEAM_SPECTATOR and not ply.ThermalInlay and CurTime() >= ply.NextFreezeCheck then
        if not IsValid( ply:GetSoundscapeEntity() ) then return end

        if string.find( ply:GetSoundscapeEntity():GetSaveTable().m_soundscapeName, "exterior" ) then
            --print( "COLD" )
            ply:SetNWInt( "Freezing", math.Clamp( ply:GetNWInt( "Freezing", 0 ) + 5, 0, 255 ) )
            ply.NextFreezeCheck = CurTime() + 6
        else
            --print( "WARM" )
            ply:SetNWInt( "Freezing", math.Clamp( ply:GetNWInt( "Freezing", 0 ) - 5, 0, 255 ) )
            ply.NextFreezeCheck = CurTime() + 1
        end

        if ply:GetNWInt( "Freezing", 0 ) == 255 then
            local dmg = DamageInfo()
            dmg:SetDamageType( DMG_SHOCK )
            dmg:SetDamage( 2.5 )
            dmg:SetAttacker( ply )
            dmg:SetInflictor( ply )
            dmg:SetDamageForce( Vector( 0, 0, 1 ) )
            dmg:SetDamagePosition( ply:LocalToWorld( ply:OBBCenter() ) )
            ply:TakeDamageInfo( dmg )
            net.Start( "FreezeSound" )
            net.Send( ply )
        end
    end
end )

net.Receive( "FreezeSound", function()
    surface.PlaySound( "freeze_raw.wav" )
end )