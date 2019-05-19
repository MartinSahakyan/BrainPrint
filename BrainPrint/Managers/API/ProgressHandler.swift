//
//  ProgressHandler.swift
//  
//
//  Created by Annie Klekchyan on 6/22/16.
//

import Foundation

@objc protocol ProgressHandler {
    
    func onRequestChainStarted()
    func onRequestStarted()
    func onRequestFinished();
    func onAllRequestsFinished()
}
