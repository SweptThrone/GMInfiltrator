if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "Binocular Aim"
ATTACHMENT.ShortName = "Aim"
ATTACHMENT.Description = { Color( 192, 192, 192, 255 ), "Keep both eyes open while aiming to increase awareness.",
                        TFA.Attachments.Colors[ "+" ], "No vignette while aiming.",
                        Color( 192, 192, 192, 255 ), "No zoom while aiming." }
ATTACHMENT.Icon = "icon16/eye.png"

ATTACHMENT.WeaponTable = {
    [ "Secondary.IronFOV" ] = 100,
}

if not TFA_ATTACHMENT_ISUPDATING then
    TFAUpdateAttachments()
end