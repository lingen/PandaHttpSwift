//
//  OPHJsonStatusResult.swift
//  PandaHttpSwift
//
//  Created by lingen on 16/9/16.
//  Copyright © 2016年 lingen. All rights reserved.
//

import Foundation

class OPHJsonStatusResult: NSObject {
    
    static let OPHJsonStatusResult_STATUS:String = "status"
    
    static let OPHJsonStatusResult_RESULT:String = "result"
    
    static let OPHJsonStatusResult_MESSAGE = "message"
    
    var status:Int = 0
    
    var message:String = ""
    
    var result:NSDictionary = [:]
    
    
    func isResultSuccess() -> Bool {
        return self.status == 0
    }
    
}
