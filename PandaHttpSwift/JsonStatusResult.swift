//
//  OPHJsonStatusResult.swift
//  PandaHttpSwift
//
//  Created by lingen on 16/9/16.
//  Copyright © 2016年 lingen. All rights reserved.
//

import Foundation

public class OPHJsonStatusResult: NSObject {
    
    static let OPHJsonStatusResult_STATUS:String = "status"
    
    static let OPHJsonStatusResult_RESULT:String = "result"
    
    static let OPHJsonStatusResult_MESSAGE = "message"
    
    public var status:Int = 0
    
    public var message:String = ""
    
    public var result:NSDictionary = [:]
    
    
    public func isResultSuccess() -> Bool {
        return self.status == 0
    }
    
}
