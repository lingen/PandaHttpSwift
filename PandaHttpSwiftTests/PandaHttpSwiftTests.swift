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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetJson() {
        let request:OPHRequest = OPHRequest.jsonRequest(url: "http://openpanda.org:8081/account/search?search=l&page=1&pagesize=10", method: .OPH_HTTP_GET)
        
        let response:OPHResponse = try! OPHNetWork.sharedInstance().syncRequest(request: request)
        
        if response.isRequestOk() {
            let result:String? = response.data.OPH_StringResult()
            print("返回结果\(result!)")
        }
    }
    
    func testPostJson() {
        let url:String = "http://openpanda.org:8081/account";
        
        let params:Dictionary<String,Any> = [
            "username":"lingen",
            "password":"123456",
            "nickname":"御剑",
            "mobile":"123456",
            "email":"lingen@foxmail.com"
        ]
        
        let request:OPHRequest = OPHRequest.jsonRequest(url: url, method: .OPH_HTTP_POST, params: params)
        
        let response:OPHResponse = try! OPHNetWork.sharedInstance().syncRequest(request: request)
        
        if response.isRequestOk() {
            let result = response.data.OPH_JsonResult()
            
            print("结果 :\(result)")
        }
    }
    
    
    func testPutJson() {
        let url:String = "http://openpanda.org:8081//account/changePwd";
        
        let params:Dictionary<String,Any> = [
            "user_id":"123",
            "old_pwd":"123",
            "new_pwd":"123"
        ]
        
        let request:OPHRequest = OPHRequest.jsonRequest(url: url, method: .OPH_HTTP_PUT, params: params)
        
        let response:OPHResponse = try! OPHNetWork.sharedInstance().syncRequest(request: request)
        
        if response.isRequestOk() {
            
            let result = response.data.OPH_JsonResult()
            
            print("结果 :\(result)")
            
        }

    }
    
    func testDeletJson() {
        
    }
    
}
