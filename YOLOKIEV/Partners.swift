//
//  Partners.swift
//  YOLO
//
//  Created by Kiril on 25.07.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit

class Partners: UIViewController {

    @IBOutlet weak var bFushion: UIButton!
    @IBOutlet weak var bBack: UIButton!
    @IBOutlet weak var bUWDC: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)

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
    
    @IBAction func actionFus(_ sender: UIButton) {
        
        UIApplication.shared.openURL(URL(string: "http://fusionstudio.com.ua/")!)
        
    }
    @IBAction func actionUWDC(_ sender: UIButton) {
        
        UIApplication.shared.openURL(URL(string: "http://uwdc.com.ua/")!)
    }

}
