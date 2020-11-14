//
//  UIButtonExtension.swift
//  101group
//
//  Created by Max Petrenko on 01.12.17.
//  Copyright © 2017 101 GROUP. All rights reserved.
//

import UIKit

public extension UIButton {
    func setGradient(isActive: Bool, colors: [UIColor]) {
        if isActive {
            setGradient(colors: colors, locations: [0, 1])
        } else {
            layer.sublayers?.first(where: { $0 is CAGradientLayer })?.removeFromSuperlayer()
        }
    }

//    func setTitle(_ title: String, subtitle: String? = nil, style: BottomButton.Style = .filled, titleColor: UIColor? = nil, font: UIFont? = nil, subtitleColor: UIColor? = nil) {
//        let font = font ?? .grpSemi17
//        let titleColor: UIColor = titleColor ?? (style != .filled && style != .filledRound ? .grpDynamicAccent : .grpWhite)
//        let title: String = (subtitle == nil) ? title : title + "\n" + (subtitle ?? "")
//        let btnTitle: NSMutableAttributedString = title.attributed([.font: font, .foregroundColor: titleColor])
//        let btnTitleHighlighted: NSMutableAttributedString = title.attributed([.font: font, .foregroundColor: titleColor.withAlphaComponent(0.5)])
//        let btnTitleDisabled: NSMutableAttributedString = title.attributed([.font: font, .foregroundColor: titleColor.withAlphaComponent(0.7)])
//
//        if let subtitle = subtitle, let subtitleColor = subtitleColor {
//            btnTitle.setAttributes([.font: UIFont.grp11, .foregroundColor: subtitleColor], for: NLS(subtitle))
//            btnTitleHighlighted.setAttributes([.font: UIFont.grp11, .foregroundColor: subtitleColor.withAlphaComponent(0.5)], for: NLS(subtitle))
//            btnTitleDisabled.setAttributes([.font: UIFont.grp11, .foregroundColor: subtitleColor.withAlphaComponent(0.7)], for: NLS(subtitle))
//        }
//        setAttributedTitle(btnTitle, for: .normal)
//        setAttributedTitle(btnTitleHighlighted, for: .highlighted)
//        setAttributedTitle(btnTitleDisabled, for: .disabled)
//    }

	func showActivityIndicator(color: UIColor = .white) {
		isEnabled = false
        var style: UIActivityIndicatorView.Style!

        if #available(iOS 13.0, *) {
            style = .medium
        } else {
            style = .white
        }
		let indicator = UIActivityIndicatorView(style: style)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.color = color
		indicator.tag = 987
		indicator.startAnimating()
		addSubview(indicator)
		var constraints = [NSLayoutConstraint]()
		constraints.append(NSLayoutConstraint(item: indicator, attribute: .centerX, relatedBy: .equal,
											  toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		constraints.append(NSLayoutConstraint(item: indicator, attribute: .centerY, relatedBy: .equal,
											  toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
		NSLayoutConstraint.activate(constraints)
	}

	func reset() {
		for sv in subviews where 987 == sv.tag {
			sv.removeFromSuperview()
		}
		isEnabled = true
    }
}
