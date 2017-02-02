//
//  News.swift
//  YOLO
//
//  Created by Kiril on 25.07.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit

class News: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tvNews: UITableView!
    @IBOutlet weak var bBack: UIButton!
      
    let newsURL = "http://yolo.kiev.ua/wp-json/wp/v2/posts?categories=22"
    var loans = [NewsLoan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       getLatestLoans()

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        UIApplication.shared.statusBarStyle = .lightContent

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    

    @IBAction func actionBack(_ sender: UIButton) {
       
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu") as! MainController
        
        self.present(vc, animated: true, completion: nil)
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return loans.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tvNews.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsCell
        
        cell.lNameNews?.text = loans[indexPath.row].nameNews
        cell.tvAboutNews?.text = loans[indexPath.row].aboutNews
        
  
        if let link = URL(string: loans[(indexPath as NSIndexPath).row].imageURL){
            
            ImageLoader.sharedLoader.imageForUrl(urlString: String(describing: link), completionHandler: { (image, url) in
                
                if image != nil{
                    cell.imImageNews?.image = image!
                }
            })
        }
        else{
            
            cell.imImageNews?.image = UIImage(named: loans[(indexPath as NSIndexPath).row].imageURL)!
        }

        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }

   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func getLatestLoans(){
        let request = NSURLRequest(url: NSURL(string: newsURL)! as URL)
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
            
            if let error = error{
                print(error)
                return
            }
            
            if let data = data{
                
                self.loans = self.parseJSONData(data: data as NSData)
                OperationQueue.main.addOperation({ () -> Void in
                    self.tvNews.reloadData()
                })
            
            }
        })
        task.resume()
        
    }
    
    
    func parseJSONData(data: NSData) -> [NewsLoan]{
        
        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
            
            print(jsonResult)
            
            let jsonLoans = jsonResult as! [AnyObject]
            for jsonLoan in jsonLoans as! [NSDictionary]{
  
                
                let loan = NewsLoan()
                
                let titleNews = jsonLoan["title"] as! NSDictionary
                
                loan.nameNews = titleNews["rendered"] as! String
               
                print(loan.nameNews)
                
                
                let content = jsonLoan["content"] as! NSDictionary
                
                loan.aboutNews = content["rendered"] as! String
          
                
                
                let str = loan.aboutNews.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                
                loan.aboutNews = str
                
                
                let imageArray = jsonLoan["title_image_link"] as! NSArray
                
                for temp in imageArray{
                    
                    loan.imageURL = temp as! String
                    
                }
                
                
                loans.append(loan)
            }
        
        }catch {
            print(error)
        }
        
        return loans
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

}
