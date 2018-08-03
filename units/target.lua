local _, ns = ...

local lum, core, cfg, m, oUF = ns.lum, ns.core, ns.cfg, ns.m, ns.oUF
local auras, filters = ns.auras, ns.filters

local font = m.fonts.font
local font_big = m.fonts.font_big

local frame = "target"

-- ------------------------------------------------------------------------
-- > TARGET UNIT SPECIFIC FUNCTiONS
-- ------------------------------------------------------------------------

-- Post Health Update
local PostUpdateHealth = function(health, unit, min, max)
  local self = health.__owner
  local width = 1.2 * self.Name:GetStringWidth()
  local reaction = UnitReaction(self.unit, "PLAYER")

  self.Health:SetAlpha(1)
  self:SetWidth(width)
  self.Health:SetWidth(width)
  self.Power.value:SetPoint("BOTTOMLEFT", self.Health.percent, "BOTTOMRIGHT", 0, 4)

  if cfg.units[frame].health.gradientColored then
    local r, g, b = oUF.ColorGradient(min, max, 1,0,0, 1,1,0, unpack(core:raidColor(unit)))
    health:SetStatusBarColor(r, g, b)
  end

  -- Horde/Alliance/Neutral Healthbar
  if UnitIsPlayer(self.unit) then
    self.Health:SetStatusBarColor(unpack(ns.oUF.colors.reaction[reaction]))
  else
    self.Health:SetStatusBarColor(1, 1, 1, 1)
  end

  -- Class colored text
  if cfg.units[frame].health.classColoredText then
    if not UnitIsPlayer(self.unit) then
      self.Name:SetTextColor(unpack(ns.oUF.colors.reaction[reaction]))
      self.Health.percent:SetTextColor(unpack(ns.oUF.colors.reaction[reaction]))
    else
      self.Name:SetTextColor(unpack(core:raidColor(unit)))
      if reaction >= 5 then
        self.Health.percent:SetTextColor(unpack(core:raidColor(unit)))
      else
        self.Health.percent:SetTextColor(unpack(ns.oUF.colors.reaction[reaction]))
      end
    end
  end

end

-- -----------------------------------
-- > TARGET STYLE
-- -----------------------------------

local createStyle = function(self)
  self.mystyle = frame
  self.cfg = cfg.units[frame]

  lum:globalStyle(self, "main")

  -- Texts
  core:createNameString(self, font_big, cfg.fontsize + 20, "THICKOUTLINE", 0, -4, "CENTER", self.cfg.width * 3)
  self:Tag(self.Name, '[lumen:name]')
  core:createHPPercentString(self, font_big, cfg.fontsize + 30, "THICKOUTLINE", 100, 171, "LEFT")
  self:Tag(self.Health.percent, '[lumen:hpperc]')
  core:createPowerString(self, font, cfg.fontsize + 16, "THICKOUTLINE", 0, 0, "CENTER")
  self.Power.value:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)

  -- Health & Power Updates
  self.Health.PostUpdate = PostUpdateHealth

  -- Castbar
    if self.cfg.castbar.enable then
      core:CreateCastbar(self)
    end


  -- Raid Icons
  local RaidIcon = self:CreateTexture(nil, 'OVERLAY')
  RaidIcon:SetPoint('BOTTOMLEFT', self.Health.percent, 'BOTTOMRIGHT', 8, 9)
  RaidIcon:SetSize(20, 20)
  self.RaidTargetIndicator = RaidIcon

  -- Heal Prediction
  CreateHealPrediction(self)
end

-- -----------------------------------
-- > SPAWN UNIT
-- -----------------------------------
if cfg.units[frame].show then
  oUF:RegisterStyle("oUF_Lumen:"..frame:gsub("^%l", string.upper), createStyle)
  oUF:SetActiveStyle("oUF_Lumen:"..frame:gsub("^%l", string.upper))
  oUF:Spawn(frame, "oUF_Lumen"..frame:gsub("^%l", string.upper))
end
