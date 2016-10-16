//
//  ProductListCollectionViewController.swift
//  StellaMcYoox
//
//  Created by Maria Piscopo on 16/10/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import ReachabilitySwift

class ProductListCollectionViewController: UICollectionViewController {
    
    var category = ""
    var item : Product = Product()
    
    
    
    func setImage() {
        if self.category == "Main_Accessories_All" {
            //Logo su Navigation Top Bar
            let logo = UIImage(named: "accessories.pdf")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
        }
        else if self.category == "Main_Ready_To_Wear" {
            //Logo su Navigation Top Bar
            let logo = UIImage(named: "readyToWear.pdf")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
        }
        else if self.category == "Main_Beauty" {
            //Logo su Navigation Top Bar
            let logo = UIImage(named: "beautyNavigation.pdf")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
        }
        else {
            //Logo su Navigation Top Bar
            let logo = UIImage(named: "lingerieNavigation.pdf")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("La categoria selezionata è = \(self.category)")
        print(StellaYooxSDK.arrayOfProducts.count)
        
        setImage()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        self.collectionView!.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.collectionView!.reloadData()
        SVProgressHUD.dismiss()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StellaYooxSDK.arrayOfProducts.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("productCell", forIndexPath: indexPath) as! ProductListCustomCollectionViewCell

        
        // Configure the cell...
        self.item = StellaYooxSDK.arrayOfProducts[indexPath.item]
        
        // DOWNLOAD Product IMAGE
        
        let imgURLString = "http://ypic.yoox.biz/ypic/stellamccartney/-resize/260/f/\(StellaYooxSDK.arrayOfProducts[indexPath.item].DefaultCode10).jpg"
        
        let cache = ImageLoadingWithCache()
        cache.getImage(imgURLString, imageView: cell.productImage, defaultImage: "\(StellaYooxSDK.arrayOfProducts[indexPath.item].DefaultCode10)")
        
        //cell.setCell(item.MicroCategory!, price: "EUR \(String(item.FullPrice!)),00", productImage: item.productImage!)
        cell.setTitleLabelandPrice(item.MicroCategory!, price: "EUR \(String(item.FullPrice!)),00")
        
        return cell
    }
  
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        SVProgressHUD.show()
    }
    
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        
        return true
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "detailVC" {
            print("SEGUE TO DETAIL")
            
            let destinationViewController = segue.destinationViewController as! NewDetailProductViewController

            let indexPath: NSIndexPath = (self.collectionView?.indexPathsForSelectedItems()!.first)!

            
            let destinationMicroCategory = StellaYooxSDK.arrayOfProducts[indexPath.item].MicroCategory
            destinationViewController.microCategory = destinationMicroCategory!
            
            let destinationTitle = StellaYooxSDK.arrayOfProducts[indexPath.item].BrandName
            destinationViewController.productTitle = destinationTitle!
            
            
            let destinationPrice = String(StellaYooxSDK.arrayOfProducts[indexPath.item].FullPrice)
            destinationViewController.price = destinationPrice
            
            let destinationModelName = StellaYooxSDK.arrayOfProducts[indexPath.item].ModelNames
            destinationViewController.modelName = destinationModelName!
            
            let destinationProductId = StellaYooxSDK.arrayOfProducts[indexPath.item].DefaultCode10
            destinationViewController.productId = destinationProductId!
            
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //declare this property where it won't go out of scope relative to your listener
        var reachability: Reachability?
        
        //declare this inside of viewWillAppear
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProductListTableViewController.reachabilityChanged(_:)),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
}
