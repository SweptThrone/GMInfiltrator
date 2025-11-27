hook.Add( "DoPlayerDeath", "DropWeaponSoTFABallisticsPersists", function( ply )
    if IsValid( ply:GetActiveWeapon() ) and ply:GetActiveWeapon().IsTFAWeapon and not ply:GetActiveWeapon().IsMelee then
        ply:DropWeapon( ply:GetActiveWeapon() )
    end
end )

hook.Add( "PlayerCanPickupWeapon", "Infil.GiveAmmoFromWeapon", function( ply, wep )
    if wep.Dropped then
        wep.Dropped = false
        ply:GiveAmmo( wep:Clip1(), wep:GetPrimaryAmmoType(), false )
        wep:Remove()
        return false
    end
end )