//
//  Sertificats.swift
//  YOLO
//
//  Created by Kiril on 25.07.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit

class Sertificats: UIViewController {

    @IBOutlet weak var imSertOne: UIImageView!
    @IBOutlet weak var imSerTwo: UIImageView!
    @IBOutlet weak var bBack: UIButton!
    @IBOutlet weak var imSertthree: UIImageView!
    
    var imageSertificates = [
                                "http://res.cloudinary.com/dlqqxkloe/image/upload/c_scale,w_400/v1456950652/IMG_7571_f7ls4w.jpg",
                                "http://res.cloudinary.com/dlqqxkloe/image/upload/c_scale,w_400/v1456950307/IMG_7554_nslkzb.jpg",
                                "http://res.cloudinary.com/dlqqxkloe/image/upload/c_scale,w_400/v1456950343/IMG_7592_cbjcxi.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ImageLoader.sharedLoader.imageForUrl(urlString: "https://res.cloudinary.com/dlqqxkloe/image/upload/c_scale,w_400/v1456950652/IMG_7571_f7ls4w.jpg", completionHandler:{(image: UIImage?, url: String) in
            self.imSertOne.image = image!
        })
        
        ImageLoader.sharedLoader.imageForUrl(urlString: "https://res.cloudinary.com/dlqqxkloe/image/upload/c_scale,w_400/v1456950307/IMG_7554_nslkzb.jpg", completionHandler:{(image: UIImage?, url: String) in
            self.imSerTwo.image = image!
        })

        ImageLoader.sharedLoader.imageForUrl(urlString: "https://res.cloudinary.com/dlqqxkloe/image/upload/c_scale,w_400/v1456950343/IMG_7592_cbjcxi.jpg", completionHandler:{(image: UIImage?, url: String) in
            self.imSertthree.image = image!
        })
        
        
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
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    
}
