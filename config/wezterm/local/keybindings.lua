local wezterm = require("wezterm")
local act = wezterm.action

return { -- 分割：左右 / 上下
{
  key = "\\",
  mods = "CTRL|ALT",
  action = act.SplitHorizontal {
    domain = "CurrentPaneDomain"
  }
}, -- 右に分割
{
  key = "-",
  mods = "CTRL|ALT",
  action = act.SplitVertical {
    domain = "CurrentPaneDomain"
  }
}, -- 下に分割
-- ペイン移動：vim風 hjkl
{
  key = "LeftArrow",
  mods = "CMD|ALT",
  action = act.ActivatePaneDirection "Left"
}, {
  key = "DownArrow",
  mods = "CMD|ALT",
  action = act.ActivatePaneDirection "Down"
}, {
  key = "UpArrow",
  mods = "CMD|ALT",
  action = act.ActivatePaneDirection "Up"
}, {
  key = "RightArrow",
  mods = "CMD|ALT",
  action = act.ActivatePaneDirection "Right"
}, -- リサイズ：Ctrl+Alt+Shift + hjkl（1ステップずつ）
{
  key = "h",
  mods = "CTRL|ALT|SHIFT",
  action = act.AdjustPaneSize {"Left", 5}
}, {
  key = "j",
  mods = "CTRL|ALT|SHIFT",
  action = act.AdjustPaneSize {"Down", 5}
}, {
  key = "k",
  mods = "CTRL|ALT|SHIFT",
  action = act.AdjustPaneSize {"Up", 5}
}, {
  key = "l",
  mods = "CTRL|ALT|SHIFT",
  action = act.AdjustPaneSize {"Right", 5}
}, -- 便利：ペインを閉じる / 最大化トグル
{
  key = "w",
  mods = "CMD|ALT",
  action = act.CloseCurrentPane {
    confirm = false
  }
}, {
  key = "w",
  mods = "CMD",
  action = act.CloseCurrentTab {
    confirm = false
  }
}, {
  key = "z",
  mods = "CMD|ALT",
  action = act.TogglePaneZoomState
}}
