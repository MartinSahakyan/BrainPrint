//
//  DefaultError.swift
//  
//
//  Created by Annie Klekchyan on 6/22/16.
//  
//

import Foundation

class  DefaultError: NSObject, ErrorHandler {
    
    func onUnknownError(){
        
        AlertHelper.showTimeOutAlert(viewController: nil)
    }
    
    func onTimeoutError(){
        
        AlertHelper.showTimeOutAlert(viewController: nil)
    }
    
    func onOffleineError(){
        
        AlertHelper.showOfflineErrorAlert(viewController: nil)
    }
    
    func onExceptionError(){
        
        AlertHelper.showSomethingWentWrong(viewController: nil)
    }
    
    func onAppError(_ message: String){
        
        AlertHelper.showAppErrorAlert(message, viewController: nil)
    }
}
