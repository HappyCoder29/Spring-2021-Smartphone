//
//  Utilities.swift
//  AdminAddProducts
//
//  Created by Ashish Ashish on 14/04/21.
//

import Foundation
extension String{
    
    var isEMail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
