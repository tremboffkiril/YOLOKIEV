//
//  AboutPhotographer.swift
//  YOLO
//
//  Created by Kiril on 25.07.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit
import MessageUI

class AboutPhotographer: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate  {

    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var bBack: UIButton!
    
    @IBOutlet weak var bBuy: UIButton!
    @IBOutlet weak var tvPhoto: UITableView!
    
    var index : Int! = 0
    
    var countOfCells : Int! = 0
    
    var namePhoto : String! = ""
  
    var photographer : ContentPortfolio!
    
    var photos : [String]!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photos = photographer.imageURLs
        print(photos)
        lName.text! = photographer.namePhotographer
        UIApplication.shared.statusBarStyle = .lightContent
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
               
                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "portfolio") as! Portfolio
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photographer.imageURLs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tvPhoto.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
      
        
        
        
        
        if let link = URL(string: photographer.imageURLs[(indexPath as NSIndexPath).row]){
            
            ImageLoader.sharedLoader.imageForUrl(urlString: String(describing: link), completionHandler: { (image, url) in
                
                if image != nil{
                    cell.imPhoto?.image = image!
                }
            })
        }
        else{
            
            cell.imPhoto?.image = UIImage(named: photographer.imageURLs[(indexPath as NSIndexPath).row])!
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
    
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    
    @IBAction func actionBack(_ sender: UIButton) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "portfolio") as! Portfolio
        
        self.present(vc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func actionBuy(_ sender: UIButton) {
        
        showEmail()
    }
    
    
    func showEmail(){
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let emailTitle = "YOLO Company"
        let messageBody = "Ordered to shoot:  " + lName.text! + "\n" + "Yout phone number :  " + "\n" + "Your name: "
        let toRecipients = ["info@yolo.kiev.ua"]
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailTitle)
        mailComposer.setMessageBody(messageBody, isHTML: false)
        mailComposer.setToRecipients(toRecipients)
        
        present(mailComposer, animated: true, completion: nil)
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue{
            
        case MFMailComposeResult.cancelled.rawValue: print("Cancel")
        case MFMailComposeResult.sent.rawValue: print("Sent")
        case MFMailComposeResult.saved.rawValue: print("Saved")
        case MFMailComposeResult.failed.rawValue: print("Fail")
        default: break
            
        }
        dismiss(animated: true, completion: nil)
    }
    

    
    
}
