-- this file is not empty
if SERVER then
    util.AddNetworkString( "Infil.Prefs" )

    hook.Add( "ShowTeam", "Infil.PrefsMenu", function( ply )
        net.Start( "Infil.Prefs" )
        net.Send( ply )
    end )
end

CreateClientConVar( "cl_infil_avoidinfil", "0", true, true, "Whether or not to avoid being chosen as the infiltrator.", 0, 1 )
CreateClientConVar( "cl_infil_spectateonly", "0", true, true, "Whether or not to ONLY spectate and never spawn.", 0, 1 )

if CLIENT then

    surface.CreateFont( "InfilTutHeader", {
        font = "coolvetica",
        extended = false,
        size = 24,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    } )
    surface.CreateFont( "InfilTutText", {
        font = "Arial",
        extended = false,
        size = 16,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    } )

    net.Receive( "Infil.Prefs", function()
        PrefsWindow = vgui.Create( "DFrame" )
        PrefsWindow:SetSize( 320, 100 )
        PrefsWindow:Center()
        PrefsWindow:SetTitle( "" )
        PrefsWindow:SetVisible( true )
        PrefsWindow:SetDraggable( false )
        PrefsWindow:ShowCloseButton( false )
        PrefsWindow:MakePopup()
        function PrefsWindow:Paint( w, h )
            draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 64, 64, 255 ) )
            draw.RoundedBoxEx( 8, 0, 0, w, 24, Color( 0, 92, 92, 255 ), true, true, false, false )
            draw.DrawText( "Preferences", "InfilDisplay16", 6, 4, Color( 255, 255, 255, 255 ) )
        end
        function PrefsWindow:Think()
            if input.IsKeyDown( input.GetKeyCode( input.LookupBinding( "gm_showteam" ) ) ) and self.inited then
                self:Close()
            end

            if not self.inited and not input.IsKeyDown( input.GetKeyCode( input.LookupBinding( "gm_showteam" ) ) ) then
                self.inited = true
            end
        end

        local CloseButton = vgui.Create( "DButton", PrefsWindow )
        CloseButton:SetPos( 320 - 28, 4 )
        CloseButton:SetSize( 24, 16 )
        CloseButton:SetText( "X" )
        CloseButton:SetTextColor(Color(255,255,255))
        CloseButton.DoClick = function( self )
            PrefsWindow:Close()
            surface.PlaySound( "ui/buttonclick.wav" )
        end
        CloseButton.Paint = function( self, w, h )
            if CloseButton:IsDown() then
                draw.RoundedBox( 0, 0, 0, w, h, Color( 180, 70, 20, 255 ) ) 
            elseif CloseButton:IsHovered() then
                draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 110, 60, 255 ) )
            else
                draw.RoundedBox( 0, 0, 0, w, h, Color( 228, 90, 43, 255 ) )
            end
            surface.SetDrawColor( color_black )
        end

        local InfilCheck = vgui.Create( "DCheckBoxLabel", PrefsWindow )
        InfilCheck:SetPos( 15, 35 )
        InfilCheck:SetTextColor( color_white )
        InfilCheck:SetChecked( GetConVar( "cl_infil_avoidinfil" ):GetBool() )
        InfilCheck:SetConVar( "cl_infil_avoidinfil" )
        InfilCheck:SetText( "Avoid being chosen as infiltrator" )

        local SpectateCheck = vgui.Create( "DCheckBoxLabel", PrefsWindow )
        SpectateCheck:SetPos( 15, 65 )
        SpectateCheck:SetTextColor( color_white )
        SpectateCheck:SetChecked( GetConVar( "cl_infil_spectateonly" ):GetBool() )
        SpectateCheck:SetConVar( "cl_infil_spectateonly" )
        SpectateCheck:SetText( "ONLY spectate, you will NEVER spawn" )

    end )
end