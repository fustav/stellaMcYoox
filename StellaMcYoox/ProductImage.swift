//
//  ProductImage.swift
//  StellaMcYoox
//
//  Created by CPM Development on 03/10/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//


import Foundation
import UIKit

class ProductImage
{
    // MARK: - Public API
    var id = ""
    var featuredImage: UIImage!
    
    init(id: String, featuredImage: UIImage!)
    {
        self.id = id
        self.featuredImage = featuredImage
    }
    
    // MARK: - Private
    
    static func createProductImages() -> [ProductImage]
    {
        return [
            ProductImage(id: "f", featuredImage: UIImage(named: "readyTo")!),
            ProductImage(id: "r",  featuredImage: UIImage(named: "brody")!),
            ProductImage(id: "d",  featuredImage: UIImage(named: "beauty")!),
            ProductImage(id: "a", featuredImage: UIImage(named: "lingerie")!)
        ]
    }
}