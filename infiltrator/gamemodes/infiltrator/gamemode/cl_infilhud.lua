surface.CreateFont( "InfilHUDIcons", {
    font = "csd",
    size = 144,
    additive = false
} )

surface.CreateFont( "InfilHUDWeps", {
    font = "csd",
    size = 200,
    additive = false
} )

surface.CreateFont( "InfilHUDFont", {
    font = "Georgia",
    size = 48,
    additive = false,
    weight = 50
} )

surface.CreateFont( "InfilStatusFont", {
    font = "Georgia",
    size = 24,
    additive = false,
    weight = 50
} )

surface.CreateFont( "InfilObjHFont", {
    font = "Georgia",
    size = 24,
    additive = false,
    weight = 50,
    shadow = true
} )

surface.CreateFont( "InfilObjFont", {
    font = "Georgia",
    size = 16,
    additive = false,
    weight = 50,
    shadow = true
} )

surface.CreateFont( "InfilCObjFont", {
    font = "Georgia",
    size = 16,
    additive = false,
    weight = 50,
    shadow = true,
    rotary = true
} )

hook.Remove( "HUDPaint", "DrawST2StaminaHUD" )

local margin = 16
local padding = 2
local height = 150
local width = 20

local jammerMat = Material( "infil/jammer.png" )
local disguiseMat = Material( "infil/disguise.png" )

local objTexts = {
    "Download files from servers (Server Center)",
    "Steal visitor log (Entry)",
    "Overload water pressure (Greenery)",
    "Destroy equipment shipment (Shipping)",
    "Steal research notes (Excavation Site)",
    "Sabotage rocket (Rocket Silo)"
}

