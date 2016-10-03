//
//  ProductCustomCollectionViewCell.swift
//  
//
//  Created by CPM Development on 03/10/16.
//
//

import UIKit

class ProductCustomCollectionViewCell: UICollectionViewCell {
    //MARK: - Public API
    var productImage: Image! {
        didSet {
            updateUI()
        }
    }
    
    
    //MARK: - Private
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    var copertina: UIImage?
    var prezzo: String?
    
    private func updateUI() {
        //productTitleLabel?.text! = productImage.id
        featuredImageView?.image! = productImage.featuredImageView!
    }
    
}

class Image: NSObject {
    var featuredImageView: UIImage?
}
