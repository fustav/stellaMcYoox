//
//  StellaYooxSDK.swift
//  StellaYooxTest
//
//  Created by CPM Development on 28/09/16.
//  Copyright © 2016 CPM Development. All rights reserved.
//

/**
 Class: StellaYooxSDK
 
 getJSON for selected category
 
 Reachability functions

 */

import Foundation
import UIKit
import ReachabilitySwift

class StellaYooxSDK {
    
    
    static var stellaYooxRootAddress : String = "http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY_IT/search/results.json?ave=prod&productsPerPage=50&gender=D&page=1&department=Main_Ready_To_Wear&format=lite&sortRule=Ranking"
    
    static var arrayOfProducts: [Product] = []
    
    static var productImage: Image = Image()
    static var arrayOfImages: [Image] = []
    
    
    static func getJSON(department: String) {
        
        let requestURL: NSURL = NSURL(string: "http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY_IT/search/results.json?ave=prod&productsPerPage=50&gender=D&page=1&department=\(department)&format=lite&sortRule=Ranking")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everything is fine, file downloaded successfully.")
                print(httpResponse)
                print(response)
                print(data)
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    

                    if let topDictionary = json as? NSDictionary {
                        
                        if let resultsLiteDictionary = topDictionary["ResultsLite"] as? NSDictionary {
                            
                            if let itemsArray = resultsLiteDictionary["Items"] as? NSArray {
                                for itemDictionary in itemsArray {
                                    
                                    if let code8 = itemDictionary["Code8"] as? String {
                                        
                                        if let brandName = itemDictionary["BrandName"] as? String {
                                        
                                        if let defautlCode10 = itemDictionary["DefaultCode10"] as? String {
                                        
                                        if let microCategory = itemDictionary["MicroCategory"] as? String {
                                            print(microCategory)
                                    
                                        if let fullPrice = itemDictionary["FullPrice"] as? Int {
                                    
                                        if let modelNames = itemDictionary["ModelNames"] as? String {
                                            
                                            //Json data to arrayOfProducts
                                            let selectedProduct: Product = Product()
                                            selectedProduct.BrandName = brandName
                                            selectedProduct.Code8 = code8
                                            selectedProduct.DefaultCode10 = defautlCode10
                                            selectedProduct.FullPrice = fullPrice
                                            selectedProduct.MicroCategory = microCategory
                                            selectedProduct.ModelNames = modelNames
                                            print("Microcategory: \(selectedProduct.MicroCategory)")
                                            print("Quanti elementi ha l'array?")
                                            print(arrayOfProducts.count)
                                            
                                            
                                            dispatch_async(dispatch_get_main_queue(), {
                                              
                                            // DOWNLOAD Product IMAGE
                                            let imgURLString = "http://ypic.yoox.biz/ypic/stellamccartney/-resize/260/f/\(selectedProduct.DefaultCode10).jpg"
                                            //print("TEST: stampo l'urlString dell'immagine: \(imgURLString)")
                                             
                                             let imgURL = NSURL(string: imgURLString)
                                             //print("TEST: Stampo l'url dell'immagine\(imgURL!)")
                                             if (imgURL != nil) {
                                             let imageData = NSData(contentsOfURL: imgURL!)
                                             let image = UIImage(data: imageData!)
                                             selectedProduct.productImage = image
                                             }
                                             else {
                                             print("Impossibile salvare l'immagine perchè non esiste")
                                             }

                                            })
                                            
                                            StellaYooxSDK.arrayOfProducts.append(selectedProduct)

                                     }
                                   }
                                 }
                               }
                             }
                           }
                         }
                       }
                    }

                 }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
            } // END IF STATUS CODE == 200
        }
        task.resume()
    }
    
}

extension UIViewController {
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            getOfflineMessage()
        }
    }
    
    func getOfflineMessage() {
        print("Network not reachable")
        print("Internet connection FAILED")
        // Create alert view with actions: log out
        let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            print("OK Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}



