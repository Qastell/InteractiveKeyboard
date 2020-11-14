//
//  UITextFieldExtension.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 12/07/2019.
//  Copyright © 2019 Yuri Kudrinetskiy. All rights reserved.
//

import UIKit

extension UIToolbar {
	convenience init(rightButton: UIBarButtonItem) {
		self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		items = [spacer, rightButton]
		backgroundColor = .grpPaleGrey
		isTranslucent = false
		sizeToFit()
	}
}

extension UITextView {
	func setInputAccessoryView(done: UIBarButtonItem) {
        inputAccessoryView = UIToolbar(rightButton: done)
	}
}

extension UITextField {
	func setDoneAccessoryView(_ done: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)) {
        let toolbar = UIToolbar(rightButton: done)
        done.action = done.action ?? #selector(resign)
        done.tintColor = .grpBlue
		inputAccessoryView = toolbar
	}

	@objc private func resign() {
		resignFirstResponder()
	}

//	func setData(l10nKey: String) {
//        attributedPlaceholder = l10nKey.localized.firstUppercased.attributed(Settings.shared.attrs17Steel)
//		font = .grp17
//	}
}
