//
//  UIColorExtension.swift
//  101group
//
//  Created by Max Petrenko on 28.11.17.
//  Copyright © 2017 101 GROUP. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(hex: String) {
        var hex: String = hex.uppercased()

		if hex.hasPrefix("#") {
			hex.remove(at: hex.startIndex)
		}
		if hex.count != 6 {
			self.init(white: 0.5, alpha: 1.0)
            return
		}

        var rgbValue: UInt64 = 0
		Scanner(string: hex).scanHexInt64(&rgbValue)
        let r: CGFloat = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let g: CGFloat = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let b: CGFloat = CGFloat((rgbValue & 0x0000FF)) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
	}
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
