AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Hot Meal"
ENT.Author = "SweptThrone"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "STuff"

local HEALTH_PER_SERVING = 20

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/sweptthrone/hotmeal_bg.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then phys:Wake() end
		self:SetUseType( SIMPLE_USE )

		self.FoodLeft = 2
	end
	
	function ENT:Use( act, ply )
		if self.FoodLeft > 0 and ply:Health() < ply:GetMaxHealth() then
			self:SetBodygroup( 4 - self.FoodLeft, 1 )
			ply:EmitSound( "npc/barnacle/barnacle_gulp" .. self.FoodLeft .. ".wav" )
			self.FoodLeft = self.FoodLeft - 1
			ply:SetHealth( math.min( ply:Health() + HEALTH_PER_SERVING, ply:GetMaxHealth() ) )
		end
	end

	function ENT:OnRemove()
	end

	function ENT:Think()
		self:NextThink( CurTime() + 5 )
		return true
	end

end

if CLIENT then
	function ENT:Initialize()
		self.smoke = CreateParticleSystem( self, "smoke_gib_01", PATTACH_ABSORIGIN_FOLLOW, 0, vector_origin )
	end

	function ENT:Think()
		if self:GetBodygroup( 3 ) == 1 and IsValid( self.smoke ) then
			self.smoke:StopEmission( false, false, false )
		end
	end

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