//
//  Contacts.swift
//  YOLO
//
//  Created by Kiril on 25.07.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit
import MessageUI

class Contacts: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var bBack: UIButton!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfNumber: UITextField!
    @IBOutlet weak var tfMessage: UITextView!
    @IBOutlet weak var bSend: UIButton!
    @IBOutlet weak var vFormToSent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfMessage.layer.cornerRadius = tfMessage.frame.height / 10
        tfMessage.clipsToBounds = true
        
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
    
    @IBAction func actionBack(_ sender: UIButton) {
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu") as! MainController
        
        self.present(vc, animated: true, completion: nil)
    }

    
    @IBAction func actionSend(_ sender: UIButton) {
        
        
        if tfName.text == "" || tfNumber.text == "" || tfMessage.text == "" || tfEmail.text == ""{
            let alert = UIAlertController(title: "Error", message:"Enter full information", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }else{
            showEmail()
        }
    }
    
    func showEmail(){
        guard MFMailComposeViewController.canSendMail() else {
         return
        }
        
        let emailTitle = "YOLO Company"
        let messageBody = tfMessage.text! + "\n" + "Number of Client:  " + tfNumber.text! + "\n" + "Name:  " + tfName.text!
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
    
    
    //Name keyboard on
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(tfName, moveDistance: -250, up: true)
        
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(tfName, moveDistance: -250, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfName.resignFirstResponder()
        
        return true
    }
    
    
    //Email keyboard on
    
  
    
     func textFieldDidBeginEditing2(_ textField: UITextField) {
        moveTextField2(tfEmail, moveDistance: -250, up: true)
        
    }
    
    // Finish Editing The Text Field
   func textFieldDidEndEditing2(_ textField: UITextField) {
        moveTextField2(tfEmail, moveDistance: -250, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    @objc(textFieldShouldClear:) func textFieldShouldClear(_ textField: UITextField) -> Bool {
        tfEmail.resignFirstResponder()
        
        return true
    }

    
    
    
    
    //Number keyboard on
    
   
    
    
     func textFieldDidBeginEditing3(_ textField: UITextField) {
        moveTextField3(tfNumber, moveDistance: -250, up: true)
        
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing3(_ textField: UITextField) {
        moveTextField3(tfNumber, moveDistance: -250, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn3(_ textField: UITextField) -> Bool {
        tfNumber.resignFirstResponder()
        
        return true
    }
    
    
    //Massage keyboard on
    
    
    
    
     func textViewDidBeginEditing(_ textView: UITextView) {
        moveTextView(tfMessage, moveDistance: -250, up: true)
        
    }
    
    // Finish Editing The Text Field
    func textViewDidEndEditing(_ textView: UITextView) {
        moveTextView(tfMessage, moveDistance: -250, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textМшуцShouldReturn3(_ textvIEW: UITextView) -> Bool {
        tfMessage.resignFirstResponder()
        
        return true
    }


    
                    // Move the text field in a pretty animation!
    
    //Name keyboard on
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    //Email keyboard on
    
    func moveTextField2(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    //Number keyboard on

    
    func moveTextField3(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    //Massage keyboard on


    func moveTextView(_ textView: UITextView, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
