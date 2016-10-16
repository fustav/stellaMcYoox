//
//  NewDetailViewController.swift
//  StellaMcYoox
//
//  Created by CPM Development on 03/10/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//

import UIKit
import SVProgressHUD

class NewDetailProductViewController: UIViewController {
    
    var microCategory = ""
    var productTitle = ""
    var price = "default"
    var modelName = "Descrizione Default"
    var productId = ""
    
    //MARK: COLLECTION VIEW DATA SOURCE
    private var productImages = ProductImage.createProductImages()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var modelNameLabel: UILabel!
    
    @IBOutlet weak var testoDescrizione: UITextView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var microCategoryLabel: UILabel!
    
    @IBOutlet weak var productTileLabel: UILabel!
    
    
    // Set Big (750pixels) Product Image for selected product
    /*func setMainCover()  -> UIImage?{
        if (productId != "") {
            
            let imgURLString = "http://ypic.yoox.biz/ypic/stellamccartney/-resize/750/f/\(productId).jpg"
            //print("url foto è:\(url)")
            print("percorso completo di NEW: \(imgURLString)")
            
            let imgURL = NSURL(string: imgURLString)
            let imageData = NSData(contentsOfURL: imgURL!)
            let image = UIImage(data: imageData!)
            //productImage.featuredImageView = image

        }
        return nil
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        
        self.collectionView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        print("sono dentro NEW")
        
        //set price label
        self.priceLabel.text = "EUR \(self.price),00"
        print("Product Description: \(modelName)")
        self.modelNameLabel.text = self.modelName
        print("Product MicroCategory: \(microCategory)")
        self.microCategoryLabel.text = self.microCategory
        
        self.productTileLabel.text = self.productTitle
        
        //Immagine
        //setMainCover()
        
        
        dispatch_async(dispatch_get_main_queue(), {
            StellaYooxSDK.arrayOfImages = []

            StellaYooxSDK.getMultipleImages("f", id2: "r", id3: "d", id4: "e", id5: "a", defaultCode: self.productId)
            
            self.collectionView.reloadData()
        })
       
        
        //collectionView.reloadData()
        print(StellaYooxSDK.arrayOfImages.count)
        
        //Loading Complete
        SVProgressHUD.dismiss()

        
    }
    
}



//metodi ausiliari per Collection View
extension NewDetailProductViewController : UICollectionViewDataSource
{
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StellaYooxSDK.arrayOfImages.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ProductCustomCollectionViewCell
        
        cell.productImage = StellaYooxSDK.arrayOfImages[indexPath.item]
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    }
    
    
}

