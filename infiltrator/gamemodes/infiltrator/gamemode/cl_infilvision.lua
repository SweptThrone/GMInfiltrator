BOREAS_GLOWERS = BOREAS_GLOWERS or {}
BOREAS_EXTRACTS = BOREAS_EXTRACTS or {}

local isZooming = false

hook.Add( "OnSpawnMenuOpen", "RerouteQToInfilVision", function()
    isZooming = true
end )

hook.Add( "OnSpawnMenuClose", "RerouteUnQToInfilVision", function()
    isZooming = false
end )

hook.Add( "CreateMove", "QIsZoom", function( cmd )
    if isZooming then cmd:AddKey( IN_ZOOM ) end
end )

hook.Add( "Think", "InfilVision.GatherEntities", function()
    if GetRoundState() == ROUND.ACTIVE and #BOREAS_EXTRACTS == 0 then
        table.insert( BOREAS_EXTRACTS, ents.GetMapCreatedEntity( 4857 ) )
        table.insert( BOREAS_EXTRACTS, ents.GetMapCreatedEntity( 4858 ) )
        table.insert( BOREAS_EXTRACTS, ents.FindByClass( "st_xfilvan" )[ 1 ] )
        table.insert( BOREAS_EXTRACTS, ents.FindByClass( "st_xfilvan" )[ 2 ] )
        
        
        table.insert( BOREAS_GLOWERS, ents.FindByClass( "st_camerabox" )[ 1 ] )
        table.insert( BOREAS_GLOWERS, ents.FindByClass( "st_jammableserver" )[ 1 ] )
        table.insert( BOREAS_GLOWERS, ents.FindByClass( "st_jammer" )[ 1 ] )
        table.insert( BOREAS_GLOWERS, ents.FindByClass( "st_pressurevalve" )[ 1 ] )
        table.insert( BOREAS_GLOWERS, ents.FindByClass( "st_researchnotes" )[ 1 ] )
        table.insert( BOREAS_GLOWERS, ents.FindByClass( "st_serverbox" )[ 1 ] )
        table.insert( BOREAS_GLOWERS, ents.FindByClass( "st_shipment" )[ 1 ] )
        table.insert( BOREAS_GLOWERS, ents.FindByClass( "st_visitorlog" )[ 1 ] )
        table.insert( BOREAS_GLOWERS, ents.FindByClass( "st_disguiselocker" )[ 1 ] )
        table.insert( BOREAS_GLOWERS, game.GetWorld():GetNWEntity( "RocketHatch" ) )
    end

    -- dumb hack because of networking problems
    if GetRoundState() == ROUND.ACTIVE and not IsValid( BOREAS_GLOWERS[ #BOREAS_GLOWERS ] ) then
        BOREAS_GLOWERS[ #BOREAS_GLOWERS ] = game.GetWorld():GetNWEntity( "RocketHatch" )
    end

    if GetRoundState() ~= ROUND.ACTIVE and #BOREAS_EXTRACTS ~= 0 then
        BOREAS_EXTRACTS = {}
        BOREAS_GLOWERS = {}
    end
end )

hook.Add( "HUDPaint", "InfilVision.Objectives", function()
    cam.Start3D()
        if LocalPlayer():Team() == TEAM_INFIL and LocalPlayer():KeyDown( IN_ZOOM ) then
            
            for i, ent in ipairs( BOREAS_GLOWERS ) do
                if IsValid( ent ) and ( ( ent.GetCompleted and not ent:GetCompleted() ) or not ent.GetCompleted ) then
                    render.SetColorModulation( 0, 5, ent.Optional and 5 or 0 )
                    ent:DrawModel()

                    --[[
                    surface.SetFont( "DebugOverlay" )
                    surface.SetTextColor( 255, 255, 255, 255 )
                    local txt = ent:MapCreationID() == -1 and ent.PrintName or "Rocket Hatch"
                    local p = ent:GetPos():ToScreen()
                    surface.SetTextPos( p.x - surface.GetTextSize( txt ) / 2, p.y )
                    surface.DrawText( txt )
                    ]]--
                end
            end

            for i, ent in ipairs( BOREAS_EXTRACTS ) do
    
                if IsValid( ent ) then ent:DrawModel() end
                    local light = 1
                    render.SuppressEngineLighting( true )
                    render.SetModelLighting( BOX_TOP, light, light, light )
                    render.SetModelLighting( BOX_FRONT, light, light, light )
                    render.SetModelLighting( BOX_RIGHT, light, light, light )
                    render.SetModelLighting( BOX_LEFT, light, light, light )
                    render.SetModelLighting( BOX_BACK, light, light, light )
                    render.SetModelLighting( BOX_BOTTOM, light, light, light )
                    render.SetColorModulation( 5, 0, 0 )
                    ent:DrawModel()
                    render.SuppressEngineLighting( false )
                    
                    --[[
                    if i ~= 1 then
                        surface.SetFont( "DebugOverlay" )
                        surface.SetTextColor( 255, 255, 255, 255 )
                        local txt = ent:MapCreationID() == -1 and ent.PrintName or "Exfiltration Door"
                        local p = ent:GetPos():ToScreen()
                        surface.SetTextPos( p.x - surface.GetTextSize( txt ) / 2, p.y )
                        surface.DrawText( txt )
                    end
                    ]]--
                end

        end
	cam.End3D()
end )

hook.Add( "RenderScreenspaceEffects", "InfilVision.ColorMod", function()

    if LocalPlayer():Team() == TEAM_INFIL and LocalPlayer():KeyDown( IN_ZOOM ) then
        local baseFOV = GetConVar( "fov_desired" ):GetFloat()

        local mult = math.Clamp( LocalPlayer():GetFOV() / baseFOV, 0, 1 )

        DrawColorModify( {
            [ "$pp_colour_addr" ] = 0,
            [ "$pp_colour_addg" ] = 0,
            [ "$pp_colour_addb" ] = 0,
            [ "$pp_colour_brightness" ] = 0,
            [ "$pp_colour_contrast" ] = 1,
            [ "$pp_colour_colour" ] = mult,
            [ "$pp_colour_mulr" ] = 0,
            [ "$pp_colour_mulg" ] = 0,
            [ "$pp_colour_mulb" ] = 0
        } )
    end
end )