hook.Add( "HUDPaint", "InfiltratorHUD", function()
    local ply = LocalPlayer()

    -- time and round display
    local time = GetRoundState() == ROUND.NOPLAYERS and "--:--" or string.FormattedTime( math.Round( GetStateTime() - CurTime() ), "%02i:%02i" )
    surface.SetFont( "InfilHUDFont" )
    surface.SetTextColor( 0, 0, 0, 255 )
    surface.SetTextPos( ScrW() / 2 - surface.GetTextSize( time ) / 2 + 2, 5 + 4 )
    surface.DrawText( time )
    surface.SetTextColor( 96, 96, 96, 255 )
    surface.SetTextPos( ScrW() / 2 - surface.GetTextSize( time ) / 2, 5 )
    surface.DrawText( time )

    surface.SetFont( "InfilStatusFont" )
    surface.SetTextColor( 0, 0, 0, 255 )
    surface.SetTextPos( ScrW() / 2 - surface.GetTextSize( ROUND_STRINGS[ GetRoundState() ] ) / 2 + 1, 49 + 2 )
    surface.DrawText( ROUND_STRINGS[ GetRoundState() ] )
    surface.SetTextColor( 96, 96, 96, 255 )
    surface.SetTextPos( ScrW() / 2 - surface.GetTextSize( ROUND_STRINGS[ GetRoundState() ] ) / 2, 49 )
    surface.DrawText( ROUND_STRINGS[ GetRoundState() ] )

    if ply:Team() == TEAM_SPECTATOR then return end

    -- stamina
    local outHeight = math.min( ply:GetStamina(), 100 ) / 100 * height + 1
    local y = ScrH() - margin - outHeight + 1

    local h2 = ( math.max( ply:GetStamina() - 100, 0 ) / 100 * height + 1 ) / 2
    local y2 = ScrH() - margin - h2 + 1

    if ply:GetStamina() <= 25 then
        surface.SetDrawColor( 96, 16, 16, 192 )
    else
        surface.SetDrawColor( 24, 96, 16, 192 )
    end
    surface.DrawRect( margin + padding, y, width, outHeight )
    surface.SetDrawColor( 104, 160, 16, 192 )
    surface.DrawRect( margin + padding, y2, width / 2, h2 )
    surface.SetDrawColor( 92, 96, 64, 192 )
    surface.DrawOutlinedRect( margin, ScrH() - margin - height - padding, width + padding * 2, height + padding * 2, 2 )
  
    -- health
    surface.SetFont( "InfilHUDIcons" )
    surface.SetTextColor( 0, 0, 0, 255 )
    surface.SetTextPos( margin + padding + padding + width + 2, ScrH() - 88 + 4 )
    surface.DrawText( "F" )
    surface.SetTextColor( 127, 115, 74, 255 )
    surface.SetTextPos( margin + padding + padding + width, ScrH() - 88 )
    surface.DrawText( "F" )

    surface.SetFont( "InfilHUDFont" )
    surface.SetTextColor( 0, 0, 0, 255 )
    surface.SetTextPos( 100 + margin + padding + padding + width + 2, ScrH() - 56 + 4 )
    surface.DrawText( ply:Health() )
    surface.SetTextColor( 108, 82, 46, 255 )
    if ply:Health() <= 25 then
        surface.SetTextColor( 170, 10, 10, 255 )
    elseif ply:Health() <= 50 then
        surface.SetTextColor( 170, 170, 6, 255 )  
    end
    surface.SetTextPos( 100 + margin + padding + padding + width, ScrH() - 56 )
    surface.DrawText( ply:Health() )

    -- DR
    surface.SetFont( "InfilHUDIcons" )
    surface.SetTextColor( 0, 0, 0, 255 )
    surface.SetTextPos( margin + padding + padding + width + 200 + 2, ScrH() - 88 + 4 )
    surface.DrawText( "p" )
    surface.SetTextColor( 51, 61, 50, 255 )
    surface.SetTextPos( margin + padding + padding + width + 200, ScrH() - 88 )
    surface.DrawText( "p" )

    surface.SetFont( "InfilHUDFont" )
    surface.SetTextColor( 0, 0, 0, 255 )
    surface.SetTextPos( 300 + margin + padding + padding + width + 2, ScrH() - 56 + 4 )
    surface.DrawText( ( ply.GetDR and math.floor( ply:GetDR() * 100 ) or "-" ) .. "%" )
    surface.SetTextColor( 58, 61, 43, 255 )
    surface.SetTextPos( 300 + margin + padding + padding + width, ScrH() - 56 )
    surface.DrawText( ( ply.GetDR and math.floor( ply:GetDR() * 100 ) or "-" ) .. "%" )

    -- weapon
    local wep = ply:GetActiveWeapon()
    if not IsValid( wep ) then return end
    if wep:GetClass() == "weapon_slam" then wep.IconLetter = "I" end
    if wep.IconLetter then
        draw.SimpleTextOutlined( wep.IconLetter, "InfilHUDWeps", ScrW() - 300, ScrH() - 140, Color( 16, 16, 16, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, Color( 64, 64, 64, 255 ) )

        -- ammo
        if not wep.IsMelee then
            local clipString = wep:Clip1() > wep:GetMaxClip1() and wep:GetMaxClip1() .. "+" .. wep:Clip1() - wep:GetMaxClip1() or wep:Clip1()
            surface.SetFont( "InfilHUDFont" )
            surface.SetTextColor( 0, 0, 0, 255 )
            surface.SetTextPos( ScrW() - 400 + 2, ScrH() - 56 + 4 )
            surface.DrawText( clipString )
            surface.SetTextColor( 96, 96, 96, 255 )
            if wep:Clip1() <= 0.25 * wep:GetMaxClip1() then
                surface.SetTextColor( 170, 10, 10, 255 )
            elseif wep:Clip1() <= 0.5 * wep:GetMaxClip1() then
                surface.SetTextColor( 170, 170, 6, 255 )  
            end
            surface.SetTextPos( ScrW() - 400, ScrH() - 56 )
            surface.DrawText( clipString )

            -- reserve
            local reserve = ply:GetAmmoCount( wep:GetPrimaryAmmoType() )
            surface.SetFont( "InfilHUDFont" )
            surface.SetTextColor( 0, 0, 0, 255 )
            surface.SetTextPos( ScrW() - 120 + 2, ScrH() - 200 + 4 )
            surface.DrawText( reserve )
            surface.SetTextColor( 96, 96, 96, 255 )
            if reserve <= wep:GetMaxClip1() then
                surface.SetTextColor( 170, 10, 10, 255 )
            elseif reserve <= 3 * wep:GetMaxClip1() then
                surface.SetTextColor( 170, 170, 6, 255 )  
            end
            surface.SetTextPos( ScrW() - 120, ScrH() - 200 )
            surface.DrawText( reserve )
        end
    end

    -- stuff
    local size = 64
    if ply:GetNWBool( "HasJammer", false ) then
        surface.SetMaterial( jammerMat )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( ScrW() / 2 - ( ply:GetNWBool( "IsDisguised", false ) and size or size / 2 ), ScrH() - size - 10, size, size )
        
        if ply:GetNWBool( "IsDisguised", false ) then
            surface.SetMaterial( disguiseMat )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( ScrW() / 2 + size, ScrH() - size - 10, size, size )
        end
    elseif ply:GetNWBool( "IsDisguised", false ) then
        surface.SetMaterial( disguiseMat )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( ScrW() / 2 - size / 2, ScrH() - size - 10, size, size )
    end

    -- objectives
    if LocalPlayer():Team() == TEAM_INFIL then
        surface.SetFont( "InfilObjHFont" )
        surface.SetTextColor( 255, 255, 255, 255 )
        surface.SetTextPos( 5, 5 )
        surface.DrawText( "OBJECTIVES:" )

        local obj = game.GetWorld():GetNWInt( "Objectives", 0 )
        for i = 0, 5 do
            local c = bit.band( obj, bit.lshift( 1, i ) ) == bit.lshift( 1, i )
            surface.SetFont( c and "InfilCObjFont" or "InfilObjFont" )
            surface.SetTextColor( c and 0 or 255, c and 255 or 0, 0, 255 )
            surface.SetTextPos( 5, 26 + i * 16 )
            surface.DrawText( objTexts[ i + 1 ] )
        end
    end

end )

local hideMe = {
	CHudHealth = true
}

hook.Add( "HUDShouldDraw", "InfilHUD.HideElements", function( name )
	if ( hideMe[ name ] ) then
		return false
	end
end )

hook.Add( "DrawDeathNotice", "HideKillFeed", function()
	return 150, 150
end )

local alive = true
local deadTime = 0

hook.Add( "HUDPaint", "ShowRespawnTimer", function()

    if LocalPlayer():Alive() ~= alive then
        if not LocalPlayer():Alive() then
            deadTime = CurTime()
        end

        alive = LocalPlayer():Alive()
    end

    if deadTime ~= 0 and not LocalPlayer():Alive() then
        local txt = ( deadTime + 30 ) - CurTime() > 0 and string.format( "%3.1f", math.max( math.Round( ( deadTime + 30 ) - CurTime(), 1 ), 0 ) ) or "GO"

        surface.SetFont( "InfilHUDFont" )
        surface.SetTextColor( 0, 0, 0, 255 )
        surface.SetTextPos( ScrW() / 2 - surface.GetTextSize( txt ) / 2 + 2, ScrH() / 2 + 50 + 4 )
        surface.DrawText( txt )
        surface.SetTextColor( 255, 255, 255, 255 )
        surface.SetTextPos( ScrW() / 2 - surface.GetTextSize( txt ) / 2, ScrH() / 2 + 50 )
        surface.DrawText( txt )
        
    end
end )

net.Receive( "Infil.Music", function()
    local guardsWin = net.ReadBool()

    if IsValid( LocalPlayer() ) then
        if ( guardsWin and ( LocalPlayer():Team() == TEAM_GUARD or LocalPlayer():Team() == TEAM_SPECTATOR ) ) or ( not guardsWin and LocalPlayer():Team() == TEAM_INFIL ) then
            surface.PlaySound( "mus/infil_win.wav" )
        else
            surface.PlaySound( "mus/infil_lose.wav" )
        end
    end
end )