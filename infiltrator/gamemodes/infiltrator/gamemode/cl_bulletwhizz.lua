local nearmiss = {
    ")weapons/fx/nearmiss/bulletltor03.wav",
    ")weapons/fx/nearmiss/bulletltor04.wav",
    ")weapons/fx/nearmiss/bulletltor05.wav",
    ")weapons/fx/nearmiss/bulletltor06.wav",
    ")weapons/fx/nearmiss/bulletltor07.wav",
    ")weapons/fx/nearmiss/bulletltor09.wav",
    ")weapons/fx/nearmiss/bulletltor10.wav",
    ")weapons/fx/nearmiss/bulletltor11.wav",
    ")weapons/fx/nearmiss/bulletltor12.wav",
    ")weapons/fx/nearmiss/bulletltor13.wav",
    ")weapons/fx/nearmiss/bulletltor14.wav",
}

net.Receive( "stcrack", function()
    local a = net.ReadVector()
    local b = net.ReadVector()
    local ply = net.ReadPlayer()

    local dist, point = util.DistanceToLine( a, b, LocalPlayer():EyePos() )
    if dist < 100 and ply ~= LocalPlayer() then
        sound.Play( nearmiss[ math.random( 1, #nearmiss ) ], point, 75, 100, 1 )
    end
end )