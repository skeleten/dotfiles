import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, defaultPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import Data.Monoid
import System.Exit
import System.IO
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal = "kitty"
myEditor = "emacsclient -c -a ''"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth = 3
myModMask = mod4Mask
myWallpaper = "~/Images/wallhaven-lmxmxy.png"

myWorkspaces = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

myNormalBorderColor = "#333333"
myFocusedBorderColor = "#ff7f00"

myKeys conf@(XConfig {XMonad.modMask = myModMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Application launching
  --
  [ ((myModMask,                        xK_d),
      spawn "rofi -show run")
    -- Start a terminal
  , ((myModMask .|. shiftMask,          xK_Return),
    spawn myTerminal)

  , ((myModMask .|. shiftMask,          xK_s),
      spawn myEditor)

  ] ++

  ----------------------------------------------------------------------
  -- Media controls
  --
  [ ((0, xF86XK_AudioMute),
      spawn "pulsemixer --toggle-mute")

  , ((0, xF86XK_AudioLowerVolume),
      spawn "pulsemixer --change-volume -5")

  , ((0, xF86XK_AudioRaiseVolume),
      spawn "pulsemixer --change-volume +5")

  -- Audio PREV
  , ((0, xF86XK_AudioPrev),
      spawn "playerctl previous")

  -- Audio Play/Pause
  , ((0, xF86XK_AudioPlay),
      spawn "playerctl play-pause")

  -- Audio next
  , ((0, xF86XK_AudioNext),
      spawn "playerctl next")

  ----------------------------------------------------------------------
  -- "Standard" bindings
  --

  -- close focused window
  , ((myModMask,                        xK_q),
      kill)

  -- cycle through layouts
  , ((myModMask,                        xK_space),
      sendMessage NextLayout)

  -- Reset layouts to default
  , ((myModMask .|. shiftMask,          xK_space),
      setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size
  , ((myModMask,                        xK_n),

      refresh)

  -- Move focus to next window
  , ((myModMask,                        xK_j),
      windows W.focusDown)

  -- Move focus to the previous window
  , ((myModMask,                        xK_k),
      windows W.focusUp)

  -- Focus the master window
  , ((myModMask,                        xK_m),
      windows W.focusMaster)

  -- Swap focused window and the master window
  , ((myModMask,                        xK_Return),
      windows W.swapMaster)

  -- Swap focused with next window
  , ((myModMask .|. shiftMask,          xK_j),
      windows W.swapDown)

  -- Swap focused with previous window
  , ((myModMask .|. shiftMask,          xK_k),
      windows W.swapUp)

  -- Shrink master area
  , ((myModMask,                        xK_h),
      sendMessage Shrink)

  -- Expand master area
  , ((myModMask,                        xK_l),
      sendMessage Expand)

  -- Push window back into tiling
  , ((myModMask,                        xK_t),
      withFocused $ windows . W.sink)

  -- Increment number of windows in master area
  , ((myModMask,                        xK_comma),
      sendMessage (IncMasterN 1))

  -- Decrement number of master windows
  , ((myModMask,                        xK_period),
      sendMessage (IncMasterN (-1)))

  -- Quit xmonad
  , ((myModMask .|. shiftMask,          xK_q),
      io (exitWith ExitSuccess))

  -- Restart xmonad
  , ((myModMask,                        xK_q),
    restart "xmonad" True)

  ] ++

  -- mod-[1..9]: Switch to workspace N
  -- mod+shift [1..9]: Move client to ws N
  [((m .|. myModMask, k), windows $ f i)
  | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]] ++

  -- mod-{w,e,r} switch to physical screens 1,2 or 3
  -- mod-shift-{w,e,r} move client to screen
  [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
  | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- xmproc0 <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc0"

main = do
  xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc0"
  _ <- spawn "setxkbmap us"
  _ <- spawn ("feh --bg-scale " ++ myWallpaper)
  xmonad $ docks defaultConfig -- desktopConfig
        { terminal = myTerminal
        , modMask = myModMask
        , borderWidth = myBorderWidth
        , workspaces = myWorkspaces
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor

        -- key bindings
        , keys = myKeys

        -- hooks, layouts
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                    { ppOutput = hPutStrLn xmproc
                    , ppCurrent = xmobarColor "#ff7f00" "" -- . wrap "[" "b]"
                    , ppHiddenNoWindows = xmobarColor "#333333" ""
                    , ppTitle = xmobarColor "green" "" . shorten 40
                    , ppVisible = xmobarColor "#aa5500" "" -- wrap "(" ")"
                    , ppUrgent = xmobarColor "red" "yellow"
                    }
        }
