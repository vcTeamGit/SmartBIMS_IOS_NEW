//
//  TakeOverAPI.swift
//  SmartBIMS
//
//  Created by 대한적십자사 혈액관리본부 혈액정보팀 on 2021/07/02.
//

import UIKit

class TakeOverRegisterAPI {
    static let shared = TakeOverRegisterAPI()
    
    func getDataFromURLWithSelector(url: String,
                                    selector: Selector,
                                    parameter: NSDictionary,
                                    delegate: UIViewController){
        
        let request = HttpRequest()
        request.setDelegate(delegate.self, selector: selector)
        request.requestURL(url, bodyObject: parameter as! [String: Any])
    }
    
    func getDictionaryFromResult(_ result: Any) -> Dictionary<String, Any> {
        var strResult = String(describing: result)
        strResult = strResult.replacingOccurrences(of: "\r\n", with: "")
        
        guard let json = try? JSONSerialization
                                .jsonObject(with: Data(strResult.utf8),
                                            options: []) as? [String : Any]
        else {
            return [String: Any]()
        }
        
        return json
    }
}
