//
//  CategoriesCustomCollectionViewCell.swift
//  StellaYooxTest
//
//  Created by CPM Development on 03/10/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//

import UIKit

class CategoriesCustomCollectionViewCell: UICollectionViewCell {
    //MARK: - Public API
    var category: Category! {
        didSet {
            updateUI()
        }
    }

    
    //MARK: - Private
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    var copertina: UIImage?
    var prezzo: String?
    
    private func updateUI() {
        categoryTitleLabel?.text! = category.title
        featuredImageView?.image! = category.featuredImage
    }
    
    /*private func updateUICategories() {
        categoryTitleLabel?.text! = raccoltaStore.title
        featuredImageView?.image! = raccoltaStore.featuredImage
    }*/
    
    func setCell(title: String, copertina: UIImage){
        self.categoryTitleLabel.text = title
        self.copertina = copertina
    }
    
}
