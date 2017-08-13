//
//  PandaHttpSwiftTests.swift
//  PandaHttpSwiftTests
//
//  Created by lingen on 16/9/16.
//  Copyright © 2016年 lingen. All rights reserved.
//

import XCTest
import Foundation

class PandaHttpSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetJson() throws {
        
        let request:HttpRequest = HttpRequest.jsonRequest(url: "http://localhost:8081/account/search?search=l&page=1&pagesize=10", method: .HTTP_GET)
        
        let response:HttpResponse = try NetworkSession.sharedInstance().jsonRequest(request: request)
        
        if response.isRequestOk() {
            let result:Dictionary<String,Any>? = response.excepedDictionayResult()
            print("返回结果\(result!)")
        }
    }
    
    func testPostJson() throws {
        let url:String = "http://localhost:8081/account";
        
        let params:Dictionary<String,Any> = [
            "username":"lingen",
            "password":"123456",
            "nickname":"御剑",
            "mobile":"123456",
            "email":"lingen@foxmail.com"
        ]
        
        let request:HttpRequest = HttpRequest.jsonRequest(url: url, method: .HTTP_POST, params: params)
        
        let response:HttpResponse = try NetworkSession.sharedInstance().jsonRequest(request: request)
        
        if response.isRequestOk() {
            let result = response.excepedDictionayResult()
            print("结果 :\(String(describing: result))")
        }
    }
    
    
    func testPutJson() throws {
        let url:String = "http://localhost:8081/account/changePwd";
        
        let params:Dictionary<String,Any> = [
            "user_id":"123",
            "old_pwd":"123",
            "new_pwd":"123"
        ]
        
        let request:HttpRequest = HttpRequest.jsonRequest(url: url, method: .HTTP_PUT, params: params)
        
        let response:HttpResponse = try NetworkSession.sharedInstance().jsonRequest(request: request)
        
        if response.isRequestOk() {
            let result = response.excepedDictionayResult()
            print("结果 :\(result)")
        }
        
    }
    
    func testDeletJson() {
        
    }
    
}
