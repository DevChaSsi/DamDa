//
//  RefreshValue.swift
//  DamDa
//
//  Created by SeonHo Cha on 2023/02/02.
//

import Foundation

class RefreshValue {
    public var refreshValue = false
    
    struct StaticInstance {
        static var instance: RefreshValue?
    }
    
    class func SharedInstance() -> RefreshValue {
        if StaticInstance.instance == nil {
            StaticInstance.instance = RefreshValue()
        }
        return StaticInstance.instance!
    }
}
