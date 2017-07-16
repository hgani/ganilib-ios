
import UIKit
import MessageUI

open class LaunchHelper {
    // NOTE: Not sure if we need to set this to weak. We tried unowned but got "bad access".
    private let screen : UIViewController
    
    public init(_ screen : UIViewController) {
        self.screen = screen
    }
    
    public func alert(_ message: String, title: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        screen.present(alert, animated: true, completion: nil)
    }
    
    public func call(_ number : String) {
        if let phoneCallURL = URL(string: "tel://\(number)") {
            let application = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
            else {
                alert("This device doesn't support phone calls")
            }
        }
        else {
            // TODO: Throw exception
        }
    }
    
    public func mail(_ to : String, subject : String, message : String, delegate : MFMailComposeViewControllerDelegate) {
        if (MFMailComposeViewController.canSendMail()) {
            let composeViewController = MFMailComposeViewController()
            composeViewController.mailComposeDelegate = delegate
            composeViewController.setToRecipients([to])
            composeViewController.setSubject(subject)
            composeViewController.setMessageBody(message, isHTML: false)
            screen.present(composeViewController, animated: true, completion: nil)
        }
        else {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "mailto:\(to)")!)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    public func maps(_ address : String) {
        let baseURL = "http://maps.apple.com/?q="
        let encodedName = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let mapURL = baseURL + encodedName
        
        if let url = URL(string: mapURL) {
            let application = UIApplication.shared
            if (application.canOpenURL(url)) {
                if #available(iOS 10.0, *) {
                    application.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
            else {
                alert("This device does not have Maps app")
            }
        }
        else {
            // TODO: Throw exception
        }
    }
    
    public func screen(_ controller : UIViewController, animated : Bool, pop : Bool = false) {
        if pop {
            // See http://stackoverflow.com/questions/6872852/popping-and-pushing-view-controllers-in-same-action
            var vcArray = screen.navigationController?.viewControllers
            vcArray!.removeLast()
            vcArray!.append(controller)
            screen.navigationController?.setViewControllers(vcArray!, animated: animated)
        }
        else {
            screen.navigationController?.pushViewController(controller, animated: animated)
        }
    }
}
