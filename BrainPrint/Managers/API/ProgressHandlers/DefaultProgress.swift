//
//  DefaultProgress.swift
//  
//
//  Created by Annie Klekchyan on 6/22/16.
//  
//

import Foundation
import UIKit

open class DefaultProgress : NSObject, ProgressHandler{
    
    var transparent: UIView
    var indicator: UIActivityIndicatorView
    var isShown: Bool = false
    
    override init() {
        
        transparent = UIView.init(frame: CGRect(x:0.0, y:0.0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        indicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.whiteLarge)
    }
    func onRequestChainStarted() {
        
        self.createProgress()
    }
    
    func onRequestStarted() {
        
    }
    
    func onRequestFinished() {
        
    }
    
    func onAllRequestsFinished() {
        
        self.dismissProgress()
    }
    
    fileprivate func createProgress() {
        
        if(isShown == false){
            
            transparent.backgroundColor = UIColor.black
            transparent.alpha = 0.8
            let x: CGFloat = UIScreen.main.bounds.width/2 - indicator.bounds.size.width/2
            let y: CGFloat = UIScreen.main.bounds.height/2 - indicator.bounds.size.height/2
            indicator.frame = CGRect.init(x: x, y: y, width: indicator.bounds.size.width, height: indicator.bounds.size.height)
            transparent.addSubview(indicator)
            indicator.startAnimating()
            
            let topViewController: UIViewController? = self.getTopViewController()
            if(topViewController != nil){
                
                topViewController?.view.addSubview(transparent)
                isShown = true
            }
        }
    }
    
    fileprivate func dismissProgress() {
        
        indicator.stopAnimating()
        transparent.removeFromSuperview()
        self.isShown = false
    }
    
    func getTopViewController() -> UIViewController? {
        
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
