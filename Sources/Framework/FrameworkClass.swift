//
//  File.swift
//  
//
//  Created by Sagar C on 02/04/20.
//

import Foundation
import Alamofire

public protocol APICoreDelegate: AnyObject {
    func didReceiveData(data: Data)
}

open class Validator {
    public static let `default` = Validator()
    open func validateValueUsingRegEx(regEx : String, value : String) -> Bool {
        let regExPred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return regExPred.evaluate(with: value)
    }
}

open class APICore {
    public static let `default` = APICore()
    public var delegate: APICoreDelegate?
    open func processApiCall( url : String, method: HTTPMethod, parameters: Dictionary<String, Any>)
    {
        Alamofire.request(url, method: method, parameters: parameters).responseData { response in
            if response.result.isFailure {
                return
            }
            guard let jsonData = response.result.value else {
                return
            }
            self.delegate?.didReceiveData(data: jsonData)
        }
    }
}
