AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName= "Camera"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Infiltrator"

if SERVER then
    function ENT:Initialize()
    
        self:SetModel( "models/props/cs_assault/camera.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then phys:Wake() end
        self:SetUseType(SIMPLE_USE)

        self:SetNWBool( "Enabled", true )
    end

    function ENT:OnTakeDamage()
        self:EmitSound( "npc/roller/mine/rmine_shockvehicle" .. math.random( 1, 2 ) .. ".wav" )
        self:SetNWBool( "Enabled", false )
        timer.Create( "camonline" .. self:EntIndex(), 10, 1, function()
            if not IsValid( self ) then return end
            self:EmitSound( "npc/roller/remote_yes.wav" )
            self:SetNWBool( "Enabled", true )
        end )
    end

    function ENT:UpdateTransmitState()        
        return TRANSMIT_ALWAYS
    end
end

if CLIENT then
    local lightMat = Material( "sprites/light_glow02_add" )

    function ENT:Draw()
        self:DrawModel()

        local a = 255
        local drawColor = Color( 0, 255, 0, 255 )

        if self:GetNWInt( "Watchers", 0 ) > 0 then
            a = math.floor( 0.5 * math.cos( CurTime() * 4 ) + 1 ) * 255
        end

        if self:GetNWBool( "Enabled", true ) then
            drawColor = Color( 0, 255, 0, a )
        else
            drawColor = Color( 255, 0, 0, a )
        end

        if a == 255 then
            render.SetMaterial( lightMat )
            render.DrawSprite( self:GetPos() - ( self:GetRight() * 35 ) + ( self:GetForward() * 11 ) - ( self:GetUp() * 8 ), 4, 4, drawColor )
        end
    end
end