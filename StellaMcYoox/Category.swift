//
//  Category.swift
//  StellaYooxTest
//
//  Created by CPM Development on 28/09/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//


import Foundation
import UIKit

class Category
{
    // MARK: - Public API
    var id = ""
    var title = ""
    var description = "" //A description may be useful for future releases
    var price = "€ 9,99"
    var featuredImage: UIImage!
    
    
    init(id: String, title: String, description: String, featuredImage: UIImage!)
    {
        self.id = id
        self.title = title
        self.description = description
        self.featuredImage = featuredImage
    }
    
    // MARK: - Private
    
    static func createCategories() -> [Category]
    {
        return [
            Category(id: "c1", title: "Ready To Wear", description: "Description Here", featuredImage: UIImage(named: "readyTo")!),
            Category(id: "c2", title: "Accessories", description: "Description Here", featuredImage: UIImage(named: "brody")!),
            Category(id: "c3", title: "Beauty", description: "Description Here", featuredImage: UIImage(named: "beauty")!),
            Category(id: "c4", title: "Lingerie", description: "Description Here", featuredImage: UIImage(named: "lingerie")!)
        ]
    }
}