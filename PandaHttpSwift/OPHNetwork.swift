//
//  OPHNetwork.swift
//  PandaHttpSwift
//
//  Created by lingen on 16/9/19.
//  Copyright © 2016年 lingen. All rights reserved.
//

import Foundation

//网络请求的核心方法
class OPHNetWork: NSObject {
    
    //GET方法
    static let HTTP_GET:String = "GET"
    //POST方法
    static let HTTP_POST:String = "POST"
    //PUT方法
    static let HTTP_PUT:String = "PUT"
    //DELETE 方法
    static let HTTP_DELETE:String = "DELETE"
    
    
    static let CONTENT_TYPE:String = "Content-Type"
    
    static let JSON_CONTENT_TYPE:String = "application/json"
    
    static let Content_Length:String = "Content_Length"
    
    
    //单例对象
    private static let instance:OPHNetWork = OPHNetWork()
    
    //返回单例
    static func sharedInstance() -> OPHNetWork {
        return instance;
    }
    
    //将init方法私有化，以避免大量构建此类
    private override init() {
        
    }
    
    //发出一个同步请求
    func syncRequest(request:OPHRequest) throws -> OPHResponse {
        var ophResponse:OPHResponse = OPHResponse()
        
        let url:URL = URL(string: request.url)!
        
        var urlReuqest:URLRequest = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: TimeInterval(request.timeout))

        switch request.method {
        case .OPH_HTTP_GET:
            urlReuqest.httpMethod = OPHNetWork.HTTP_GET
        case .OPH_HTTP_POST:
            urlReuqest.httpMethod = OPHNetWork.HTTP_POST
        case .OPH_HTTP_PUT:
            urlReuqest.httpMethod = OPHNetWork.HTTP_PUT
        case .OPH_HTTP_DELETE:
            urlReuqest.httpMethod = OPHNetWork.HTTP_DELETE
        }
        
        let params:Dictionary = request.params
        
        if params.count > 0 {
            urlReuqest.setValue(OPHNetWork.JSON_CONTENT_TYPE, forHTTPHeaderField: OPHNetWork.CONTENT_TYPE)
            
            let data:Data? = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            if (data != nil) {
                
                urlReuqest.setValue(String(data!.count), forHTTPHeaderField: OPHNetWork.Content_Length)
                
                urlReuqest.httpBody = data
            }
            
        }
        
        let defaultConfiguration = URLSessionConfiguration.default
        let semaphore = DispatchSemaphore.init(value: 0)
        let session:URLSession = URLSession(configuration: defaultConfiguration)
        
        (session.dataTask(with: urlReuqest) { (data, response, error) in
            if response != nil {
                
                let urlResponse:HTTPURLResponse = response as! HTTPURLResponse
                
                if let error = error {
                    print("Error: \(error)")
                    ophResponse = OPHResponse.errorStatusCodeResponse(statusCode: urlResponse.statusCode, error: error)
                } else if data != nil{
                    let data = data
                    ophResponse = OPHResponse.okResponse(data: data!)
                }
                
            }
            
            semaphore.signal()
            
        }).resume()
        
        semaphore.wait()
        
        return ophResponse
    }
    
    
}
