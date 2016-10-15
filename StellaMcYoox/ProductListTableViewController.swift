//
//  ProductListTableViewController.swift
//  StellaYooxTest
//
//  Created by CPM Development on 28/09/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//

import UIKit
import SVProgressHUD
import ReachabilitySwift

class ProductListTableViewController: UITableViewController {
    
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
        
        self.tableView.reloadData()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return StellaYooxSDK.arrayOfProducts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productCell", forIndexPath: indexPath) as! ProductCustomTableViewCell

        // Configure the cell...
        self.item = StellaYooxSDK.arrayOfProducts[indexPath.row]
        
        
        cell.setCell(item.MicroCategory!, price: "EUR \(String(item.FullPrice!)),00", productImage: item.productImage!)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        SVProgressHUD.show()
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let destinationMicroCategory = StellaYooxSDK.arrayOfProducts[indexPath.row].MicroCategory
            destinationViewController.microCategory = destinationMicroCategory!
            
            let destinationTitle = StellaYooxSDK.arrayOfProducts[indexPath.row].BrandName
            destinationViewController.productTitle = destinationTitle!

            
            let destinationPrice = String(StellaYooxSDK.arrayOfProducts[indexPath.row].FullPrice)
            destinationViewController.price = destinationPrice
            
            let destinationModelName = StellaYooxSDK.arrayOfProducts[indexPath.row].ModelNames
            destinationViewController.modelName = destinationModelName!
            
            if (StellaYooxSDK.arrayOfProducts[indexPath.row].productImage != nil) {
                let destinationProductId = StellaYooxSDK.arrayOfProducts[indexPath.row].DefaultCode10
                destinationViewController.productId = destinationProductId!
            }
            
            


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
