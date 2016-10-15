//
//  DetailProductViewController.swift
//  StellaYooxTest
//
//  Created by CPM Development on 30/09/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailProductViewController: UIViewController { //BaseViewController //UIViewController
    
    var microCategory = ""
    var productTitle = ""
    var price = "default"
    var modelName = "Descrizione Default"
    var productId = ""
    
    
    @IBOutlet weak var modelNameLabel: UILabel!
    
    @IBOutlet weak var testoDescrizione: UITextView!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var microCategoryLabel: UILabel!
    
    @IBOutlet weak var productTileLabel: UILabel!

    
    // Set Big (750pixels) Product Image for selected product
    func setMainCover()  -> UIImage?{
        if (productId != "") {
            
            let imgURLString = "http://ypic.yoox.biz/ypic/stellamccartney/-resize/750/f/\(productId).jpg"
            //print("url foto è:\(url)")
            print("percorso completo: \(imgURLString)")
            
            let imgURL = NSURL(string: imgURLString)
            let imageData = NSData(contentsOfURL: imgURL!)
            let image = UIImage(data: imageData!)
            productImage.image = image
        }
        return nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        StellaYooxSDK.getMultipleImages("f", id2: "r", id3: "d", id4: "e", id5: "a", defaultCode: productId)

    }
    
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //set price label
        self.priceLabel.text = "EUR \(self.price),00"
        print("Product Description: \(modelName)")
        self.modelNameLabel.text = self.modelName
        print("Product MicroCategory: \(microCategory)")
        self.microCategoryLabel.text = self.microCategory
        
        self.productTileLabel.text = self.productTitle
        
        //Immagine
        setMainCover()
    
        StellaYooxSDK.arrayOfImages = []
        //StellaYooxSDK.getMultipleImages("f", id2: "r", id3: "d", id4: "e", id5: "a", defaultCode: productId)
        
        //Loading Complete
        SVProgressHUD.dismiss()
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

