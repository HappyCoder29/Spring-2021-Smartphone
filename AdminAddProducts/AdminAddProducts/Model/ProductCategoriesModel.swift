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
    var imageURL: String = ""
    
    init(categoryID: String, name: String, imageURL: String) {
        self.categoryID = categoryID
        self.name = name
        self.imageURL = imageURL
    }

    
}
