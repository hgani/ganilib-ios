
import MessageUI
import UIKit

open class LaunchHelper {
    private unowned let screen: UIViewController

    public init(_ screen: UIViewController) {
        self.screen = screen
    }

    public func alert(_ message: String, title: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        screen.present(alert, animated: true, completion: nil)
    }

    public func confirm(_ message: String, title: String? = nil, handler: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            handler()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        screen.present(alert, animated: true, completion: nil)
    }

    public func call(_ number: String) {
        if let phoneCallURL = URL(string: "tel://\(number)") {
            let application = UIApplication.shared
            if application.canOpenURL(phoneCallURL) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                alert("This device doesn't support phone calls")
            }
        } else {
            // TODO: Throw exception
        }
    }

    public func mail(_ to: String, subject: String, message: String, delegate: MFMailComposeViewControllerDelegate) {
        if MFMailComposeViewController.canSendMail() {
            let composeViewController = MFMailComposeViewController()
            composeViewController.mailComposeDelegate = delegate
            composeViewController.setToRecipients([to])
            composeViewController.setSubject(subject)
            composeViewController.setMessageBody(message, isHTML: false)
            screen.present(composeViewController, animated: true, completion: nil)
        } else {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "mailto:\(to)")!)
            } else {
                // Fallback on earlier versions
            }
        }
    }

    public func maps(_ address: String) {
        let baseURL = "http://maps.apple.com/?q="
        let encodedName = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let mapURL = baseURL + encodedName

        if let url = URL(string: mapURL) {
            let application = UIApplication.shared
            if application.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    application.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                alert("This device does not have Maps app")
            }
        } else {
            // TODO: Throw exception
        }
    }

    public func url(_ string: String) {
        if let url = URL(string: string) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
