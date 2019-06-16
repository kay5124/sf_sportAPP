//
//  apiModel.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/11.
//  Copyright © 2019 Ray  . All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class apiModel {
    public static func apiRequest(url: String, httpMethod: HTTPMethod, parameterData: Parameters? = nil, encode: ParameterEncoding = URLEncoding.default, httpHeader: HTTPHeaders? = nil) {
        
        var errMsg: String = ""
        var statusCode : Int = -1
        var returnData : Any = ""
        
        let url = _GLobalService.apiAddress + url
        print("url:",url)
        Alamofire.request(url, method: httpMethod, parameters: parameterData, encoding: encode, headers: httpHeader)
            .responseData{ (response) in
                if response.result.isSuccess {
                    
                    errMsg = ""
                    statusCode = 0
                    returnData = response.data!
                    
                }else{
                    
                    errMsg = "error"
                    statusCode = 1
                    returnData = response.data!
                    
                }
        }
        
//        return JSON([
//            "errMsg": errMsg,
//            "statusCode": statusCode,
//            "data" : returnData
//            ])
    }
}
