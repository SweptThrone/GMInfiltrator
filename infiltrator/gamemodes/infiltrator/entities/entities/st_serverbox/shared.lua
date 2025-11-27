ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName= "Server Computer"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "The Boreas Raid"

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", "Completed" )

    self:SetCompleted( false )
end