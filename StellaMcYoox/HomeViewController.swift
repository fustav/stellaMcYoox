//
//  HomeViewController.swift
//  StellaYooxTest
//
//  Created by CPM Development on 27/09/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//

import UIKit
import SVProgressHUD
import ReachabilitySwift

class HomeViewController: UIViewController {
    
    
    //MARK: IB OUTLET
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var category = ""
    
    var reachability: Reachability?
    
    
    //MARK: COLLECTION VIEW DATA SOURCE
    private var categories = Category.createCategories()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Sono sulla Home")
        
        //Logo su Navigation Top Bar
        let logo = UIImage(named: "stella-mccartney-logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
    }
    
    private struct Storyboard {
        static let CellIdentifier = "categoryCell"
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

        
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

//metodi ausiliari per Collection View
extension HomeViewController : UICollectionViewDataSource
{
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 //return 4 main product categories
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! CategoriesCustomCollectionViewCell
        
        cell.category = self.categories[indexPath.item]
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "productListCategory" {
            let destinationViewController = segue.destinationViewController as! ProductListTableViewController
            let indexPath = self.collectionView?.indexPathsForSelectedItems()!.first
            
            if ((self.reachability?.isReachable()) != false) {
            
                switch indexPath!.item {
                case 0:
                    //chiamo json per readyToWear
                    SVProgressHUD.show() //Loading circle Start!
                    StellaYooxSDK.arrayOfProducts = []
                    StellaYooxSDK.getJSON("Main_Ready_To_Wear")
                    print("Invoco la funzione per GET JSON")
                

                    self.category = "Main_Ready_To_Wear"
                    let destinationIdCategory = self.category
                    destinationViewController.category = destinationIdCategory
                
                case 1:
                    //chiamo json per accessories
                    SVProgressHUD.show()
                    StellaYooxSDK.arrayOfProducts = []
                    StellaYooxSDK.getJSON("Main_Accessories_All")

                    self.category = "Main_Accessories_All"
                    let destinationIdCategory = self.category
                    destinationViewController.category = destinationIdCategory
                
                case 2:
                    //chiamo json per beauty
                    SVProgressHUD.show()
                    StellaYooxSDK.arrayOfProducts = []
                
                    StellaYooxSDK.getJSON("Main_Beauty")

                    self.category = "Main_Beauty"
                    let destinationIdCategory = self.category
                    destinationViewController.category = destinationIdCategory

                case 3:
                    //chiamo json per lingerie
                    SVProgressHUD.show()
                    StellaYooxSDK.arrayOfProducts = []
                
                    StellaYooxSDK.getJSON("Main_Lingerie")

                
                    self.category = "Main_Lingerie"
                    let destinationIdCategory = self.category
                    destinationViewController.category = destinationIdCategory
                
                default:
                    break
                }
            } // End if reachable
            else {  // I AM OFFLINE
                getOfflineMessage()
            }
        }
    }

    
}

