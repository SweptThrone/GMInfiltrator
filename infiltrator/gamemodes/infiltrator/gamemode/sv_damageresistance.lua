hook.Add( "ScalePlayerDamage", "ApplyDR", function( ply, hg, dmg )
    if hg ~= HITGROUP_HEAD and dmg:IsDamageType( DMG_BULLET ) then
        dmg:ScaleDamage( 1 - ply:GetDR() )
    end
end )