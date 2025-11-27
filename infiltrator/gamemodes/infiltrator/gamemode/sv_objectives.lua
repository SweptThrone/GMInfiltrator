BOREAS_OBJECTIVES = {
	[ "files" ] = false,
	[ "log" ] = false,
	[ "pressure" ] = false,
	[ "shipment" ] = false,
	[ "notes" ] = false,
	[ "rocket" ] = false,
	[ "jammer" ] = false
}

OBJ_LUT = {
	files = 1,
	log = 2,
	pressure = 4,
	shipment = 8,
	notes = 16,
	rocket = 32,
	jammer = 64
}

function UpdateObjectives( obj, stat )

	BOREAS_OBJECTIVES[ obj ] = stat
	game.GetWorld():SetNWInt( "Objectives", bit.bor( game.GetWorld():GetNWInt( "Objectives", 0 ), OBJ_LUT[ obj ] ) )

	if BOREAS_OBJECTIVES[ "files" ] and BOREAS_OBJECTIVES[ "log" ] and BOREAS_OBJECTIVES[ "pressure" ]
		and BOREAS_OBJECTIVES[ "shipment" ] and BOREAS_OBJECTIVES[ "notes" ] and BOREAS_OBJECTIVES[ "rocket" ] then

		for k,v in pairs( team.GetPlayers( TEAM_INFIL ) ) do
            v:InfilMsg( "You have completed all of the objectives.  You must now extract." )
        end

	end

end

hook.Add( "PlayerUse", "DeleteHatchOnE", function( ply, ent )

	if ent:MapCreationID() == 1854 and ply:KeyPressed( IN_USE ) then
		if ply:Team() == TEAM_INFIL then
			ply:InfilMsg( "You successfully sabotaged the rocket." )
			ent:EmitSound( "npc/assassin/ball_zap1.wav" )
			UpdateObjectives( "rocket", true )
			ent:Remove()
		else
			ply:InfilMsg( "This is an access point to the rocket." )
		end
	end

	if ( ent:MapCreationID() == 4857 or ent:MapCreationID() == 4858 ) and ply:KeyPressed( IN_USE ) then
		if ply:Team() == TEAM_INFIL then
			if BOREAS_OBJECTIVES[ "files" ] and BOREAS_OBJECTIVES[ "log" ] and BOREAS_OBJECTIVES[ "pressure" ]
			and BOREAS_OBJECTIVES[ "shipment" ] and BOREAS_OBJECTIVES[ "notes" ] and BOREAS_OBJECTIVES[ "rocket" ] then
				ply:Exfiltrate()
			else
				ply:InfilMsg( "You have not completed all of the objectives yet." )
			end
		else
			ply:InfilMsg( "You shouldn't leave the facility grounds!" )	
		end
	end

end )

hook.Add( "AcceptInput", "BroadcastDoors", function( ent, inputName )
	if inputName == "Toggle" and ent:GetName():find( "Door" ) and ent:GetClass() == "info_target" then
		for k,v in pairs( team.GetPlayers( TEAM_GUARD ) ) do
			if player_manager.GetPlayerClass( v ) == "guard_officer" then
				v:ChatPrint( "Received signal from " .. ent:GetName():sub( 1, ent:GetName():find( "LightingOrigin" ) - 1 ) )
			end
		end
	end
end )

