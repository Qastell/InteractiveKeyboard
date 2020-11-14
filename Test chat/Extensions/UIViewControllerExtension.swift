//
//  UIViewControllerExtension.swift
//  101group
//
//  Created by Max Petrenko on 30.11.17.
//  Copyright © 2017 101 GROUP. All rights reserved.
//

import Eureka
import Toast_Swift
import LGSemiModalNavController
import MaterialComponents.MaterialFeatureHighlight
import Photos
import MobileCoreServices

extension FormViewController {
	func setupFormDefaults(bottomInset: CGFloat = 0, rowHeight: CGFloat?, backgroundColor: UIColor? = nil) {
		if let rowHeight = rowHeight {
			tableView.rowHeight = rowHeight
		}
		tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
		tableView.separatorStyle = .none
		tableView.backgroundColor = backgroundColor ?? tableView.backgroundColor

		// Enables the navigation accessory and stops navigation when a disabled row is encountered
		navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow).union(.SkipCanNotBecomeFirstResponderRow)
		// Enables smooth scrolling on navigation to off-screen rows
		animateScroll = true
		// Leaves 60pt of space between the keyboard and the highlighted row after scrolling to an off screen row
		rowKeyboardSpacing = 60
	}
}

extension UINavigationController {
	func pushVCNoBackTitle(_ vc: UIViewController, animated: Bool = true) {
		topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
		pushViewController(vc, animated: animated)
	}
}

extension UIViewController {
    func showUIImagePicker(isCamera: Bool, allowsEditing: Bool = false) {
        var pickerController: UIImagePickerController?

        if isCamera {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                pickerController = UIImagePickerController()
                pickerController?.sourceType = .camera
              //  pickerController?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) ?? [(kUTTypeImage as String), (kUTTypeMovie as String)]
                pickerController?.imageExportPreset = .current
                pickerController?.videoQuality = .typeMedium
                pickerController?.videoExportPreset = AVAssetExportPresetPassthrough
                pickerController?.videoMaximumDuration = 60
                pickerController?.allowsEditing = allowsEditing
            }
        } else {
            if #available(iOS 11.0, *) {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    pickerController = UIImagePickerController()
                    pickerController?.sourceType = .photoLibrary
                    pickerController?.allowsEditing = allowsEditing
                }
            } else {
                PHPhotoLibrary.checkAuthorization { isAllowed in
                    if isAllowed {
                        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                            pickerController = UIImagePickerController()
                            pickerController?.sourceType = .photoLibrary
                            pickerController?.allowsEditing = allowsEditing
                        }
                    } else {
                       // self.showSettingsApp(message: NLS("photos_access"))
                    }
                }
            }

        }

        guard let p = pickerController else { return }
        p.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(p, animated: true) {
            guard p.sourceType == .camera else { return }
            AVCaptureDevice.checkAuthorization { isAllowed in
                if !isAllowed {
                  //  p.showSettingsApp(message: NLS("camera_access"))
                }
            }
        }
    }
    public func showSettingsApp(message: String) {
        showAlert(message: message,
                  sender: view,
                  actions: [UIAlertAction(title: "cancel".localized.firstUppercased, style: .default),
                            UIAlertAction(title: "settings".localized.firstUppercased, style: .cancel) { _ in
                                guard let url = URL(string: UIApplication.openSettingsURLString),
                                    UIApplication.shared.canOpenURL(url) else { return }

                                UIApplication.shared.open(url)
                            }])
    }

//    func setupHighlighter(view: UIView?, type: HighlighterType, innerHighlightColor: UIColor) {
//        let defaults = DefaultsService()
//        var highlighters = defaults.presentedHighlighters ?? [:]
//
//        guard
//            !(highlighters[String(type.rawValue)] as? Bool ?? false),
//            presentedViewController == nil,
//            let highlightedView = view else { return }
//
//        highlighters[String(type.rawValue)] = true
//        defaults.presentedHighlighters = highlighters
//
//        let highlightController = MDCFeatureHighlightViewController(highlightedView: highlightedView,
//                                                                    completion: { (_: Bool) in
//                                                                      // perform analytics here
//                                                                      // and record whether the highlight was accepted
//                                                                    })
//        highlightController.titleText = (type == .addDocument ? "add_document_help_title" : "info_highlight_title").localized
//        highlightController.titleColor = .grpWhite
//        highlightController.bodyText = (type == .addDocument ? "add_document_help_body" : "info_highlight_body").localized
//        highlightController.bodyColor = .grpWhite
//        highlightController.outerHighlightColor =
//          NotificationType.info.color.withAlphaComponent(kMDCFeatureHighlightOuterHighlightAlpha)
//        highlightController.innerHighlightColor = innerHighlightColor
//        present(highlightController, animated: true)
//    }

