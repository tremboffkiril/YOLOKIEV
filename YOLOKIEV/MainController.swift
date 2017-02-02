//
//  MainController.swift
//  YOLO
//
//  Created by Kiril on 25.07.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit

class MainController: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var bFacebook: UIButton!
    @IBOutlet weak var bTwitter: UIButton!
    @IBOutlet weak var bInstagram: UIButton!
    @IBOutlet weak var bVk: UIButton!
    
    
    @IBOutlet weak var vPortfolio: UIView!
    @IBOutlet weak var vSertificates: UIView!
    @IBOutlet weak var vNews: UIView!
    @IBOutlet weak var vWorking: UIView!
    @IBOutlet weak var vContacts: UIView!
    @IBOutlet weak var vPartners: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap1 = UITapGestureRecognizer(target: self, action: #selector(MainController.portfolioTap(_:)))
        tap1.delegate = self
        vPortfolio.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(MainController.newsTap(_:)))
        tap2.delegate = self
        vNews.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(MainController.contactsTap(_:)))
        tap3.delegate = self
        vContacts.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(MainController.sertificatesTap(_:)))
        tap4.delegate = self
        vSertificates.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(MainController.workingTap(_:)))
        tap5.delegate = self
        vWorking.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(MainController.partnersTap(_:)))
        tap6.delegate = self
        vPartners.addGestureRecognizer(tap6)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func portfolioTap(_ sender: UITapGestureRecognizer? = nil) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "portfolio") as! Portfolio
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func newsTap(_ sender: UITapGestureRecognizer? = nil) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "news") as! News
        
        self.present(vc, animated: true, completion: nil)
    }

    
    func contactsTap(_ sender: UITapGestureRecognizer? = nil) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "contacts") as! Contacts
        
        self.present(vc, animated: true, completion: nil)
    }

    
    func sertificatesTap(_ sender: UITapGestureRecognizer? = nil) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "sertificates") as! Sertificats
        
        self.present(vc, animated: true, completion: nil)
    }

    
    func partnersTap(_ sender: UITapGestureRecognizer? = nil) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "partners") as! Partners
        
        self.present(vc, animated: true, completion: nil)
    }

    
    func workingTap(_ sender: UITapGestureRecognizer? = nil) {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "working") as! Working
        
        self.present(vc, animated: true, completion: nil)
    }

    
    
    @IBAction func actionFacebook(_ sender: UIButton) {
        
        UIApplication.shared.openURL(URL(string: "https://www.facebook.com/kievyolo")!)
    }
    
    
    @IBAction func actionTwitter(_ sender: UIButton) {
         UIApplication.shared.openURL(URL(string: "https://twitter.com/yolokiev")!)
    }

    
    @IBAction func actionInstagram(_ sender: UIButton) {
         UIApplication.shared.openURL(URL(string: "https://www.instagram.com/yolokiev/")!)
    }
    
    @IBAction func actionVk(_ sender: UIButton) {
         UIApplication.shared.openURL(URL(string: "https://vk.com/yolokiev")!)
    }
    
    
}