local objectiveSpawns = {
	{ ent = "st_xfilvan", pos = Vector( "-15122.690430 -15540.402344 -8190.750000" ), ang = Angle( "-0.000 158.602 -0.012" ) },
	{ ent = "st_xfilvan", pos = Vector( "-8532.242188 -15597.031250 -10494.753906" ), ang = Angle( "0.009 -173.012 0.031" ) },

	{ ent = "st_jammableserver", spawns = {
        { pos = Vector( "-13746.753906 -6964.213379 -7900.507812" ), ang = Angle( "0 0 0" ) },
        { pos = Vector( "-13592.138672 -7106.364258 -7900.355957" ), ang = Angle( "0 180 0" ) }
    } },
	{ ent = "st_jammer", spawns = {
        { pos = Vector( "456.974396 -14523.865234 -6534.535645" ), ang = Angle( "-0.946 4.354 -0.440" ) },
        { pos = Vector( "803.822876 -14303.373047 -6516.177734" ), ang = Angle( "0.175 3.579 -0.024" ) },
        { pos = Vector( "1185.811523 -14295.099609 -6536.147949" ), ang = Angle( "-0.486 14.547 -0.135" ) },
        { pos = Vector( "895.927002 -14693.936523 -6536.186035" ), ang = Angle( "-0.570 94.180 -0.263" ) },
        { pos = Vector( "598.450500 -15140.766602 -6518.794922" ), ang = Angle( "-0.344 59.478 0.006" ) },
        { pos = Vector( "1666.758789 -15263.571289 -6518.803711" ), ang = Angle( "-0.340 68.438 0.006" ) },
        { pos = Vector( "1703.186646 -14900.090820 -6524.304688" ), ang = Angle( "-0.441 -34.652 -0.065" ) }
    } },
	{ ent = "st_visitorlog", spawns = {
        { pos = Vector( "-318.651337 610.035400 -6267.521973" ), ang = Angle( "-0.090 155.695 -0.040" ) },
        { pos = Vector( "-341.571747 743.684387 -6233.849609" ), ang = Angle( "0.026 12.731 -0.052" ) },
        { pos = Vector( "-571.006287 669.881226 -6303.528809" ), ang = Angle( "-0.103 -25.174 -0.432" ) }
    } },
	{ ent = "st_pressurevalve", pos = Vector( "742.045959 1231.965698 -6397.242676" ), ang = Angle( "45.000 -90.000 90.000" ) },
	{ ent = "st_researchnotes", spawns = {
        { pos = Vector( "2454.760254 5974.288086 -6575.040527" ), ang = Angle( "-0.068 -105.217 0.104" ) },
        { pos = Vector( "3797.135742 5789.345215 -6601.927734" ), ang = Angle( "3.781 -150.262 -1.253" ) },
        { pos = Vector( "3868.398926 3706.026367 -6221.771484" ), ang = Angle( "-2.488 65.932 -4.482" ) },
        { pos = Vector( "2485.486328 5388.701660 -6597.997559" ), ang = Angle( "4.926 81.218 -0.572" ) },
        { pos = Vector( "2680.315674 5024.423828 -6590.282715" ), ang = Angle( "4.367 114.875 1.953" ) }
    } },
	{ ent = "st_shipment", spawns = {
        { pos = Vector( "108.863838 3583.303955 -6375.515137" ), ang = Angle( "0.013 79.181 -0.011" ) },
        { pos = Vector( "-128.600449 3263.531006 -6315.560059" ), ang = Angle( "0.030 -179.074 0.055" ) },
        { pos = Vector( "-471.199005 3259.188721 -6375.041016" ), ang = Angle( "1.224 85.447 -0.041" ) },
        { pos = Vector( "-748.687622 3810.641846 -6315.647949" ), ang = Angle( "-0.030 -91.144 0.001" ) }
    } },
	{ ent = "st_serverbox", pos = Vector( "2717.022705 2360.627686 -6380.542969" ), ang = Angle( "-7.984 84.543 -0.702" ) },

	{ ent = "infil_camera_ctrl", pos = Vector( "509.367371 4125.315918 -6366.590820" ), ang = Angle( "-10.429 86.270 -0.031" ) },
	{ ent = "st_camerabox", pos = Vector( "419.307770 4249.894043 -6330.763184" ), ang = Angle( 0, 0, 0 ) },

	{ ent = "st_disguiselocker", pos = Vector( "-8473.752930 -8414.023438 -10275.544922" ), ang = Angle( "0.000 -180.000 0.000" ) }

	-- chair 2755.482422 2362.530273 -6379.577637	0.026 166.284 0.019
	-- keeb 2732.935547 2353.582520 -6400.231934	-10.826 -177.688 0.243

}

