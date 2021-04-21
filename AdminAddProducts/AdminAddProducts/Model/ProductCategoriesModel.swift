//
//  ProductCategoriesModel.swift
//  AdminAddProducts
//
//  Created by Ashish Ashish on 4/20/21.
//

import Foundation

class ProductCategoriesModel{
    
    var categoryID: String = ""
    var name: String = ""
    var image: String = ""
    
    init(_ categoryID: String, _ name: String, _ image: String) {
        self.categoryID = categoryID
        self.name = name
        self.image = image
    }

    
}
