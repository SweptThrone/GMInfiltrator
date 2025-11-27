net.Receive( "Infil.TeamKrilla", function()
    local griefer = net.ReadPlayer()

    Derma_Query( griefer:Name() .. " has been detected as being majorly disruptive.  Would you like to kick them?", "TeamKrilla", "Kick", function() net.Start( "Infil.TeamKrilla" ) net.WritePlayer( griefer ) net.SendToServer() end, "Forgive", function() end )
end )