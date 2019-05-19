//
//  ErrorHandlingProtocol.swift
//  
//
//  Created by Annie Klekchyan on 6/22/16.
//

import Foundation

@objc protocol ErrorHandler {
    
    func onUnknownError()
    func onTimeoutError()
    func onOffleineError();
    func onExceptionError()//(Throwable t)
    func onAppError(_ message: String)
}
