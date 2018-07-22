local _, ns = ...

local m = {}
local mediaPath = "Interface\\media\\"
ns.m = m

-- -----------------------------------
-- > MEDIA
-- -----------------------------------

m.fonts = {
  font = mediaPath.."Asap-Bold.ttf",
  font_big = mediaPath.."ROADWAY.ttf",
  symbols = "Interface\\AddOns\\oUF_lumen\\media\\symbols.otf",
  symbols_light = "Interface\\AddOns\\oUF_lumen\\media\\symbols_light.otf",
}

m.textures = {
  status_texture = "Interface\\AddOns\\oUF_lumen\\media\\statusbar",
  fill_texture = "Interface\\AddOns\\oUF_lumen\\media\\texture",
  bg_texture = "Interface\\AddOns\\oUF_lumen\\media\\texture_bg",
  border = "Interface\\AddOns\\oUF_lumen\\media\\border",
  white_square = "Interface\\AddOns\\oUF_lumen\\media\\white",
  glow_texture = "Interface\\AddOns\\oUF_lumen\\media\\glow",
}
