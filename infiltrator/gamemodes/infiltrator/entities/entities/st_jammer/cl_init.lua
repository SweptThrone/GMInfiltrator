include('shared.lua')

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