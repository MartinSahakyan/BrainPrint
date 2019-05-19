//
//  ServiceInvocation.swift
//  
//
//  Created by Annie Klekchyan on 6/16/16.
//

import UIKit
import Alamofire
import RxAlamofire
import RxSwift
import SwiftyJSON

typealias ServiceCallback = (JSON?, NSError?) -> Void
var requestFailError: NSError = NSError(domain: "requestFail", code: -1000, userInfo: nil)

var disposeBag:DisposeBag! = DisposeBag()
private var activeRequestsCount: Int = 0
public var baseURL: String = ""
private var globalProgressHandler: ProgressHandler?

private func decrementAndGet() -> Int {
    
    activeRequestsCount -= 1
    return activeRequestsCount
}

private func getAndIncrement() -> Int {
    
    let count: Int = activeRequestsCount
    activeRequestsCount += 1
    return count
}

enum RequestMethod{
    
    case requestMethodGet
    case requestMethodPut
    case requestMethodPost
    case requestMethodDelete
}

protocol ServiceInvocation {
    
    func getURLWithServiceString (_ url: String, serviceString: String) -> String
    func invokeWithRequest(_ method:RequestMethod, url:String, parameters:Dictionary<String, AnyObject>?, headers:Dictionary<String,String>?, errorHandler: ErrorHandler, progressHandler: ProgressHandler, callBack:ServiceCallback!)
    func objectFromJson(_ json:AnyObject) -> JSON?
}

extension ServiceInvocation {
    
    func getURLWithServiceString (_ url: String, serviceString: String) -> String {
        
        return String(format: "%@/%@", url, serviceString)
    }
    
    func invokeRequestWithDownload(_ stringURL: String, headers:Dictionary<String,String>?, errorHandler: ErrorHandler, progressHandler: ProgressHandler, callBack: @escaping ServiceCallback) {
        
//        requestData(.get, stringURL, parameters: nil, encoding: URLEncoding.default, headers: headers)
//            .subscribeOn(ConcurrentDispatchQueueScheduler(queue: .global() ))
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { (response, data) in
//
//                callBack(data, nil)
//
//                }, onError: { (error) in
//
//                    callBack(nil, error as NSError)
//                }, onCompleted: {
//
//            }) {
//
//            }.disposed(by: disposeBag)
    }
    
//    func invokeRequestWithUpload(_ stringURL: String, errorHandler: ErrorHandler, progressHandler: ProgressHandler, callBack: @escaping ServiceCallback) {
//        _ = upload(try! URLRequest(.get, stringURL), data: Data())
//            .flatMap {
//                $0
//                    .validate(statusCode: 200 ..< 300)
//                    .validate(contentType: ["application/json"])
//                    .rx_progress()
//            }
//            .observeOn(MainScheduler.instance)
//            .subscribeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .background))
//            .subscribe {
//                print($0)
//                
//                callBack ($0.debugDescription, $0.error as? NSError)
//        }
//    }
    
    func invokeWithRequest(_ method:RequestMethod, url:String, parameters:Dictionary<String, AnyObject>?, headers:Dictionary<String,String>?, errorHandler: ErrorHandler, progressHandler: ProgressHandler, callBack:ServiceCallback!) {
        
        if(globalProgressHandler == nil){
            globalProgressHandler = progressHandler
        }
        
        if(getAndIncrement() == 0){
            globalProgressHandler!.onRequestChainStarted();
        }
        
        globalProgressHandler!.onRequestStarted();
        
        let reachability: NetworkReachabilityManager = NetworkReachabilityManager()!
        if reachability.isReachable == false{
            
            errorHandler.onOffleineError()
            globalProgressHandler!.onRequestFinished()
            
            callBack(nil, requestFailError)
            if (decrementAndGet() == 0) {
                globalProgressHandler!.onAllRequestsFinished()
                globalProgressHandler = nil
               // rl.onAllRequestsFinished();
            }
        }else{
        
            globalProgressHandler!.onRequestChainStarted()
            self.doRequest(method, url: url, parameters: parameters, headers: allHeaders(headers), errorHandler: errorHandler, progressHandler: progressHandler, callBack: callBack)
        }
    }
    
    fileprivate func doRequest(_ method:RequestMethod, url: String, parameters: Dictionary<String, AnyObject>?, headers: Dictionary<String, String>?, errorHandler: ErrorHandler, progressHandler: ProgressHandler, callBack: @escaping ServiceCallback){
        
        let requestMethod: Alamofire.HTTPMethod
        switch method {
        case .requestMethodGet:
            requestMethod = Alamofire.HTTPMethod.get
        case .requestMethodPost:
            requestMethod = Alamofire.HTTPMethod.post
        case .requestMethodPut:
            requestMethod = Alamofire.HTTPMethod.put
        case .requestMethodDelete:
            requestMethod = Alamofire.HTTPMethod.delete
        }
        
        requestJSON(requestMethod, url, parameters: parameters, encoding: URLEncoding.default, headers: allHeaders(headers))
            .do(onNext: { (r, json) in
                print(url)
                print(json)
                let hasAppError: Bool = BrainPrintAPI.sharedInstance.hasAppError(json as! NSDictionary, errorHandler: errorHandler)
                if hasAppError == true {
                    requestFailError = NSError(domain: "requestFail", code: (json as AnyObject).object(forKey: "responseStatus") as! Int, userInfo: nil)
                    
                    callBack(nil, requestFailError)
                }else{
                    let jsonData = try? JSONSerialization.data(withJSONObject:json)
                    let obj = try? JSON(data: jsonData!)
                    callBack(obj, nil)
                }
                }, onError: { (error) in
                    globalProgressHandler!.onRequestFinished();
                    if (decrementAndGet() == 0) {
                        globalProgressHandler!.onAllRequestsFinished();
                        globalProgressHandler = nil
                    }
                    callBack(nil, error as NSError);
                }, onCompleted: { 
                    globalProgressHandler!.onRequestFinished();
                    if (decrementAndGet() == 0) {
                        globalProgressHandler!.onAllRequestsFinished();
                        globalProgressHandler = nil
                    }
                }, onSubscribe: { 
                    
                }, onDispose: { 
                    
            })
            .subscribeOn(ConcurrentDispatchQueueScheduler(queue: .global()))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (r, json) -> Void in
            }).disposed(by: disposeBag)
    }
    
    func defaultHeaders() -> Dictionary<String, String> {
        var headers = Dictionary<String, String>()
//        let device = UIDevice.current
//        headers["os.name"] = device.systemName
//        headers["os.version"] = device.systemVersion
        return headers
    }
    
    
    func allHeaders(_ additionalHeaders:Dictionary<String, String>?) -> Dictionary<String, String>? {
        return nil
        let defaultHdrs: [String : String] = defaultHeaders()
        if additionalHeaders != nil {
            let resultHeaders = defaultHdrs.merging(additionalHeaders!) { (current, _) in current }
            return resultHeaders
        }
        
        return defaultHdrs
    }
    
}
