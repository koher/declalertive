import UIKit

extension UIViewController {
    public func setPresents(_ presents: Bool, alertController: UIAlertController, animated: Bool) {
        if presents {
            if let presentingViewController = alertController.presentingViewController {
                if presentingViewController === self { return }
                alertController.dismiss(animated: animated) { [self] in
                    present(alertController, animated: animated)
                }
            } else {
                present(alertController, animated: animated)
            }
        } else {
            if let presentingViewController = alertController.presentingViewController {
                guard presentingViewController === self else { return }
                presentingViewController.dismiss(animated: animated, completion: nil)
            }
        }
    }
}
