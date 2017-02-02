//
//  Portfolio.swift
//  YOLO
//
//  Created by Kiril on 25.07.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit
import MessageUI

class Portfolio: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate   {

    @IBOutlet weak var bBack: UIButton!
    
    @IBOutlet weak var cvPortfolio: UICollectionView!
    
    
    var photographers = [ContentPortfolio]()
    
    
    let portfolioURL = "http://yolo.kiev.ua/wp-json/wp/v2/posts?categories=24"

    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getLatestCollections()
        UIApplication.shared.statusBarStyle = .lightContent
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            if let indexPath = self.cvPortfolio?.indexPath(for: sender as! UICollectionViewCell){
                let destinationController = segue.destination as! AboutPhotographer
                
                
                destinationController.photographer = photographers[indexPath.row]
                
                
            }
        }
    }

    
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                
                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu") as! MainController
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromLeft
                view.window!.layer.add(transition, forKey: kCATransition)
                self.present(vc, animated: false, completion: nil)
                
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }

    

    
    
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
        return CGSize(width: collectionView.bounds.size.width/2 - 5, height: collectionView.bounds.size.width/2 - 5)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photographers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PorlfolioCell
        
        
        if let link = URL(string: photographers[(indexPath as NSIndexPath).row].imageURLOfTitle){
            
            ImageLoader.sharedLoader.imageForUrl(urlString: String(describing: link), completionHandler: { (image, url) in
                
                if image != nil{
                    cell.backgroundView = UIImageView(image: image)
                }
            })
        }
        else{
            
            cell.backgroundView = UIImageView(image: UIImage(named: photographers[(indexPath as NSIndexPath).row].imageURLOfTitle))
            
        }
        
        cell.lTextt.text = photographers[(indexPath as NSIndexPath).row].namePhotographer
        cell.lPrice.text = photographers[(indexPath as NSIndexPath).row].price
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu") as! MainController
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    func getLatestCollections(){
        let request = NSURLRequest(url: NSURL(string: portfolioURL)! as URL)
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
            
            if let error = error{
                print(error)
                return
            }
            
            if let data = data{
                
                self.photographers = self.parseJSONData(data: data as NSData)
                OperationQueue.main.addOperation({ () -> Void in
                    self.cvPortfolio.reloadData()
                })
                
            }
        })
        task.resume()
        
    }
    
    
    
    func parseJSONData(data: NSData) -> [ContentPortfolio]{
        
        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
            
            print(jsonResult)
            
           // var temp : [String : AnyObject]!
            //var jsonLoan : [AnyObject]!
            
            let jsonLoans = jsonResult as! [AnyObject]
            
            for jsonLoan in jsonLoans as! [NSDictionary]{
                
                let photographer = ContentPortfolio()
                
                let title = jsonLoan["title"] as! NSDictionary
                photographer.namePhotographer = title["rendered"] as! String
                
                print(photographer.namePhotographer)
                
                
                let price = jsonLoan["excerpt"] as! NSDictionary
                photographer.price = price["rendered"] as! String
                
                let str = photographer.price.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                
                photographer.price = str
                
                print(photographer.price)
                
                let imageArray = jsonLoan["title_image_link"] as! NSArray
                
                for temp in imageArray{
                
                    photographer.imageURLOfTitle = temp as! String
                
                }

                
                let arraysOfImages = jsonLoan["body_image_link"] as! NSArray
                photographer.imageURLs = arraysOfImages as! [String]
                
                print(arraysOfImages)
                
                
                
                
                photographers.append(photographer)
            }
            
        }catch {
            print(error)
        }
        
        return photographers
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
