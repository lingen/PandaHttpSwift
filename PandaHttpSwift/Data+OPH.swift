//
//  Data+OPH.swift
//  PandaHttpSwift
//
//  Created by lingen on 16/9/19.
//  Copyright © 2016年 lingen. All rights reserved.
//

import Foundation

//Data的扩展，用于转换成希望的结果类型
extension Data {
    
    //返回 Data的 String类型
    func OPH_StringResult() -> String? {
        
        let dataString:String? = String(data: self, encoding: String.Encoding.utf8)
        
        return dataString
        
    }
    
    //将 DATA 转换为Dictionary类型
    func OPH_DictionaryResult() -> Dictionary<String,Any>? {
        
        let jsonResult:Dictionary<String,Any>? = try? JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableLeaves) as! Dictionary<String, Any>
        
        return jsonResult
    }
    
    
    
}
