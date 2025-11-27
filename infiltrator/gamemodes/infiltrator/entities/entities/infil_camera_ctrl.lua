AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName= "Camera Control"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Infiltrator"

if SERVER then
    function ENT:Initialize()
    
        self:SetModel( "models/props_c17/computer01_keyboard.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then phys:Wake() end
        self:SetUseType(SIMPLE_USE)
    end
    
    function ENT:Use( act, ply )
        ply:Freeze( true )
        net.Start( "boreas_cameras" )
            net.WriteBool( true )
            net.WriteUInt( 1, 32 )
            net.WriteUInt( BOREAS_CAMERAS[ 1 ]:EntIndex(), 32 )
        net.Send( ply )
    end

end

if CLIENT then
    function ENT:Draw()
        local light = TimedSin( 0.5, 192, 312, 0 ) / 255
        light = light - 0.33
        
        render.SuppressEngineLighting( true )
        render.SetModelLighting( BOX_TOP, light, light, light )
        render.SetModelLighting( BOX_FRONT, light, light, light )
        render.SetModelLighting( BOX_RIGHT, light, light, light )
        render.SetModelLighting( BOX_LEFT, light, light, light )
        render.SetModelLighting( BOX_BACK, light, light, light )
        render.SetModelLighting( BOX_BOTTOM, light, light, light )
        self:DrawModel()
        render.SuppressEngineLighting( false )
    end
end