//    func setupButton(_ button: UIButton?, titleNlsKey: String, attributes: [NSAttributedString.Key: Any] = Settings.shared.attrs17White, action: Selector) {
//        button?.setAttributedTitle(NLS(titleNlsKey).firstUppercased.attributed(attributes), for: .normal)
//        button?.addTarget(self, action: action, for: .touchUpInside)
//    }
//
//    func showMessage(_ message: String,
//                     type: NotificationType,
//                     timeout: TimeInterval = Settings.shared.notificationTimeout,
//                     position: ToastPosition = .top,
//                     isModal: Bool = false,
//                     isQueueEnabled: Bool = false) {
//        if isModal {
//            view.show(message: message, type: type, timeout: timeout, position: position)
//            presentingViewController?.view.show(message: message, type: type, timeout: timeout, position: position)
//        } else {
//            (navigationController?.view ?? view)?.show(message: message, type: type, timeout: timeout, position: position)
//        }
//	}

	@objc func backButtonAction() {
		self.dismiss(animated: true, completion: nil)
	}

    func addBackButton(title: String?, new: Bool = false) {
		if let nav = self.navigationController,
           let backItem = nav.navigationBar.backItem, !new {
			backItem.title = title
		} else {
			if let nav = self.navigationController,
				let item = nav.navigationBar.topItem {
				item.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.backButtonAction))
			}
		}
	}

    public func showNotLoggedInAlert(sender: UIView) {
        showAlert(message: "not_logged_in_hint_text".localized, sender: sender, preferredStyle: .actionSheet)
	}

    public func showAlert(title: String? = nil, message: String?, sender: NSObject, actions: [UIAlertAction] = [], preferredStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let popoverController = alert.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
            popoverController.sourceView = sender as? UIView
            popoverController.sourceRect = (sender as? UIView)?.bounds ?? .zero
        }

        if actions.isNotEmpty {
            actions.forEach { alert.addAction($0) }
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
        present(alert, animated: true)
    }

//    func doModalPresentation(destinationVC: MTModalViewController) {
//        let semiModal = GRPModalVC(modalVC: destinationVC, isTapDismissEnabled: true)
//        present(semiModal, animated: true)
//    }
}

//class GRPModalVC: FirebaseTrackedBottomPopupVC {
//    private var modalVC: MTModalViewController!
//    private var isTapDismissEnabled: Bool!
//
//    convenience init(modalVC: MTModalViewController, isTapDismissEnabled: Bool) {
//        self.init()
//        self.modalVC = modalVC
//        self.isTapDismissEnabled = isTapDismissEnabled
//    }
//
//    // MARK: Life cycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .grpBlackGrey
//        addChild(modalVC)
//        modalVC.view.frame = view.bounds
//        view.addSubview(modalVC.view)
//        modalVC.didMove(toParent: self)
//    }
//
//    // MARK: BottomPopupViewControllerDelegate
//
//    override var popupHeight: CGFloat {
//        return modalVC.initialHeight > 0 ? modalVC.initialHeight : Settings.shared.bottomPopupHeight
//    }
//
//    override var popupTopCornerRadius: CGFloat {
//        return Settings.shared.dashboardCornerRadius
//    }
//
//    override var popupPresentDuration: Double {
//        return 0.3
//    }
//
//    override var popupDismissDuration: Double {
//        return 0.3
//    }
//
//    override var popupShouldDismissInteractivelty: Bool {
//        return isTapDismissEnabled
//    }
//}
