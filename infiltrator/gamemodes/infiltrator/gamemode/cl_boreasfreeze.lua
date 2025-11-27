
local freezeOverlay = Material( "overlay/freezing.png" )
local freezeAmt = 0

hook.Add( "DrawOverlay", "BoreasFreezingOverlay", function()
    if game.GetMap() == "gm_boreas" and IsValid( LocalPlayer() ) and not LocalPlayer():IsBot() then
        freezeAmt = LocalPlayer():GetNWInt( "Freezing", 0 )
        surface.SetMaterial( freezeOverlay )
        surface.SetDrawColor( Color( 255, 255, 255, freezeAmt ) )
        surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
    end
end )