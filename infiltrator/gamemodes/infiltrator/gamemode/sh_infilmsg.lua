if SERVER then
    util.AddNetworkString( "Infil.Msg" )
end

local plyMeta = FindMetaTable( "Player" )

if SERVER then
    function plyMeta:InfilMsg( txt )
        net.Start( "Infil.Msg" )
            net.WriteString( txt )
        net.Send( self )
    end

    function InfilMsg( txt )
        net.Start( "Infil.Msg" )
            net.WriteString( txt )
        net.Broadcast()
    end
end

if CLIENT then
    surface.CreateFont( "InfilMsgFont", {
        font = "Garamond",
        size = 24,
        additive = false,
        weight = 2000
    } )

    function plyMeta:InfilMsg( txt )
        local callTime = CurTime()

        hook.Add( "HUDPaint", "Infil.InfilMsg", function()
            surface.SetFont( "InfilMsgFont" )
            surface.SetTextPos( ScrW() / 2 - surface.GetTextSize( txt:upper() ) / 2 + 1, ScrH() * 0.6 + 2 )
            surface.SetTextColor( 0, 0, 0, 255 - ( ( CurTime() - 5 - callTime ) * 255 ) )
            surface.DrawText( txt:upper() )
            surface.SetTextPos( ScrW() / 2 - surface.GetTextSize( txt:upper() ) / 2, ScrH() * 0.6 )
            surface.SetTextColor( 255, 255, 255, 255 - ( ( CurTime() - 5 - callTime ) * 255 ) )
            surface.DrawText( txt:upper() )

            if CurTime() > callTime + 7 then hook.Remove( "HUDPaint", "Infil.InfilMsg" ) end
        end )
    end

    net.Receive( "Infil.Msg", function()
        local txt = net.ReadString()

        if not IsValid( LocalPlayer() ) then return end

        LocalPlayer():InfilMsg( txt )
    end )
end