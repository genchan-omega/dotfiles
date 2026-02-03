local wezterm = require "wezterm"
local act = wezterm.action
local config = wezterm.config_builder()

-- すでに monokai-pro を使っているなら残してOK
require("monokai-pro").apply_to_config(config, "spectrum")

-- background
local background = require("local.background")
config.background = { -- レイヤ1: 画像
{
  source = {
    File = background.astral_express
  },
  horizontal_align = "Center",
  repeat_x = "NoRepeat",
  opacity = 1,
  -- 必要なら暗くする:
  -- hsb = {
  --   brightness = 0.15
  -- }
}, -- レイヤ2: 文字を読みやすくする被せ（任意）
{
  source = {
    Gradient = {
      colors = {"#000000cc", "#33337899"},
      orientation = {
        Linear = {
          angle = -30.0
        }
      }
    }
  },
  opacity = 1,
  width = "100%",
  height = "100%"
}}

-- keymap
local keybindings = require("local.keybindings")

return config
