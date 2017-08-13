//
//  OPHNetwork.swift
//  PandaHttpSwift
//
//  Created by lingen on 16/9/19.
//  Copyright © 2016年 lingen. All rights reserved.
//

import Foundation

//网络请求的核心方法
public class NetworkSession: NSObject {
    
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
    private static let instance:NetworkSession = NetworkSession()
    
    //返回单例
    public static func sharedInstance() -> NetworkSession {
        return instance;
    }
    
    //将init方法私有化，以避免大量构建此类
    private override init() {
        
    }
    
    //发出一个同步请求
    public func jsonRequest(request:HttpRequest) throws -> HttpResponse {
        var ophResponse:HttpResponse = HttpResponse()
        
        let url:URL = URL(string: request.url)!
        
        var urlReuqest:URLRequest = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: TimeInterval(request.timeout))

        switch request.method {
        case .HTTP_GET:
            urlReuqest.httpMethod = NetworkSession.HTTP_GET
        case .HTTP_POST:
            urlReuqest.httpMethod = NetworkSession.HTTP_POST
        case .HTTP_PUT:
            urlReuqest.httpMethod = NetworkSession.HTTP_PUT
        case .HTTP_DELETE:
            urlReuqest.httpMethod = NetworkSession.HTTP_DELETE
        }
        
        let params:Dictionary = request.params
        
        if params.count > 0 {
            urlReuqest.setValue(NetworkSession.JSON_CONTENT_TYPE, forHTTPHeaderField: NetworkSession.CONTENT_TYPE)
            
            let data:Data? = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            if (data != nil) {
                
                urlReuqest.setValue(String(data!.count), forHTTPHeaderField: NetworkSession.Content_Length)
                
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
                    ophResponse = HttpResponse.errorStatusCodeResponse(statusCode: urlResponse.statusCode, error: error)
                } else if data != nil{
                    let data = data
                    ophResponse = HttpResponse.okResponse(data: data!)
                }
                
            }
            
            semaphore.signal()
            
        }).resume()
        
        semaphore.wait()
        
        return ophResponse
    }
    
    
}
