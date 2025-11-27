hook.Add( "SetupMove", "LegHitSlowdown", function( ply, mov, cmd )
    if CurTime() <= ply:GetNWFloat( "LegHit", 0 ) then
        local wSpeed = ply:GetWalkSpeed() - ( ply:GetNWFloat( "LegHit", 0 ) - CurTime() ) * ply:GetWalkSpeed()
        mov:SetMaxClientSpeed( wSpeed )
        mov:SetMaxSpeed( wSpeed )
    end
end )

hook.Add( "ScalePlayerDamage", "HitLegsToSlowdown", function( ply, grp, dmg )
    if dmg:GetAttacker():IsPlayer() and bit.band( dmg:GetDamageType(), DMG_BULLET ) == DMG_BULLET and ( grp == HITGROUP_RIGHTLEG or grp == HITGROUP_LEFTLEG ) then
        ply:SetNWFloat( "LegHit", CurTime() + math.min( ( ( ply:GetNWFloat( "LegHit", 0 ) - CurTime() ) + dmg:GetDamage() ) / 100, 1 ) )
    end
    if dmg:GetAttacker():IsPlayer() and bit.band( dmg:GetDamageType(), DMG_BULLET ) == DMG_BULLET and ( grp == HITGROUP_RIGHTARM or grp == HITGROUP_LEFTARM ) then
        ply:SetNWFloat( "ArmHit", CurTime() + math.min( ( ( ply:GetNWFloat( "ArmHit", 0 ) - CurTime() ) + dmg:GetDamage() ) / 100, 1 ) )
    end
    if dmg:GetAttacker():IsPlayer() and bit.band( dmg:GetDamageType(), DMG_BULLET ) == DMG_BULLET and grp == HITGROUP_HEAD and SERVER then
        ply:ScreenFade( SCREENFADE.IN, color_black, 2, 0.5 )
        ply:SetDSP( 33 )
    end
end )

hook.Add( "TFA_GetStat", "ArmHitInacc", function( wep, stat, value )
    if IsValid( wep:GetOwner() ) and CurTime() <= wep:GetOwner():GetNWFloat( "ArmHit", 0 ) and ( stat == "Primary.IronAccuracy" or stat == "Primary.Spread" or stat == "Primary.KickUp" or stat == "Primary.KickDown" or stat == "Primary.KickHorizontal" ) then
        local newAcc = 1 + ( wep:GetOwner():GetNWFloat( "ArmHit", 0 ) - CurTime() )
        return value * newAcc
    end
end )