local function setupBoreas()
	for k,v in pairs( ents.GetAll() ) do
		c = v:GetClass()
		if c == "item_healthkit" 
		or c == "item_ammo_smg1" 
		or c == "item_item_crate" 
		or c == "item_box_buckshot" 
		or c == "item_ammo_pistol" 
		or c == "weapon_shotgun" 
		or c == "weapon_smg1" 
		or c == "weapon_pistol" 
		then
			v:Remove()
		end
	end

	for k,v in pairs( ents.FindByClass( "item_ammo_crate" ) ) do
		local pos = v:GetPos()
		local ang = v:GetAngles()

		v:Remove()

		local newBox = ents.Create( "item_ammo_crate" )
		newBox:SetKeyValue( "AmmoType", 2 )
		newBox:SetSaveValue( "AmmoType", 2 )
		newBox:SetModel( "models/items/ammocrate_ar2.mdl" )
		newBox:SetPos( pos )
		newBox:SetAngles( ang )
		newBox:DrawShadow( false )
		newBox:Spawn()
	end

	BOREAS_OBJECTIVES = {
		[ "files" ] = false, -- 1
		[ "log" ] = false, -- 2
		[ "pressure" ] = false, -- 4
		[ "shipment" ] = false, -- 8
		[ "notes" ] = false, -- 16
		[ "rocket" ] = false, -- 32
		[ "jammer" ] = false
	}
	game.GetWorld():SetNWInt( "Objectives", 0 )

	local serverChair = ents.Create( "prop_physics" )
	serverChair:SetModel( "models/props_wasteland/controlroom_chair001a.mdl" )
	serverChair:SetPos( Vector( "2714.470459 2352.115723 -6379.582031" ) )
	serverChair:SetAngles( Angle( "-0.033 82.084 0.004" ) )
	serverChair:Spawn()
	serverChair:GetPhysicsObject():EnableMotion( false )

	local serverKeeb = ents.Create( "prop_physics" )
	serverKeeb:SetModel( "models/props_c17/computer01_keyboard.mdl" )
	serverKeeb:SetPos( Vector( "2700.939453 2369.966797 -6400.242676" ) )
	serverKeeb:SetAngles( Angle( "-10.006 108.236 -0.001" ) )
	serverKeeb:Spawn()
	serverKeeb:GetPhysicsObject():EnableMotion( false )

	for k, v in pairs( objectiveSpawns ) do
		local obj = ents.Create( v.ent )
        if v.pos then
            obj:SetPos( v.pos )
            obj:SetAngles( v.ang )
        else
            obj:SetPos( v.spawns[ math.random( 1, #v.spawns ) ].pos )
            obj:SetAngles( v.spawns[ math.random( 1, #v.spawns ) ].ang )
        end
		obj:Spawn()
		obj:GetPhysicsObject():EnableMotion( false )
	end

end

hook.Add( "PostCleanupMap", "StartupBoreasMap", setupBoreas )

hook.Add( "InitPostEntity", "CleanEnts", setupBoreas )

local infilPoints = {
    tunnel = { pos = Vector( "13363.000000 15327.549805 544.031250" ), ang = Angle( "-1.056021 -135.435730 0.000000" ) },
    zethes = { pos = Vector( "-8816.458984 -14959.749023 -10427.129883" ), ang = Angle( "4.871998 89.972496 0.000000" ) },
    path = { pos = Vector( "-14885.549805 -15301.898438 -8127.968750" ), ang = Angle( "3.815994 71.668510 0.000000" ) }
}

function GM:PlayerCanHearPlayersVoice( listener, speaker )
	if G_MUTE then return false, false end
	if GetRoundState() == ROUND.PREPARING or GetRoundState() == ROUND.ENDING then return true, false end
	if listener:Team() == TEAM_SPECTATOR then return true, false end
	if speaker:Team() == TEAM_SPECTATOR then return false, false end
	if not speaker:Alive() then return false, false end
	if listener:Team() == speaker:Team() then return true, false end
	if listener:Team() == TEAM_INFIL and BOREAS_OBJECTIVES[ "jammer" ] then return true, false end
	return true, true
end

function GM:PlayerCanSeePlayersChat( txt, bTeam, listener, speaker )
	if GetRoundState() == ROUND.PREPARING or GetRoundState() == ROUND.ENDING then return true end
	if listener:Team() == TEAM_SPECTATOR then return true end
	if speaker:Team() == TEAM_SPECTATOR then return false end
	if not speaker:Alive() then return false end
	if not bTeam then return true end
end

function DebugVoiceIssue( listener, speaker )
	if G_MUTE then
		print( listener:Name() .. " can NOT hear " .. speaker:Name() .. " because of G_MUTE" )
		return
	end
	if GetRoundState() == ROUND.PREPARING or GetRoundState() == ROUND.ENDING then
		print( listener:Name() .. " CAN hear " .. speaker:Name() .. " because of round state" )
		return
	end
	if listener:Team() == TEAM_SPECTATOR then 
		print( listener:Name() .. " CAN hear " .. speaker:Name() .. " because " .. listener:Name() .. " is a spectator" )
		return
	end
	if speaker:Team() == TEAM_SPECTATOR then 
		print( listener:Name() .. " can NOT hear " .. speaker:Name() .. " because " .. speaker:Name() .. " is a spectator" )
		return
	end
	if not speaker:Alive() then
		print( listener:Name() .. " can NOT hear " .. speaker:Name() .. " because " .. speaker:Name() .. " is dead" )
		return
	end
	if listener:Team() == speaker:Team() then
		print( listener:Name() .. " CAN hear " .. speaker:Name() .. " because they are on the same team" )
		return
	end
	if listener:Team() == TEAM_INFIL and BOREAS_OBJECTIVES[ "jammer" ] then
		print( listener:Name() .. " CAN hear " .. speaker:Name() .. " because the jammer is in place" )
		return
	end
	
	print( listener:Name() .. " CAN hear " .. speaker:Name() .. " IN 3D" )
	return
end

hook.Add( "PlayerSay", "Infil.RouteTeamChatToJammer", function( ply, txt, bTeam )
	if ply:Team() == TEAM_GUARD and bTeam and BOREAS_OBJECTIVES.jammer then
		team.GetPlayers( TEAM_INFIL )[ 1 ]:ChatPrint( "(TEAM) " .. ply:Name() .. ": " .. txt )
	end
end )