//
//  OPHRequest.swift
//  PandaHttpSwift
//
//  Created by lingen on 16/9/16.
//  Copyright © 2016年 lingen. All rights reserved.
//

import Foundation


//请求类型
enum HttpRequestMethod{
    
    //Get请求
    case HTTP_GET
    
    //Post请求
    case HTTP_POST
    
    //PUT请求
    case HTTP_PUT
    
    //DELETE请求
    case HTTP_DELETE
    
}

//请求ContentType类型
enum HttpContentType{
    
    //JSON格式类型的请求TYPE
    case JSON_CONTENT_TYPE
    
    //FROM格式请求的TYPE
    case FROM_CONTENT_TYPE
    
}

//OPHRequest类，构建一个网络请求
class HttpRequest: NSObject {
    
    //默认的HTTP请求超时时间，为120 S
    static let DEFAULT_TIMEOUT:Int = 60 * 2
    
    //HTTP请求的超时时间
    var timeout:Int = 0
    
    //HTTP请求的方式
    var method:HttpRequestMethod = .HTTP_GET
    
    //请求参数的格式
    var contentType:HttpContentType = .JSON_CONTENT_TYPE
    
    //请求参数
    var params:Dictionary<String,Any> = [:]
    
    //请求URL
    var url:String = ""
    
    //通过 URL,OPHRequestMethod两者构建一个 JSON类型的OPHRequest对象
    class func jsonRequest(url:String,method:HttpRequestMethod) -> HttpRequest {
        let request:HttpRequest = HttpRequest()
        request.method = method
        request.url = url
        request.timeout = DEFAULT_TIMEOUT
        request.contentType = .JSON_CONTENT_TYPE
        return request
    }
    
    //通过 URL,OPHRequestMethod以及参数来构建一个OPHRequest对象
    class func jsonRequest(url:String,method:HttpRequestMethod,params:Dictionary<String,Any>) -> HttpRequest {
        let request:HttpRequest = HttpRequest()
        request.method = method
        request.url = url
        request.timeout = DEFAULT_TIMEOUT
        request.contentType = .JSON_CONTENT_TYPE
        request.params = params
        return request
    }
    
    //通过 URL,OPHRequestMethod以及参数来构建一个 OPHReqeust对象
    class func jsonRequest(url:String,method:HttpRequestMethod,params:Dictionary<String,Any>,timeout:Int) -> HttpRequest {
        let request:HttpRequest = HttpRequest()
        request.method = method
        request.url = url
        request.timeout = timeout
        request.contentType = .JSON_CONTENT_TYPE
        request.params = params
        return request
    }
    
    //通过 URL,OPHRequestMethod两者构建一个Form类型的OPHRequest对象
    class func formRequest(url:String,method:HttpRequestMethod) -> HttpRequest {
        let request:HttpRequest = HttpRequest()
        request.method = method
        request.url = url
        request.timeout = DEFAULT_TIMEOUT
        request.contentType = .FROM_CONTENT_TYPE
        return request
    }
    
    //通过 URL,OPHRequestMethod以及参数来构建一个Form类型的OPHRequest对象
    class func formRequest(url:String,method:HttpRequestMethod,params:Dictionary<String,Any>) -> HttpRequest {
        let request:HttpRequest = HttpRequest()
        request.method = method
        request.url = url
        request.timeout = DEFAULT_TIMEOUT
        request.contentType = .FROM_CONTENT_TYPE
        request.params = params
        return request
    }
    
    //通过 URL,OPHRequestMethod以及参数来构建一个Form类型的OPHReqeust对象
    class func formRequest(url:String,method:HttpRequestMethod,params:Dictionary<String,Any>,timeout:Int) -> HttpRequest {
        let request:HttpRequest = HttpRequest()
        request.method = method
        request.url = url
        request.timeout = timeout
        request.contentType = .FROM_CONTENT_TYPE
        request.params = params
        return request
    }
    
}
