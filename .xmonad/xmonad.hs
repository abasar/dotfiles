import XMonad
import Xmonad.Config.Desktop

main = xmonad desktopConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    }
