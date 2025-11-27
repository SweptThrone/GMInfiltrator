-- this file is not empty
surface.CreateFont( "InfilDisplay16", {
    font = "coolvetica",
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
    shadow = true,
    additive = false,
    outline = false,
} )

surface.CreateFont( "InfilDisplay20", {
    font = "coolvetica",
    extended = false,
    size = 20,
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

local LoadoutWindow

net.Receive( "Infil.Loadout", function()
    local isInfil = net.ReadBool()

    if isInfil then
        surface.PlaySound( "mus/prep_infil.wav" )
    else
        surface.PlaySound( "mus/prep_guard.wav" )
    end

    if IsValid( LoadoutWindow ) then
        LoadoutWindow:Close()
    end

    LoadoutWindow = vgui.Create( "DFrame" )
    LoadoutWindow:SetSize( 480, 180 )
    LoadoutWindow:Center()
    LoadoutWindow:SetTitle( "" )
    LoadoutWindow:SetVisible( true )
    LoadoutWindow:SetDraggable( false )
    LoadoutWindow:ShowCloseButton( false )
    LoadoutWindow:MakePopup()
    function LoadoutWindow:Paint( w, h )
        draw.RoundedBox( 8, 0, 0, w, h, Color( not isInfil and 0 or 64, 0, not isInfil and 64 or 0, 255 ) )
        draw.RoundedBoxEx( 8, 0, 0, w, 24, Color( not isInfil and 0 or 92, 0, not isInfil and 92 or 0, 255 ), true, true, false, false )
        draw.DrawText( "Loadout", "InfilDisplay16", 6, 4, Color( 255, 255, 255, 255 ) )
    end
    function LoadoutWindow:Think()
        if GetRoundState() == ROUND.ACTIVE then
            self:Close()
            return
        end

        if input.IsKeyDown( input.GetKeyCode( input.LookupBinding( "gm_showspare1" ) ) ) and self.inited then
            self:Close()
        end

        if not self.inited and not input.IsKeyDown( input.GetKeyCode( input.LookupBinding( "gm_showspare1" ) ) ) then
            self.inited = true
        end
    end

    local CloseButton = vgui.Create( "DButton", LoadoutWindow )
    CloseButton:SetPos( 480 - 28, 4 )
    CloseButton:SetSize( 24, 16 )
    CloseButton:SetText( "X" )
    CloseButton:SetTextColor(Color(255,255,255))
    CloseButton.DoClick = function( self )
        LoadoutWindow:Close()
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

    local SendLoadout

    local ConfirmButton = vgui.Create( "DButton", LoadoutWindow )
    ConfirmButton:Dock( BOTTOM )
    ConfirmButton:SetText( "CONFIRM" )
    ConfirmButton:SetTextColor( color_white )
    ConfirmButton.DoClick = function( self )
        SendLoadout()
        LoadoutWindow:Close()
        surface.PlaySound( "ui/buttonclick.wav" )
    end
    ConfirmButton.Paint = function( self, w, h )
        if ConfirmButton:IsDown() then
            draw.RoundedBox( 0, 0, 0, w, h, Color( 70, 180, 20, 255 ) ) 
        elseif ConfirmButton:IsHovered() then
            draw.RoundedBox( 0, 0, 0, w, h, Color( 110, 255, 60, 255 ) )
        else
            draw.RoundedBox( 0, 0, 0, w, h, Color( 90, 228, 43, 255 ) )
        end
        surface.SetDrawColor( color_black )
    end

    if not isInfil then
        local TabMenu = vgui.Create( "DPropertySheet", LoadoutWindow )
        TabMenu:Dock( FILL )

        SendLoadout = function()
            local p = TabMenu:GetActiveTab():GetPanel()

            net.Start( "Infil.Loadout" )
                net.WriteUInt( p.plyClass, 3 )
                net.WriteUInt( p.PrimBox:GetOptionData( p.PrimBox:GetSelectedID() ), 5 )
                net.WriteUInt( p.SecBox:GetOptionData( p.SecBox:GetSelectedID() ), 3 )
            net.SendToServer()
        end

        local AssaultTab = vgui.Create( "DPanel" )
            AssaultTab.plyClass = 1

            AssaultTab.PrimLabel = vgui.Create( "DLabel", AssaultTab )
            AssaultTab.PrimLabel:SetPos( 5, 5 )
            AssaultTab.PrimLabel:SetFont( "InfilDisplay20" )
            AssaultTab.PrimLabel:SetText( "Primary:" )
            AssaultTab.PrimLabel:SetTextColor( color_black )
            AssaultTab.PrimLabel:SizeToContents()

            AssaultTab.PrimBox = vgui.Create( "DComboBox", AssaultTab )
            AssaultTab.PrimBox:SetPos( 100, 5 )
            AssaultTab.PrimBox:SetSize( 350, 20 )
            for i = INFILTRATOR.Classes.Weapons[ 1 ].min, INFILTRATOR.Classes.Weapons[ 1 ].max do
                AssaultTab.PrimBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Primaries[ i ] ).PrintName, i )
            end
            AssaultTab.PrimBox:ChooseOptionID( 1 )

            AssaultTab.SecLabel = vgui.Create( "DLabel", AssaultTab )
            AssaultTab.SecLabel:SetPos( 5, 35 )
            AssaultTab.SecLabel:SetFont( "InfilDisplay20" )
            AssaultTab.SecLabel:SetText( "Secondary:" )
            AssaultTab.SecLabel:SetTextColor( color_black )
            AssaultTab.SecLabel:SizeToContents()

            AssaultTab.SecBox = vgui.Create( "DComboBox", AssaultTab )
            AssaultTab.SecBox:SetPos( 100, 35 )
            AssaultTab.SecBox:SetSize( 350, 20 )
            for i = 1, 3 do
                AssaultTab.SecBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Secondaries[ i ] ).PrintName, i )
            end
            AssaultTab.SecBox:ChooseOptionID( 1 )

            AssaultTab.PerkLabel = vgui.Create( "DLabel", AssaultTab )
            AssaultTab.PerkLabel:SetPos( 5, 65 )
            AssaultTab.PerkLabel:SetFont( "InfilDisplay20" )
            AssaultTab.PerkLabel:SetText( "Bonus:" )
            AssaultTab.PerkLabel:SetTextColor( color_black )
            AssaultTab.PerkLabel:SizeToContents()
            AssaultTab.Perk = vgui.Create( "DLabel", AssaultTab )
            AssaultTab.Perk:SetPos( 100, 65 )
            AssaultTab.Perk:SetFont( "InfilDisplay20" )
            AssaultTab.Perk:SetText( "Tactical Armor (25% DR)" )
            AssaultTab.Perk:SetTextColor( color_black )
            AssaultTab.Perk:SizeToContents()
        TabMenu:AddSheet( "Assault", AssaultTab, "icon16/gun.png" )

        local MedicTab = vgui.Create( "DPanel" )
            MedicTab.plyClass = 2

            MedicTab.PrimLabel = vgui.Create( "DLabel", MedicTab )
            MedicTab.PrimLabel:SetPos( 5, 5 )
            MedicTab.PrimLabel:SetFont( "InfilDisplay20" )
            MedicTab.PrimLabel:SetText( "Primary:" )
            MedicTab.PrimLabel:SetTextColor( color_black )
            MedicTab.PrimLabel:SizeToContents()

            MedicTab.PrimBox = vgui.Create( "DLabel", MedicTab )
            MedicTab.PrimBox:SetPos( 100, 5 )
            MedicTab.PrimBox:SetFont( "InfilDisplay20" )
            MedicTab.PrimBox:SetText( "Medkit" )
            MedicTab.PrimBox:SetTextColor( color_black )
            MedicTab.PrimBox:SizeToContents()
            -- hack to let us send medic class ez
            function MedicTab.PrimBox:GetSelectedID()
                return 0
            end
            function MedicTab.PrimBox:GetOptionData( id )
                return id
            end

            MedicTab.SecLabel = vgui.Create( "DLabel", MedicTab )
            MedicTab.SecLabel:SetPos( 5, 35 )
            MedicTab.SecLabel:SetFont( "InfilDisplay20" )
            MedicTab.SecLabel:SetText( "Secondary:" )
            MedicTab.SecLabel:SetTextColor( color_black )
            MedicTab.SecLabel:SizeToContents()

            MedicTab.SecBox = vgui.Create( "DComboBox", MedicTab )
            MedicTab.SecBox:SetPos( 100, 35 )
            MedicTab.SecBox:SetSize( 350, 20 )
            for i = 1, 3 do
                MedicTab.SecBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Secondaries[ i ] ).PrintName, i )
            end
            MedicTab.SecBox:ChooseOptionID( 1 )

            MedicTab.PerkLabel = vgui.Create( "DLabel", MedicTab )
            MedicTab.PerkLabel:SetPos( 5, 65 )
            MedicTab.PerkLabel:SetFont( "InfilDisplay20" )
            MedicTab.PerkLabel:SetText( "Bonus:" )
            MedicTab.PerkLabel:SetTextColor( color_black )
            MedicTab.PerkLabel:SizeToContents()
            MedicTab.Perk = vgui.Create( "DLabel", MedicTab )
            MedicTab.Perk:SetPos( 100, 65 )
            MedicTab.Perk:SetFont( "InfilDisplay20" )
            MedicTab.Perk:SetText( "Stim Shot (1.5x Stamina)" )
            MedicTab.Perk:SetTextColor( color_black )
            MedicTab.Perk:SizeToContents()
        TabMenu:AddSheet( "Medic", MedicTab, "icon16/pill.png" )

        local OfficerTab = vgui.Create( "DPanel" )
            OfficerTab.plyClass = 3

            OfficerTab.PrimLabel = vgui.Create( "DLabel", OfficerTab )
            OfficerTab.PrimLabel:SetPos( 5, 5 )
            OfficerTab.PrimLabel:SetFont( "InfilDisplay20" )
            OfficerTab.PrimLabel:SetText( "Primary:" )
            OfficerTab.PrimLabel:SetTextColor( color_black )
            OfficerTab.PrimLabel:SizeToContents()

            OfficerTab.PrimBox = vgui.Create( "DComboBox", OfficerTab )
            OfficerTab.PrimBox:SetPos( 100, 5 )
            OfficerTab.PrimBox:SetSize( 350, 20 )
            for i = INFILTRATOR.Classes.Weapons[ 3 ].min, INFILTRATOR.Classes.Weapons[ 3 ].max do
                OfficerTab.PrimBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Primaries[ i ] ).PrintName, i )
            end
            OfficerTab.PrimBox:ChooseOptionID( 1 )

            OfficerTab.SecLabel = vgui.Create( "DLabel", OfficerTab )
            OfficerTab.SecLabel:SetPos( 5, 35 )
            OfficerTab.SecLabel:SetFont( "InfilDisplay20" )
            OfficerTab.SecLabel:SetText( "Secondary:" )
            OfficerTab.SecLabel:SetTextColor( color_black )
            OfficerTab.SecLabel:SizeToContents()

            OfficerTab.SecBox = vgui.Create( "DComboBox", OfficerTab )
            OfficerTab.SecBox:SetPos( 100, 35 )
            OfficerTab.SecBox:SetSize( 350, 20 )
            for i = 1, 3 do
                OfficerTab.SecBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Secondaries[ i ] ).PrintName, i )
            end
            OfficerTab.SecBox:ChooseOptionID( 1 )

            OfficerTab.PerkLabel = vgui.Create( "DLabel", OfficerTab )
            OfficerTab.PerkLabel:SetPos( 5, 65 )
            OfficerTab.PerkLabel:SetFont( "InfilDisplay20" )
            OfficerTab.PerkLabel:SetText( "Bonus:" )
            OfficerTab.PerkLabel:SetTextColor( color_black )
            OfficerTab.PerkLabel:SizeToContents()
            OfficerTab.Perk = vgui.Create( "DLabel", OfficerTab )
            OfficerTab.Perk:SetPos( 100, 65 )
            OfficerTab.Perk:SetFont( "InfilDisplay20" )
            OfficerTab.Perk:SetText( "Security Relay" )
            OfficerTab.Perk:SetTextColor( color_black )
            OfficerTab.Perk:SizeToContents()
        TabMenu:AddSheet( "Officer", OfficerTab, "icon16/shield.png" )

        local MarksmanTab = vgui.Create( "DPanel" )
            MarksmanTab.plyClass = 4

            MarksmanTab.PrimLabel = vgui.Create( "DLabel", MarksmanTab )
            MarksmanTab.PrimLabel:SetPos( 5, 5 )
            MarksmanTab.PrimLabel:SetFont( "InfilDisplay20" )
            MarksmanTab.PrimLabel:SetText( "Primary:" )
            MarksmanTab.PrimLabel:SetTextColor( color_black )
            MarksmanTab.PrimLabel:SizeToContents()

            MarksmanTab.PrimBox = vgui.Create( "DComboBox", MarksmanTab )
            MarksmanTab.PrimBox:SetPos( 100, 5 )
            MarksmanTab.PrimBox:SetSize( 350, 20 )
            for i = INFILTRATOR.Classes.Weapons[ 4 ].min, INFILTRATOR.Classes.Weapons[ 4 ].max do
                MarksmanTab.PrimBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Primaries[ i ] ).PrintName, i )
            end
            MarksmanTab.PrimBox:ChooseOptionID( 2 )

            MarksmanTab.SecLabel = vgui.Create( "DLabel", MarksmanTab )
            MarksmanTab.SecLabel:SetPos( 5, 35 )
            MarksmanTab.SecLabel:SetFont( "InfilDisplay20" )
            MarksmanTab.SecLabel:SetText( "Secondary:" )
            MarksmanTab.SecLabel:SetTextColor( color_black )
            MarksmanTab.SecLabel:SizeToContents()

            MarksmanTab.SecBox = vgui.Create( "DComboBox", MarksmanTab )
            MarksmanTab.SecBox:SetPos( 100, 35 )
            MarksmanTab.SecBox:SetSize( 350, 20 )
            for i = 1, 3 do
                MarksmanTab.SecBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Secondaries[ i ] ).PrintName, i )
            end
            MarksmanTab.SecBox:ChooseOptionID( 1 )

            MarksmanTab.PerkLabel = vgui.Create( "DLabel", MarksmanTab )
            MarksmanTab.PerkLabel:SetPos( 5, 65 )
            MarksmanTab.PerkLabel:SetFont( "InfilDisplay20" )
            MarksmanTab.PerkLabel:SetText( "Bonus:" )
            MarksmanTab.PerkLabel:SetTextColor( color_black )
            MarksmanTab.PerkLabel:SizeToContents()
            MarksmanTab.Perk = vgui.Create( "DLabel", MarksmanTab )
            MarksmanTab.Perk:SetPos( 100, 65 )
            MarksmanTab.Perk:SetFont( "InfilDisplay20" )
            MarksmanTab.Perk:SetText( "Thermal Inlay" )
            MarksmanTab.Perk:SetTextColor( color_black )
            MarksmanTab.Perk:SizeToContents()
        TabMenu:AddSheet( "Marksman", MarksmanTab, "icon16/eye.png" )

        local HeavyTab = vgui.Create( "DPanel" )
            HeavyTab.plyClass = 5

            HeavyTab.PrimLabel = vgui.Create( "DLabel", HeavyTab )
            HeavyTab.PrimLabel:SetPos( 5, 5 )
            HeavyTab.PrimLabel:SetFont( "InfilDisplay20" )
            HeavyTab.PrimLabel:SetText( "Primary:" )
            HeavyTab.PrimLabel:SetTextColor( color_black )
            HeavyTab.PrimLabel:SizeToContents()

            HeavyTab.PrimBox = vgui.Create( "DComboBox", HeavyTab )
            HeavyTab.PrimBox:SetPos( 100, 5 )
            HeavyTab.PrimBox:SetSize( 350, 20 )
            for i = INFILTRATOR.Classes.Weapons[ 5 ].min, INFILTRATOR.Classes.Weapons[ 5 ].max do
                HeavyTab.PrimBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Primaries[ i ] ).PrintName, i )
            end
            HeavyTab.PrimBox:ChooseOptionID( 1 )

            HeavyTab.SecLabel = vgui.Create( "DLabel", HeavyTab )
            HeavyTab.SecLabel:SetPos( 5, 35 )
            HeavyTab.SecLabel:SetFont( "InfilDisplay20" )
            HeavyTab.SecLabel:SetText( "Secondary:" )
            HeavyTab.SecLabel:SetTextColor( color_black )
            HeavyTab.SecLabel:SizeToContents()

            HeavyTab.SecBox = vgui.Create( "DComboBox", HeavyTab )
            HeavyTab.SecBox:SetPos( 100, 35 )
            HeavyTab.SecBox:SetSize( 350, 20 )
            for i = 1, 3 do
                HeavyTab.SecBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Secondaries[ i ] ).PrintName, i )
            end
            HeavyTab.SecBox:ChooseOptionID( 1 )

            HeavyTab.PerkLabel = vgui.Create( "DLabel", HeavyTab )
            HeavyTab.PerkLabel:SetPos( 5, 65 )
            HeavyTab.PerkLabel:SetFont( "InfilDisplay20" )
            HeavyTab.PerkLabel:SetText( "Bonus:" )
            HeavyTab.PerkLabel:SetTextColor( color_black )
            HeavyTab.PerkLabel:SizeToContents()
            HeavyTab.Perk = vgui.Create( "DLabel", HeavyTab )
            HeavyTab.Perk:SetPos( 100, 65 )
            HeavyTab.Perk:SetFont( "InfilDisplay20" )
            HeavyTab.Perk:SetText( "Heavy Armor (50% DR)" )
            HeavyTab.Perk:SetTextColor( color_black )
            HeavyTab.Perk:SizeToContents()
        TabMenu:AddSheet( "Heavy", HeavyTab, "icon16/rosette.png" )
    else --if LocalPlayer():Team() == TEAM_INFIL then
        local PrimLabel = vgui.Create( "DLabel", LoadoutWindow )
        PrimLabel:SetPos( 15, 30 )
        PrimLabel:SetFont( "InfilDisplay20" )
        PrimLabel:SetText( "Primary:" )
        PrimLabel:SetTextColor( color_white )
        PrimLabel:SizeToContents()

        local PrimBox = vgui.Create( "DComboBox", LoadoutWindow )
        PrimBox:SetPos( 110, 30 )
        PrimBox:SetSize( 350, 20 )
        for i = 15, 17 do
            PrimBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Primaries[ i ] ).PrintName, i )
        end
        PrimBox:ChooseOptionID( 1 )

        local SecLabel = vgui.Create( "DLabel", LoadoutWindow )
        SecLabel:SetPos( 15, 60 )
        SecLabel:SetFont( "InfilDisplay20" )
        SecLabel:SetText( "Secondary:" )
        SecLabel:SetTextColor( color_white )
        SecLabel:SizeToContents()

        local SecBox = vgui.Create( "DComboBox", LoadoutWindow )
        SecBox:SetPos( 110, 60 )
        SecBox:SetSize( 350, 20 )
        for i = 1, 4 do
            SecBox:AddChoice( weapons.Get( "infil_" .. INFILTRATOR.Secondaries[ i ] ).PrintName, i )
        end
        SecBox:ChooseOptionID( 4 )

        local perks = {
            { "Thermal Inlay", 1 },
            { "Active Camo", 4 },
            { "Lightweight Armor (10% DR)", 8 },
            { "Extra Ammo", 16 },
            { "3x SLAMs", 32 },
            { "Stim Pack (2x Stamina)", 64 }
        }

        local PerkLabel = vgui.Create( "DLabel", LoadoutWindow )
        PerkLabel:SetPos( 15, 90 )
        PerkLabel:SetFont( "InfilDisplay20" )
        PerkLabel:SetText( "Bonus:" )
        PerkLabel:SetTextColor( color_white )
        PerkLabel:SizeToContents()
        local PerkBox = vgui.Create( "DComboBox", LoadoutWindow )
        PerkBox:SetPos( 110, 90 )
        PerkBox:SetSize( 350, 20 )
        for i = 1, 6 do
            PerkBox:AddChoice( perks[ i ][ 1 ], perks[ i ][ 2 ] )
        end
        PerkBox:ChooseOptionID( 1 )

        local LocLabel = vgui.Create( "DLabel", LoadoutWindow )
        LocLabel:SetPos( 15, 120 )
        LocLabel:SetFont( "InfilDisplay20" )
        LocLabel:SetText( "Infiltration:" )
        LocLabel:SetTextColor( color_white )
        LocLabel:SizeToContents()

        local LocBox = vgui.Create( "DComboBox", LoadoutWindow )
        LocBox:SetPos( 110, 120 )
        LocBox:SetSize( 350, 20 )
        for i = 1, 3 do
            LocBox:AddChoice( INFILTRATOR.Infiltrations[ i ], i )
        end
        LocBox:ChooseOptionID( 1 )
        
        SendLoadout = function()
            net.Start( "Infil.Loadout" )
                net.WriteUInt( PrimBox:GetOptionData( PrimBox:GetSelectedID() ), 5 )
                net.WriteUInt( SecBox:GetOptionData( SecBox:GetSelectedID() ), 3 )
                net.WriteUInt( PerkBox:GetOptionData( PerkBox:GetSelectedID() ), 32 )
                net.WriteUInt( LocBox:GetOptionData( LocBox:GetSelectedID() ), 3 )
            net.SendToServer()
        end

    end

end )