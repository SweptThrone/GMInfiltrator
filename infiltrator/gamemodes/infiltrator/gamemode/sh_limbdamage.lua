local shotgunDamage = {
    [ HITGROUP_HEAD ] = 1.15 / 2,
    [ HITGROUP_CHEST ] = 1,
    [ HITGROUP_STOMACH ] = 0.75,
    [ HITGROUP_LEFTARM ] = 4 * 0.6,
    [ HITGROUP_RIGHTARM ] = 4 * 0.6,
    [ HITGROUP_LEFTLEG ] = 4 * 0.4,
    [ HITGROUP_RIGHTLEG ] = 4 * 0.4
}

local hgLut = {
    "Head",
    "Chest",
    "Abdomen",
    "Left Arm",
    "Right Arm",
    "Left Leg",
    "Right Leg"
}

hook.Add( "ScalePlayerDamage", "IncreaseLimbDamage", function( ply, hitgroup, dmg )
    if dmg:GetInflictor():IsWeapon() and ( dmg:GetInflictor():GetPrimaryAmmoType() == 7 or dmg:GetInflictor():GetPrimaryAmmoType() == 15 ) then
        dmg:ScaleDamage( shotgunDamage[ hitgroup ] )
        --if SERVER then print( dmg:GetDamage() .. "damage at the " .. hgLut[ hitgroup ] .. " " .. shotgunDamage[ hitgroup ] .. "x" ) end
    else
        if hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
            dmg:ScaleDamage( 4 * ( 0.9 / 1.3 ) ) -- scale the default 0.25x up to 1x, then scale it based on Hunt values
        end
        if hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
            dmg:ScaleDamage( 4 * ( 0.8 / 1.3 ) ) -- scale the default 0.25x up to 1x, then scale it based on Hunt values
        end
        if hitgroup == HITGROUP_STOMACH then
            dmg:ScaleDamage( 1.2 / 1.3 )
        end
        if hitgroup == HITGROUP_HEAD and dmg:GetInflictor():IsWeapon() then
            dmg:ScaleDamage( 100 / dmg:GetDamage() )
        end
    end
end )