-- this file is not empty
if SERVER then
    util.AddNetworkString( "Infil.Tutorial" )

    hook.Add( "ShowHelp", "Infil.TutorialMenu", function( ply )
        net.Start( "Infil.Tutorial" )
        net.Send( ply )
    end )
end

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

    net.Receive( "Infil.Tutorial", function()
        TutorialWindow = vgui.Create( "DFrame" )
        TutorialWindow:SetSize( 640, 480 )
        TutorialWindow:Center()
        TutorialWindow:SetTitle( "" )
        TutorialWindow:SetVisible( true )
        TutorialWindow:SetDraggable( false )
        TutorialWindow:ShowCloseButton( false )
        TutorialWindow:MakePopup()
        function TutorialWindow:Paint( w, h )
            draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 64, 64, 255 ) )
            draw.RoundedBoxEx( 8, 0, 0, w, 24, Color( 0, 92, 92, 255 ), true, true, false, false )
            draw.DrawText( "Tutorial", "InfilDisplay16", 6, 4, Color( 255, 255, 255, 255 ) )
        end
        function TutorialWindow:Think()
            if input.IsKeyDown( input.GetKeyCode( input.LookupBinding( "gm_showhelp" ) ) ) and self.inited then
                self:Close()
            end

            if not self.inited and not input.IsKeyDown( input.GetKeyCode( input.LookupBinding( "gm_showhelp" ) ) ) then
                self.inited = true
            end
        end

        local CloseButton = vgui.Create( "DButton", TutorialWindow )
        CloseButton:SetPos( 640 - 28, 4 )
        CloseButton:SetSize( 24, 16 )
        CloseButton:SetText( "X" )
        CloseButton:SetTextColor(Color(255,255,255))
        CloseButton.DoClick = function( self )
            TutorialWindow:Close()
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

        local TabMenu = vgui.Create( "DPropertySheet", TutorialWindow )
        TabMenu:Dock( FILL )

        local SummaryTab = vgui.Create( "DPanel" )
            local sh = vgui.Create( "DLabel", SummaryTab )
            sh:SetPos( 10, 5 )
            sh:SetFont( "InfilTutHeader" )
            sh:SetText( "Welcome to Infiltrator" )
            sh:SetTextColor( color_black )
            sh:SizeToContents()

            local sText = vgui.Create( "RichText", SummaryTab )
            sText:SetPos( 5, 30 )
            sText:SetSize( 600, 400 )
            sText:SetVerticalScrollbarEnabled( false )
            sText:InsertColorChange( 0, 0, 0, 255 )
            sText:SetFontInternal( "InfilTutText" )
            sText:AppendText(
[[Infiltrator is a hardcore team-based stealth gamemode that pits a single sneaky infiltrator against
the rest of the server.

The solo infiltrator must enter the sprawling underground facility, complete six objectives spread around
the interior, then extract at one of three locations.
It is not an easy task; guards could be waiting around any corner.

The team of heavily-armed guards must hunt down the infiltrator and take him out before he
completes all of the objectives.

The guards have infinite lives; the infiltrator has only one.]] )
            function sText:PerformLayout()
                if ( self:GetFont() != "InfilTutText" ) then self:SetFontInternal( "InfilTutText" ) end
                self:SetFGColor( color_black )
            end
        TabMenu:AddSheet( "Summary", SummaryTab, "icon16/information.png" )

        local BasicsTab = vgui.Create( "DPanel" )
            local bh = vgui.Create( "DLabel", BasicsTab )
            bh:SetPos( 10, 5 )
            bh:SetFont( "InfilTutHeader" )
            bh:SetText( "Special Mechanics" )
            bh:SetTextColor( color_black )
            bh:SizeToContents()

            local bText = vgui.Create( "RichText", BasicsTab )
            bText:SetPos( 5, 30 )
            bText:SetSize( 600, 400 )
            bText:SetVerticalScrollbarEnabled( false )
            bText:InsertColorChange( 0, 0, 0, 255 )
            bText:SetFontInternal( "InfilTutText" )
            bText:AppendText(
[[Infiltrator has some fun mechanics to keep things interesting.

 • If you are outdoors for too long without a thermal inlay, you will freeze to death.
 • Anyone can view the facility's cameras from the security office.
 • The facility cameras can be damaged to be disabled for a few seconds.
 • All objectives have strobe light effect applied to them (except the rocket hatch).]] )
            function bText:PerformLayout()
                if ( self:GetFont() != "InfilTutText" ) then self:SetFontInternal( "InfilTutText" ) end
                self:SetFGColor( color_black )
            end
        TabMenu:AddSheet( "Mechanics", BasicsTab, "icon16/cog.png" )

        local GuardTab = vgui.Create( "DPanel" )
            local gh = vgui.Create( "DLabel", GuardTab )
            gh:SetPos( 10, 5 )
            gh:SetFont( "InfilTutHeader" )
            gh:SetText( "Playing as a Guard" )
            gh:SetTextColor( color_black )
            gh:SizeToContents()

            local gText = vgui.Create( "RichText", GuardTab )
            gText:SetPos( 5, 30 )
            gText:SetSize( 600, 400 )
            gText:SetVerticalScrollbarEnabled( false )
            gText:InsertColorChange( 0, 0, 0, 255 )
            gText:SetFontInternal( "InfilTutText" )
            gText:AppendText(
[[Being a guard is pretty simple:  find and kill the infiltrator.

You and the rest of guards can hear each others' voice chat at all times, as long as you're alive.
You cannot, however, see who is speaking, so it would be a good idea to acquaint yourselves with
the rest of the security force before proceeding.
You can also use team text chat by ]] .. ( input.LookupBinding( "messagemode2" ) and "hitting " .. input.LookupBinding( "messagemode2" ):upper() or "binding a key to Team Chat" ) .. [[.

All guards spawn in the bunks as the class they picked.
You cannot change your class once the round has begun, so choose wisely.]] )
            function gText:PerformLayout()
                if ( self:GetFont() != "InfilTutText" ) then self:SetFontInternal( "InfilTutText" ) end
                self:SetFGColor( color_black )
            end
        TabMenu:AddSheet( "Guard", GuardTab, "icon16/star.png" )

        local InfilTab = vgui.Create( "DPanel" )
            local ih = vgui.Create( "DLabel", InfilTab )
            ih:SetPos( 10, 5 )
            ih:SetFont( "InfilTutHeader" )
            ih:SetText( "Playing as the Infiltrator" )
            ih:SetTextColor( color_black )
            ih:SizeToContents()

            local iText = vgui.Create( "RichText", InfilTab )
            iText:SetPos( 5, 30 )
            iText:SetSize( 600, 400 )
            iText:SetVerticalScrollbarEnabled( false )
            iText:InsertColorChange( 0, 0, 0, 255 )
            iText:SetFontInternal( "InfilTutText" )
            iText:AppendText(
[[Being the infiltrator is a challenge; you are outnumbered and severely outgunned.

You must first make a long trek into the facility.  Infil-Vision can help you find your way.
]] .. ( input.LookupBinding( "+zoom" ) and "Holding " .. input.LookupBinding( "+zoom" ):upper() or "Binding a key to Suit Zoom" ) .. [[ allows you to see objectives from anywhere.
Green things are mandatory objectives.
Aqua things are optional objectives.
Red things are exfiltration points.  These can only be used once you have completed all six objectives.

There are several ways to approach the facility.  Your job is to pick one and complete the mission.]] )
            function iText:PerformLayout()
                if ( self:GetFont() != "InfilTutText" ) then self:SetFontInternal( "InfilTutText" ) end
                self:SetFGColor( color_black )
            end
        TabMenu:AddSheet( "Infiltrator", InfilTab, "icon16/user_gray.png" )

        local ObjTab = vgui.Create( "DPanel" )
            local ph = vgui.Create( "DLabel", ObjTab )
            ph:SetPos( 10, 5 )
            ph:SetFont( "InfilTutHeader" )
            ph:SetText( "List of Objectives" )
            ph:SetTextColor( color_black )
            ph:SizeToContents()

            local oText = vgui.Create( "RichText", ObjTab )
            oText:SetPos( 5, 30 )
            oText:SetSize( 600, 400 )
            oText:SetVerticalScrollbarEnabled( false )
            oText:InsertColorChange( 0, 0, 0, 255 )
            oText:SetFontInternal( "InfilTutText" )
            oText:AppendText(
[[There are six mandatory objectives and three optional objectives.

These six objectives must be completed before the infiltrator can extract and win:
1. Download the sensitive files from the servers.
    Find the computer, use it, then come back a few minutes later and use it again.
    This can be found in the server room.
2. Steal the visitor list.
    Find the box of files and use it.
    This can be found somewhere in the front reception area.
3. Overload the water pressure tank.
    Spam-use the pressure valve.
    This can be found in the botany wing.
4. Destroy the shipment of supplies.
    Deal damage to the large crate.
    This can be found somewhere in the shipping area.
5. Steal the research notes.
    Find the clipboard and use it.
    This can be found somewhere in the excavation site.
6. Sabotage the rocket.
    Find the rocket panel and use it.
    This can be found on the top of the rocket.]] )
            function oText:PerformLayout()
                if ( self:GetFont() != "InfilTutText" ) then self:SetFontInternal( "InfilTutText" ) end
                self:SetFGColor( color_black )
            end
        TabMenu:AddSheet( "Objectives", ObjTab, "icon16/exclamation.png" )

        local OptTab = vgui.Create( "DPanel" )
            local oh = vgui.Create( "DLabel", OptTab )
            oh:SetPos( 10, 5 )
            oh:SetFont( "InfilTutHeader" )
            oh:SetText( "Optional Objectives" )
            oh:SetTextColor( color_black )
            oh:SizeToContents()

            local pText = vgui.Create( "RichText", OptTab )
            pText:SetPos( 5, 30 )
            pText:SetSize( 600, 400 )
            pText:SetVerticalScrollbarEnabled( false )
            pText:InsertColorChange( 0, 0, 0, 255 )
            pText:SetFontInternal( "InfilTutText" )
            pText:AppendText(
[[There are six mandatory objectives and three optional objectives.

These three objectives do not have to be completed, but may help the infiltrator:
1. Steal the guard uniform.
    Find the uniform locker and use it.
    This can be found in one of the Zethes Checkpoint houses.
    This will disguise the infiltrator as a guard.
2. Steal the receiver.
    Find the small computer box and use it.
    This can be found somewhere in the Calais Radar Station.

With the receiver, the infiltrator may do one of the following:
2.1. Hack the comms relay.
    Find the stand-up server and use it.
    This can be found in the Relay Station.
    This will allow the infiltrator to hear and see guard communications.
2.2. Hack the camera control box.
    Find the camera control box and use it.
    This can be found in the security office.
    This will allow the infiltrator to look through facility cameras from anywhere.]] )
            function pText:PerformLayout()
                if ( self:GetFont() != "InfilTutText" ) then self:SetFontInternal( "InfilTutText" ) end
                self:SetFGColor( color_black )
            end
        TabMenu:AddSheet( "Optionals", OptTab, "icon16/help.png" )
    end )
end