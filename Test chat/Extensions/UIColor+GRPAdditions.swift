//
//  UIColor+Additions.swift
//  101_group
//
//  Generated on Zeplin. (07.05.2018).
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var grpWhite: UIColor {
        return .white
    }

    @nonobjc class var grpWhiteBlack: UIColor {
        return .grpBlackTwo
    }

    @nonobjc class var grpPaleGrey: UIColor {
        return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpPaleGrey2: UIColor {
        return UIColor(red: 230.0 / 255.0, green: 230.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grp90White: UIColor {
        return UIColor(white: 0.9, alpha: 1.0)
    }

    @nonobjc class var grpSeparatorGrey: UIColor {
        return UIColor(white: 212.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpPinkishGrey: UIColor {
        return UIColor(white: 189.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpSteel: UIColor {
        return UIColor(hex: "8A8A8F")
    }

    @nonobjc class var grpBattleshipGrey: UIColor {
        return UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 120.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpDarkGrey: UIColor {
        return UIColor(white: 0.4, alpha: 1)
    }

    @nonobjc class var grpSlateGrey: UIColor {
        return UIColor(hex: "555557")
    }

    @nonobjc class var grpBlackThree: UIColor {
        return UIColor(white: 51.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpGradientGreyTop: UIColor {
        return UIColor(hex: "A5AAB6")
    }

    @nonobjc class var grpGradientGreyBottom: UIColor {
        return UIColor(hex: "868A93")
    }

    @nonobjc class var grpBlackGrey: UIColor {
        return .grpPaleGrey
    }

    @nonobjc class var grpBlackTwo: UIColor {
        return UIColor(white: 42.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpBlackestWhite: UIColor {
        return .grpWhite
    }

    @nonobjc class var grpBlackWhite: UIColor {
        return .grpWhite
    }

    @nonobjc class var grpBlack: UIColor {
        return .black
    }

    @nonobjc class var grpPaleGold: UIColor {
        return UIColor(red: 1.0, green: 214.0 / 255.0, blue: 106.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpPurply: UIColor {
        return UIColor(red: 139.0 / 255.0, green: 61.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpEstimatePurple: UIColor {
        return UIColor(hex: "5E5CE6")
    }

    @nonobjc class var grpDullRed: UIColor {
        return UIColor(red: 200.0 / 255.0, green: 63.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpMaxRed: UIColor {
        return UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
    }

    @nonobjc class var grpRed: UIColor {
        return UIColor(red: 204.0 / 255.0, green: 0, blue: 0, alpha: 1.0)
    }

    @nonobjc class var grpReddish: UIColor {
        return UIColor(red: 190.0 / 255.0, green: 81.0 / 255.0, blue: 74.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var badgeRed: UIColor {
        if #available(iOS 13.0, *) {
            return .systemRed
        } else {
            return UIColor(hex: "FF3B30")
        }
    }

    @nonobjc class var grpDashboardRed: UIColor {
        #if APP_VSEMETRIKA
        return UIColor(hex: "FF3B30")
        #else
        return UIColor(hex: "EB4D3D")
        #endif
    }

    @nonobjc class var grpSuccessGreen: UIColor {
        return UIColor(red: 2.0 / 255.0, green: 184.0 / 255.0, blue: 33.0 / 255.0, alpha: 1)
    }

    @nonobjc class var grpGreen: UIColor {
        return UIColor(hex: "4aa359")
    }

    @nonobjc class var grpFernGreen: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 133.0 / 255.0, blue: 67.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpDashboardGreen: UIColor {
        #if APP_VSEMETRIKA
        return UIColor(hex: "34C759")
        #else
        return UIColor(hex: "76D571")
        #endif
    }

    @nonobjc class var grpFernGreenContractor: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 133.0 / 255.0, blue: 67.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpCoolBlue: UIColor {
        return UIColor(red: 55.0 / 255.0, green: 150.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpRoyalBlue: UIColor {
        return UIColor(red: 47.0 / 255.0, green: 128 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpOrange: UIColor {
        return UIColor(red: 227.0 / 255.0, green: 129.0 / 255.0, blue: 14.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var grpDullOrange: UIColor {
        return UIColor(red: 224.0 / 255.0, green: 139.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
    }

//    @nonobjc public class var grpDynamicAccent: UIColor {
//        switch appBuildType {
//        case .LIHMER:
//            return UIColor(hex: "FFC803")
//        case .Vsemetrika:
//            return UIColor(hex: "CA3338")
//        case ._101Group,
//             .Estimate,
//             .GlavPodryad:
//            return .grpBlue
//        }
//    }

    @nonobjc class var grpWarnOrange: UIColor {
        return UIColor(hex: "FF9F0A")
    }

    @nonobjc class var grpGlavpodryadYellow: UIColor {
        return UIColor(hex: "FFDC4E")
    }

    @nonobjc class var grpTagGray: UIColor {
        return UIColor(hex: "EDF3FB")
    }

    @nonobjc class var grpTagBlue: UIColor {
        return UIColor(hex: "5790DE")
    }

    @nonobjc class var grpTag: UIColor {
        return .grp90White
    }

    @nonobjc class var grpSystemBlueDark: UIColor {
        return UIColor(hex: "0A84FF")
    }

    @nonobjc class var grpBlue: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBlue
        } else {
            return UIColor(hex: "007AFF")
        }
    }
}
