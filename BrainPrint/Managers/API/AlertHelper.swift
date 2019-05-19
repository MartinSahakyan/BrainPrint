//
//  AlertHelper.swift
//  
//
//  Created by Annie Klekchyan on 6/22/16.
//

import UIKit

class AlertHelper: NSObject {
    
    var viewControllerforShow: UIViewController?
    static var showError = true
    
    class func  showSomethingWentWrong(viewController: UIViewController?) {
        
        self.showAlertWithMessage("Something Went Wrong", Title: "", viewController: viewController)
    }
    
    class func showTimeOutAlert(viewController: UIViewController?) {
        
        self.showAlertWithMessage("TimeOut", Title: "", viewController: viewController)
    }
    
    class func showOfflineErrorAlert(viewController: UIViewController?) {
        
        if showError {
            showError = false
            self.showAlertWithMessage("Please check your Internet connection and try again", Title: "", viewController: viewController)
        }
    }
    
    class func showExceptionErrorAlert(viewController: UIViewController?) {
        
        self.showAlertWithMessage("Exception", Title: "", viewController: viewController)
    }
    
    class func showAppErrorAlert(_ message: String, viewController: UIViewController?) {
        
        self.showAlertWithMessage(message, Title: "", viewController: viewController)
    }
    
    class func showAlertWithMessage(_ message: String, Title title:String, viewController: UIViewController?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
            
            if "Sorry, something went wrong. Please try again later." != message && showError {
                NotificationCenter.default.post(name: Notification.Name("alertOKButtonAction"), object: nil)
            }
            showError = true
        }))
        
        if(viewController == nil){
            
            let topViewController: UIViewController? = self.getTopViewController()
            if(topViewController != nil){
                
                topViewController!.present(alert, animated: true, completion: nil)
            }
        }else{
            
            viewController!.present(alert, animated: true, completion: nil)
        }
    }
    
    class func getTopViewController() -> UIViewController? {
        
        var topController = UIApplication.shared.keyWindow?.rootViewController
        if (topController != nil) {
            while let presentedViewController = topController!.presentedViewController {
                topController = presentedViewController
            }
            return topController!
        }
        return nil
    }
}
