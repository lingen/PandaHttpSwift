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
    
    func testExample() {
        let defaultConfiguration = URLSessionConfiguration.default
        let semaphore = DispatchSemaphore.init(value: 0)
        let session:URLSession = URLSession(configuration: defaultConfiguration)
        let url = URL(string: "http://lingenliu.com")
        (session.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let response = response,
                let data = data,
                let string = String(data: data, encoding: .utf8) {
                print("Response: \(response)")
                print("DATA:\n\(string)\nEND DATA\n")
                print("----2222> 获取到了网页的完整内容了....")
            }
            semaphore.signal()
        }).resume()
        
        semaphore.wait()

        print("----3333> 这个会在异步调用之后才输出。。为什么?因为我们使用信号量把异步转成同步了嘛....")
    }
    
    func testGetJson() {
        let request:OPHRequest = OPHRequest.jsonRequest(url: "http://lingenliu.com", method: OPHRequestMethod.OPH_HTTP_GET)
        
        let response:OPHResponse = try! OPHNetWork.sharedInstance().syncRequest(request: request)
        
        if response.isRequestOk() {
            let result:String? = response.data.OPH_StringResult()
            print("返回结果\(result!)")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
