//
//  OPHResponse.swift
//  PandaHttpSwift
//
//  Created by lingen on 16/9/16.
//  Copyright © 2016年 lingen. All rights reserved.
//

import Foundation

//HTTP请求的响应结果
class HttpResponse: NSObject {
    
    static let HTTP_OK_REPONSE:Int = 200
    
    //请求HTTP 的回应 DATA 值
    var data:Data
    
    //请求的statusCode，200表示 HTTP OK
    var statusCode:Int
    
    //请求的错误
    var error:Error?
    
    override init(){
        self.data = Data()
        self.statusCode = 0
        self.error = nil
    }
    
    //请求是否返回了200
    func isRequestOk() -> Bool {
        return self.statusCode == HttpResponse.HTTP_OK_REPONSE
    }
    
    //正确的回应
    class func okResponse(data:Data) -> HttpResponse {
        let response:HttpResponse = HttpResponse()
        response.data = data
        response.statusCode = HTTP_OK_REPONSE
        return response
    }
    
    //返回错误的回应
    class func errorStatusCodeResponse(statusCode:Int,error:Error?) -> HttpResponse {
        let response:HttpResponse = HttpResponse()
        response.statusCode = statusCode
        response.error = error
        return response
    }
    
    func exceptedStringResult() -> String? {
        return self.data.StringResult()
    }
    
    func excepedDictionayResult() -> Dictionary<String,Any>? {
        return self.data.DictionaryResult()
    }
    
}
