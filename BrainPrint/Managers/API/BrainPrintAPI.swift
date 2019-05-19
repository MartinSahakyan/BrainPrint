import UIKit

class BrainPrintAPI: NSObject {
    static let sharedInstance = BrainPrintAPI()
    var baseUrl = ""
    
    func hasAppError(_ result: NSDictionary, errorHandler: ErrorHandler) -> Bool{
        
        let isSuccess = result.object(forKey: "responseStatus") as? Int
        
        if isSuccess == 1 || isSuccess == nil {
            return false
        }
        
        guard let message = result.object(forKey: "message") else { return false }
        //let message: String = result.object(forKey: "message") as? String
        errorHandler.onAppError(message as! String)
        return true
    }
}
