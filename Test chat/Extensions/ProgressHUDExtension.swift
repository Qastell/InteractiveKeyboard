//
//  ProgressHUDExtension.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 10/07/2019.
//  Copyright © 2019 Yuri Kudrinetskiy. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
    static func showDark(containerView: UIView? = nil, offset: UIOffset? = nil) {
        SVProgressHUD.setContainerView(containerView)
		SVProgressHUD.setBackgroundLayerColor(UIColor.grpBlack.withAlphaComponent(0.1))
		SVProgressHUD.setForegroundColor(.grpBlackGrey)
		SVProgressHUD.setBackgroundColor(.clear)
		SVProgressHUD.setDefaultMaskType(.custom)
		SVProgressHUD.setRingThickness(4)
        SVProgressHUD.setRingNoTextRadius(28)
        SVProgressHUD.setOffsetFromCenter(offset ?? .zero)
        SVProgressHUD.show()
	}

    static func showLight(containerView: UIView? = nil, text: String? = nil) {
        SVProgressHUD.setBackgroundLayerColor(UIColor.grpBlack.withAlphaComponent(0.5))
        SVProgressHUD.setForegroundColor(.grpWhite)
        SVProgressHUD.setContainerView(containerView)
		SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setBackgroundColor(text == nil ? .clear : .grpBlackestWhite)
		SVProgressHUD.setRingThickness(4)
        SVProgressHUD.setRingNoTextRadius(28)
        SVProgressHUD.show(withStatus: text)
//        let images = [Int](1...24).compactMap { UIImage(named: "loading" + String($0)) }
//        SVProgressHUD.show(UIImage.animatedImage(with: images, duration: 1.2) ?? UIImage(), status: nil)
	}

    static func showSuccess() {
        SVProgressHUD.setBackgroundLayerColor(UIColor.grpBlack.withAlphaComponent(0.1))
        SVProgressHUD.setForegroundColor(.grpSuccessGreen)
        SVProgressHUD.setImageViewSize(.init(width: 60, height: 60))
        SVProgressHUD.setShouldTintImages(true)
        SVProgressHUD.setMinimumDismissTimeInterval(0.5)
        SVProgressHUD.showSuccess(withStatus: nil)
    }

	static func showDim() {
        SVProgressHUD.setContainerView(nil)
		SVProgressHUD.setBackgroundLayerColor(UIColor.grpBlack.withAlphaComponent(0.5))
		SVProgressHUD.setForegroundColor(.clear)
		SVProgressHUD.setBackgroundColor(.clear)
		SVProgressHUD.setDefaultMaskType(.custom)
		SVProgressHUD.show()
	}
}
