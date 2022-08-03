//
//  LaunchScreenVC.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 12/24/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import UIKit

class LaunchScreenVC: UIViewController {
    
    @IBOutlet weak var federationLogo: UIImageView!
    @IBOutlet weak var federationNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("First launch: \(Settings.initialLaunch)")
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                        
            self.federationLogo.alpha = 1
            self.federationNameLabel.alpha = 1
        })
        
        UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                        
            self.federationLogo.alpha = 0
            self.federationNameLabel.alpha = 0
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

            if UIDevice.current.userInterfaceIdiom == .pad {
                
                self.performSegue(withIdentifier: "showiPadMain", sender: nil)

            }else{
                
                self.performSegue(withIdentifier: "showiPhoneMain", sender: nil)
            }
            
        }
    }
}
