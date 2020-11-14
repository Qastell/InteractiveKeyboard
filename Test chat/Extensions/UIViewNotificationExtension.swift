//
//  UIViewNotificationExtension.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 01/07/2019.
//  Copyright © 2019 101 GROUP. All rights reserved.
//

import Toast_Swift

public enum NotificationType {
	case error, info, success, appUpdate

//	var color: UIColor {
//		switch self {
//		case .success:
//			return Settings.shared.colorNotificationBackgroundSuccess
//		case .info:
//			return Settings.shared.colorNotificationBackgroundInfo
//		case .error,
//			 .appUpdate:
//			return Settings.shared.colorNotificationBackgroundError
//		}
//	}
}

extension UIView {
//	func show(message: String,
//              type: NotificationType,
//              timeout: TimeInterval = Settings.shared.notificationTimeout,
//              position: ToastPosition = .top,
//              isQueueEnabled: Bool = false) {
//        show(attrMessage: message.attributed([.font: UIFont.grp17, .foregroundColor: UIColor.grpWhite]),
//             type: type,
//             timeout: timeout,
//             position: position,
//             isQueueEnabled: isQueueEnabled)
//    }

//    func show(attrMessage: NSAttributedString,
//              type: NotificationType,
//              timeout: TimeInterval = Settings.shared.notificationTimeout,
//              position: ToastPosition = .top,
//              isQueueEnabled: Bool = false,
//              backgroundColor: UIColor? = nil) {
//		let view = UIView(frame: CGRect(x: 8, y: 4, width: bounds.width - 16, height: 0))
//		view.backgroundColor = backgroundColor ?? type.color
//		view.layer.cornerRadius = 8
//		view.clipsToBounds = true
//		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "ic_no_internet"))
//        let isOfflineMessage = attrMessage.string.lowercased().contains(NLS("internet_connection_offline").lowercased()) // TODO: refactor
//        let imageViewLeftSpace: CGFloat = isOfflineMessage ? 19 + 8 : 0
//        let bottom: CGFloat = (type == .appUpdate) ? 52 : 16
//
//        if isOfflineMessage {
//            imageView.contentMode = .left
//            view.addSubview(imageView)
//            imageView.constraintsToSuperview(insets: .init(top: 16, left: 16, bottom: bottom, right: 16))
//        }
//
//		let label = UILabel()
//		label.numberOfLines = 0
//		label.attributedText = attrMessage
//		view.addSubview(label)
//		let size = CGSize(width: view.bounds.width - 32 - imageViewLeftSpace, height: .greatestFiniteMagnitude)
//		let textRect = attrMessage.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
//		view.bounds.size.height = 2 + 16 + ceil(textRect.size.height) + bottom
//        label.constraintsToSuperview(insets: .init(top: 16, left: imageViewLeftSpace + 16, bottom: bottom, right: 16))
//
//		let button = UIButton()
//
//		if type == .appUpdate {
//			button.setTitle(NLS("update_app_title"), for: .normal)
//			button.titleLabel?.font = .grpSemi17
//			button.backgroundColor = Settings.shared.colorNotificationBackgroundInfo
//			button.addTarget(self, action: #selector(updateApp), for: .touchUpInside)
//			button.backgroundColor = NotificationType.info.color
//			view.addSubview(button)
//            button.constraintsToSuperview(heightFromBottom: 40)
//		}
//
//        ToastManager.shared.isQueueEnabled = isQueueEnabled
//		showToast(view, duration: timeout, position: position)
//	}

//	@objc private func updateApp() {
//		guard let url = URL(string: WebsiteURLs.appStoreURL.localizedURLString),
//			UIApplication.shared.canOpenURL(url) else { return }
//
//		UIApplication.shared.open(url)
//	}
}
