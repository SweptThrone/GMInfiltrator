-- this file is not empty

local vignette = Material( "vgui/zoom" )
function STVignette( passes )

    local alphaleft = passes * 255
    surface.SetMaterial( vignette )
    while alphaleft > 0 do
        surface.SetDrawColor( 255, 255, 255, math.min( alphaleft, 255 ) )
        surface.DrawTexturedRect( ScrW() / 2, -1, ScrW() / 2, ScrH() / 2 + 1 )
        surface.DrawTexturedRectUV( -1, -1, ScrW() / 2 + 1, ScrH() / 2 + 1, 1, 0, 0, 1 )
        surface.DrawTexturedRectUV( ScrW() / 2, ScrH() / 2, ScrW() / 2, ScrH() / 2, 0, 1, 1, 0 )
        surface.DrawTexturedRectUV( -1, ScrH() / 2, ScrW() / 2 + 1, ScrH() / 2, 1, 1, 0, 0 )
        alphaleft = alphaleft - math.min( alphaleft, 255 )
    end

end

hook.Add( "HUDPaint", "DrawVignetteADS", function()
    local wep = LocalPlayer():GetActiveWeapon()

    if wep.IronSightsProgress and not wep.Scoped and wep.Secondary.IronFOV ~= 100 then
        STVignette( wep.IronSightsProgress )
    end
end )