KRILL_TRACKER = {}
KRILL_TRACKER_DMG = {}
KRILL_DMG_THRESHOLDS = {}

util.AddNetworkString( "Infil.TeamKrilla" )

local plyMeta = FindMetaTable( "Player" )
function plyMeta:CalculateKrillaPenalty()
    local kills = KRILL_TRACKER[ self:AccountID() ] or 0
    local dmg = KRILL_TRACKER_DMG[ self:AccountID() ] or 0

    if ( kills >= 3 or dmg >= 250 ) or ( kills * 100 ) + dmg >= 201 then
        return true
    end
    return false
end

hook.Add( "PlayerDeath", "Infil.TeamKrilla", function( vic, _, atk )
    if vic == atk then return end
    if not atk:IsPlayer() then return end
    KRILL_TRACKER[ atk:AccountID() ] = KRILL_TRACKER[ atk:AccountID() ] or 0
    if vic:Team() == atk:Team() and GetRoundState() == ROUND.ACTIVE then
        KRILL_TRACKER[ atk:AccountID() ] = KRILL_TRACKER[ atk:AccountID() ] + 1
        atk:InfilMsg( "You killed a teammate!  Watch your fire!" )
        if atk:CalculateKrillaPenalty() then
            KRILL_DMG_THRESHOLDS[ atk:AccountID() ] = KRILL_TRACKER_DMG[ atk:AccountID() ] - KRILL_TRACKER_DMG[ atk:AccountID() ] % 100
            net.Start( "Infil.TeamKrilla" )
                net.WritePlayer( atk )
            net.Send( vic )
        end
    end
end )

hook.Add( "PostEntityTakeDamage", "Infil.TeamKrillaDamage", function( vic, dmgInfo, wasDamageTaken )
	if vic:IsPlayer() and wasDamageTaken then
        local atk = dmgInfo:GetAttacker()
        if atk:IsPlayer() and atk ~= vic and vic:Team() == atk:Team() and GetRoundState() == ROUND.ACTIVE then
            KRILL_TRACKER_DMG[ atk:AccountID() ] = KRILL_TRACKER_DMG[ atk:AccountID() ] or 0
            KRILL_TRACKER_DMG[ atk:AccountID() ] = KRILL_TRACKER_DMG[ atk:AccountID() ] dmgInfo:GetDamage()
            atk:InfilMsg( "You hit a teammate!  Watch your fire!" )
            if atk:CalculateKrillaPenalty() and KRILL_TRACKER_DMG[ atk:AccountID() ] >= KRILL_TRACKER_DMG[ atk:AccountID() ] + 100 then
                KRILL_DMG_THRESHOLDS[ atk:AccountID() ] = KRILL_TRACKER_DMG[ atk:AccountID() ] - KRILL_TRACKER_DMG[ atk:AccountID() ] % 100
                net.Start( "Infil.TeamKrilla" )
                    net.WritePlayer( atk )
                net.Send( vic )
            end
        end
    end
end )

net.Receive( "Infil.TeamKrilla", function( len, ply )
    local griefer = net.ReadPlayer()

    if griefer:CalculateKrillaPenalty() then
        griefer:Kick( "Too much team damage." )
    end
end )