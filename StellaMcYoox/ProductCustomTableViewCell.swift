//
//  ProductCustomTableViewCell.swift
//  StellaYooxTest
//
//  Created by CPM Development on 28/09/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//

import UIKit

class ProductCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    //var ascoltato = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(title: String, price: String, productImage: UIImage) {
        self.title.text = title
        self.price.text = String(price)
        self.productImage.image = productImage
    }
    
    
    func setTitleLabel(title: String) {
        self.title.text = title
    }
    
    func setTitleLabelandPrice(title: String, price: String) {
        self.title.text = title
        self.price.text = price
    }
    
    func setItemImage(productImage: UIImage) {
        self.productImage.image = productImage
    }
    
}
