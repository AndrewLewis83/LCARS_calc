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
    
    @IBOutlet weak var upperBackgroundView: UIView!
    @IBOutlet weak var lowerBackgroundView: UIView!
    @IBOutlet weak var labelBackgroundView: UIView!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var returnButton: UIButton!
    
    //sound effects
    private var soundEffect: AVAudioPlayer?
    private var splitView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateInfoLabel()
        setupUI()
        adaptForCurrentSizeClass()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let viewControllers = navigationController?.viewControllers,
            let index = viewControllers.index(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        adaptForCurrentSizeClass()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        adaptForCurrentSizeClass()
    }
    
    
    func setupUI(){
        
        labelBackgroundView.layer.cornerRadius = 30
        labelBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

        
        upperBackgroundView.layer.cornerRadius = 30
        upperBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner]
        upperBackgroundView.backgroundColor = backgroundColorFour
        
        lowerBackgroundView.layer.cornerRadius = 30
        lowerBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner]

        lowerBackgroundView.backgroundColor = backgroundColorThree
        
    }
    
    func adaptForCurrentSizeClass(){
        
        infoTextView.textAlignment = NSTextAlignment.left
        
        // this formats the text for the iPad and prevents it from overflowing splitview.

        if UIDevice.current.userInterfaceIdiom == .pad {
            
            if traitCollection.horizontalSizeClass == .compact {
                // load slim view
                infoTextView.font = UIFont(name: "Okuda",
                size: 40.0)
            }else{
                infoTextView.font = UIFont(name: "Okuda",
                size: 80.0)
            }

        }else{
            
            infoTextView.font = UIFont(name: "Okuda",
            size: 40.0)
        }
    }
    
    func populateInfoLabel(){
        
        infoTextView.animate(newText: """
        This calculator app should be considered fan art. It is not meant for sale on the iOS App Store or anywhere else. I've always been a big Star Trek: TNG and Star Trek: Voyager fan, so this felt like a fun thing to build and use.

        Sound effects are from TrekCore.com
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

extension UITextView {
    
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
