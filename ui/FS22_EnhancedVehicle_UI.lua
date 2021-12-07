--
-- Mod: FS22_EnhancedVehicle_UI
--
-- Author: Majo76
-- email: ls22@dark-world.de
-- @Date: 05.12.2021
-- @Version: 1.0.0.0

local myName = "FS22_EnhancedVehicle_UI"

FS22_EnhancedVehicle_UI = {}
local FS22_EnhancedVehicle_UI_mt = Class(FS22_EnhancedVehicle_UI, ScreenElement)

-- these items are referenced in the XML
FS22_EnhancedVehicle_UI.CONTROLS = {
  "yesButton",
  "noButton",

  "guiTitle",

  "sectionGlobalFunctions",
  "sectionHUD",
  "sectionSnapSettings",

  "resetConfigButton",
  "resetConfigTitle",
  "resetConfigTT",

  "reloadConfigButton",
  "reloadConfigTitle",
  "reloadConfigTT",

  "snapSettingsAngle",
  "snapSettingsAngleTitle",
  "snapSettingsAngleTT",
  "snapSettingsAngleValue",
  "snapSettingsAngleButtonLeft",
  "snapSettingsAngleButtonRight",

  "HUDdmgAmountLeftSetting",
  "HUDdmgAmountLeftTitle",
  "HUDdmgAmountLeftTT",
}

local EV_elements_global = { 'snap', 'diff', 'hydraulic' }
for _, v in pairs( EV_elements_global ) do
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, v.."Setting")
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, v.."Title")
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, v.."TT")
end

local EV_elements_HUD = { 'fuel', 'dmg', 'misc', 'rpm', 'temp', 'diff', 'snap' }
  for _, v in pairs( EV_elements_HUD ) do
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, "HUD"..v.."Setting")
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, "HUD"..v.."Title")
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, "HUD"..v.."TT")
end

-- #############################################################################

function FS22_EnhancedVehicle_UI.new(target, custom_mt)
  if debug > 1 then print("-> " .. myName .. ": new ") end

  local self = DialogElement.new(target, custom_mt or FS22_EnhancedVehicle_UI_mt)

  self:registerControls(FS22_EnhancedVehicle_UI.CONTROLS)
  return self
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:delete()
  if debug > 1 then print("-> " .. myName .. ": delete ") end
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onOpen()
  if debug > 1 then print("-> " .. myName .. ": onOpen ") end

  FS22_EnhancedVehicle_UI:superClass().onOpen(self)

  local modName = "FS22_EnhancedVehicle"

  -- reset & reload config buttons
  self.resetConfigButton:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_resetConfigButton"))
  self.resetConfigTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_resetConfigTitle"))
  self.resetConfigTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_resetConfigTT"))
  self.reloadConfigButton:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_reloadConfigButton"))
  self.reloadConfigTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_reloadConfigTitle"))
  self.reloadConfigTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_reloadConfigTT"))

  -- title
  self.guiTitle:setText("Enhanced Vehicle ".. g_EnhancedVehicle.version .. " by Majo76")

  -- section headers
  self.sectionGlobalFunctions:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_sectionGlobalFunctions"))
  self.sectionHUD:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_sectionHUD"))
  self.sectionSnapSettings:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_sectionSnapSettings"))

  -- global elements
  for _, v in pairs(EV_elements_global) do
    v1 = v.."Title"
    v2 = v.."TT"
    v3 = v.."Setting"
    self[v1]:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_"..v1))
    self[v2]:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_"..v2))
    self[v3]:setTexts({
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_on"),
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_off")
    })
  end

  -- snap to angle
  self.snapSettingsAngleTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_snapSettingsAngleTitle"))
  self.snapSettingsAngleTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_snapSettingsAngleTT"))

  -- HUD elements
  for _, v in pairs(EV_elements_HUD) do
    v1 = "HUD"..v.."Title"
    v2 = "HUD"..v.."TT"
    v3 = "HUD"..v.."Setting"
    self[v1]:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_"..v1))
    self[v2]:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_"..v2))
    self[v3]:setTexts({
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_on"),
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_off")
    })
  end

  -- HUD dmg display mode
  self.HUDdmgAmountLeftTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgAmountLeftTitle"))
  self.HUDdmgAmountLeftTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgAmountLeftTT"))
  self.HUDdmgAmountLeftSetting:setTexts({
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgAmountLeftO1"),
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgAmountLeftO2")
    })

  self:updateValues()
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:updateValues()
  -- global elements
  for _, v in pairs(EV_elements_global) do
    v3 = v.."Setting"
    self[v3]:setState(lC:getConfigValue("global.functions", v.."IsEnabled") and 1 or 2)
  end

  -- HUD elements
  for _, v in pairs(EV_elements_HUD) do
    v3 = "HUD"..v.."Setting"
    self[v3]:setState(lC:getConfigValue("hud."..v, "enabled") and 1 or 2)
  end

  -- snap to angle
  self.snapSettingsAngleValue:setText(tostring(lC:getConfigValue("snap.snapToAngle", "angle")))

  -- HUD dmg display mode
  self.HUDdmgAmountLeftSetting:setState(lC:getConfigValue("hud.dmg", "showAmountLeft") and 1 or 2)
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onClickOk()
  if debug > 1 then print("-> " .. myName .. ": onClickOk ") end

  local state

  -- global functions
  for _, v in pairs(EV_elements_global) do
    v1 = v.."Setting"
    state = self[v1]:getState() == 1
    lC:setConfigValue("global.functions", v.."IsEnabled", state)
  end

  -- HUD
  for _, v in pairs(EV_elements_HUD) do
    v1 = "HUD"..v.."Setting"
    state = self[v1]:getState() == 1
    lC:setConfigValue("hud."..v, "enabled", state)
  end

  -- HUD dmg display modEnvironments
  state = self.HUDdmgAmountLeftSetting:getState() == 1
  lC:setConfigValue("hud.dmg", "showAmountLeft", state)

  -- snapto angle
  local n = tonumber(self.snapSettingsAngleValue:getText())
  if n ~= nil then
    if n <= 0 then n = 1 end
    if n > 90 then n = 90 end
  else
    n = 10
  end
  lC:setConfigValue("snap.snapToAngle", "angle", n)

  -- write and update our config
  lC:writeConfig()
  FS22_EnhancedVehicle:activateConfig()

  -- close screen
  g_gui:closeDialogByName("FS22_EnhancedVehicle_UI")
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onClickBack()
  if debug > 1 then print("-> " .. myName .. ": onClickBack ") end

  -- close screen
  g_gui:closeDialogByName("FS22_EnhancedVehicle_UI")
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onClickResetConfig()
  if debug > 1 then print("-> " .. myName .. ": onClickResetConfig ") end

  FS22_EnhancedVehicle:resetConfig()
  lC:writeConfig()
  FS22_EnhancedVehicle:activateConfig()

  self:updateValues()
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onClickReloadConfig(p1)
  if debug > 1 then print("-> " .. myName .. ": onClickReloadConfig ") end

  lC:readConfig()
  FS22_EnhancedVehicle:activateConfig()

  self:updateValues()
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onTextChanged_SnapAngle(_, text)
  local n = tonumber(text)
  if n ~= nil then
    if n < 0 then n = 10 end
    if n > 90 then n = 90 end
  else
    n = ""
  end

  self.snapSettingsAngleValue:setText(tostring(n))
end
