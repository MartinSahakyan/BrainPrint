//
//  ProgressInView.swift
//  
//
//  Created by Annie Klekchyan on 6/23/16.
//  
//

import UIKit

open class ProgressInView : NSObject, ProgressHandler{
    
    var progressView: UIView
    var indicator: UIActivityIndicatorView
    var isShown: Bool = false
    
    init(view: UIView) {
        
        self.progressView = view
        indicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        super.init()
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
            let x: CGFloat = self.progressView.bounds.size.width/2 - indicator.bounds.size.width/2
            let y: CGFloat = self.progressView.bounds.size.height/2 - indicator.bounds.size.height/2
            indicator.frame = CGRect.init(x: x, y: y, width: indicator.bounds.size.width, height: indicator.bounds.size.height)
            self.progressView.addSubview(indicator)
            
            indicator.startAnimating()
            isShown = true
        }
    }

    fileprivate func dismissProgress() {
        
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        self.isShown = false
    }
}
