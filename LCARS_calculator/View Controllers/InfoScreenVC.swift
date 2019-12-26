//
//  InfoScreenVC.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 5/18/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import UIKit
import AVFoundation

class InfoScreenVC: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    
    //sound effects
    private var soundEffect: AVAudioPlayer?
    private var splitView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateInfoLabel()
        setLabelValues()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let viewControllers = navigationController?.viewControllers,
            let index = viewControllers.index(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
    }
    
    func setLabelValues(){
        
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        infoLabel.textAlignment = NSTextAlignment.left
        
        // this formats the text for the iPad and prevents it from overflowing splitview.
        if UIDevice.current.model == "iPad"  && splitView == false && UIScreen.main.bounds.size.width > 1024.0 {
            infoLabel.font = UIFont(name: "Okuda",
            size: 65.0)
        }else{
            infoLabel.font = UIFont(name: "Okuda",
            size: 40.0)
        }
    }
    
    func populateInfoLabel(){
        
        infoLabel.animate(newText: """
        This calculator app should be considered fan art. It is not meant for sale on the iOS App Store or anywhere else. I just loved Star Trek: TNG and Star Trek: Voyager growing up, so this felt like a fun thing to build and use.
        
        Paramount, let me know if you want to make a deal ;)
        """, characterDelay: 0.01)
        
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        
        if Settings.getMuteSetting() == false {
            
            let buttonSoundPath = Bundle.main.path(forResource: "computerbeep_5.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: buttonSoundPath)
            
            do {
                soundEffect = try AVAudioPlayer(contentsOf: url)
                soundEffect?.play()
            } catch {
                // couldn't load sound file
                print("Couldn't load sound file in playSound()")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}

extension UILabel {
    
    func animate(newText: String, characterDelay: TimeInterval) {
        
        DispatchQueue.main.async {
            
            self.text = ""
            
            for (index, character) in newText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                    
                }
            }
        }
    }
}

extension InfoScreenVC {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.horizontalSizeClass != .regular {
            splitView = true
            
        } else {
            splitView = false
        }
        
        setLabelValues()
    }

}
