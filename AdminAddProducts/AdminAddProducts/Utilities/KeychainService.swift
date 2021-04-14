//
//  KeychainService.swift
//  AdminAddProducts
//
//  Created by Ashish Ashish on 14/04/21.
//

import Foundation
import KeychainSwift

class KeychainService{
    
    var _localVar = KeychainSwift()
    
    var keyChain : KeychainSwift{
        get {
            return _localVar
        }
        set {
            _localVar = newValue
        }
    }
    
}
