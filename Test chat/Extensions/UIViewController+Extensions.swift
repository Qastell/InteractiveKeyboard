import UIKit

extension UIViewController {
    
    var alertController: UIAlertController? {
        guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
        return alert
    }
}


extension UIViewController {
    var child: UIViewController? {
        switch self {
            case let nav as UINavigationController:
                return nav.topViewController
            case let tab as UITabBarController:
                return tab.selectedViewController
            default:
                return children.last ?? self
        }
    }
}


extension UIViewController {
    func showAlert(title: String, message: String? = nil, firstActionTitle: String? = nil, secondActionTitle: String? = nil, firstCompletion: (() -> Void)? = nil, secondCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let secondActionTitle = secondActionTitle {
            let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { (action) in
                secondCompletion?()
            }
            alertController.addAction(secondAction)
        }
        
        let firstAction = UIAlertAction(title: firstActionTitle ?? "OK", style: .default) { (action) in
            firstCompletion?()
        }
        alertController.addAction(firstAction)
        self.present(alertController, animated: true)
    }
    
    func showActionSheetAlert(title: String? = nil, message: String? = nil, firstActionTitle: String? = nil, secondActionTitle: String? = nil, thirdActionTitle: String? = nil, firstCompletion: (() -> Void)? = nil, secondCompletion: (() -> Void)? = nil, thirdCompletion: (()->())? = nil, fourthActionTitle: String? = nil, fourthCompletion: (()->())? = nil,  cancelCompletion: (()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        
        let firstAction = UIAlertAction(title: firstActionTitle ?? "OK", style: .default) { (action) in
            firstCompletion?()
        }
        alertController.addAction(firstAction)
        
        if let secondActionTitle = secondActionTitle {
            let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { (action) in
                secondCompletion?()
            }
            alertController.addAction(secondAction)
        }
        
        if let thirdActionTitle = thirdActionTitle {
            let thirdAction = UIAlertAction(title: thirdActionTitle, style: .default) { (action) in
                thirdCompletion?()
            }
            alertController.addAction(thirdAction)
        }
        
        if let fourthActionTitle = fourthActionTitle {
            let fourthAction = UIAlertAction(title: fourthActionTitle, style: .default) { (action) in
                fourthCompletion?()
            }
            alertController.addAction(fourthAction)
        }
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { action in
            cancelCompletion?()
        }))
        
        self.present(alertController, animated: true)
    }
    
    func showTimingAlert(message: String?) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        present(alertController, animated: true, completion: {
            let _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
                alertController.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    func showSettingsAlert(title: String, message: String? = nil) {
        showAlert(
            title: title,
            message: message,
            firstActionTitle: "Настройки",
            secondActionTitle: "Отмена",
            firstCompletion: {
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                UIApplication.shared.open(url)
            },
            secondCompletion: { }
        )
    }
    
    func showTextFieldAlert(title: String? = nil, message: String? = nil, placeholder: String? = nil, saveAction: ((String?)->())?) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = placeholder
        }
        let saveAction = UIAlertAction(title: "Сохранить", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            saveAction?(firstTextField.text)
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
//    class var zoom: ZoomViewController {
//        let viewController = R.storyboard.zoomViewController.zoomViewController()!
//        // UIStoryboard.taskDetails.instantiateViewController(withIdentifier: ZoomViewController.identifier) as! ZoomViewController
//        if #available(iOS 13.0, *) { viewController.isModalInPresentation = false }
//        viewController.modalPresentationStyle = .fullScreen
//        return viewController
//    }
}

