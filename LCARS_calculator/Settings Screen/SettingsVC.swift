//
//  SettingsVC.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 5/24/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsVC: UIViewController {
    
    @IBOutlet weak var sliderBackgroundView: UIView!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    
    //Background view stacks
    @IBOutlet weak var warpCoreBackgroundStack: UIStackView!
    @IBOutlet weak var leftOne: UIView!
    @IBOutlet weak var leftTwo: UIView!
    @IBOutlet weak var leftThree: UIView!
    @IBOutlet weak var leftFour: UIView!
    @IBOutlet weak var topCenter: UIView!
    @IBOutlet weak var topRight: UIView!
    @IBOutlet weak var rightTwo: UIView!
    @IBOutlet weak var rightThree: UIView!
    @IBOutlet weak var bottomCenter: UIView!
    @IBOutlet weak var bottomRight: UIView!
    
    private let warpCore = WarpCore()
    
    //sound effects
    private var soundEffect: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            sliderBackgroundView.layer.borderColor = borderColor
        }
        
        sliderBackgroundView.layer.borderWidth = 5
        sliderBackgroundView.layer.cornerRadius = 20
        
        tipSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        tipLabel.text = String(Settings.getPercentTip()) + "% tip"
        tipSlider.setValue(Float(Settings.getPercentTip()), animated: false)
        
        muteButton.layer.cornerRadius = muteButton.frame.height/2
        
        if (Settings.getMuteSetting() == false){
            muteButton.backgroundColor = buttonColorFive
            muteButton.setTitle(NSLocalizedString("mute audio", comment: ""), for: UIControl.State.normal)
        }else{
            muteButton.backgroundColor = UIColor.red
            muteButton.setTitle(NSLocalizedString("unmute audio", comment: ""), for: UIControl.State.normal)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
             
            setUpBackground()
            
        }else{
            warpCoreBackgroundStack.isHidden = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let viewControllers = navigationController?.viewControllers,
            let index = viewControllers.index(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
    }
    
    func configureForDevice(){
        
        if UIDevice.modelName == "iPod touch (5th generation)" || UIDevice.modelName == "iPod touch (6th generation)" || UIDevice.modelName == "iPod touch (7th generation)" {
            sliderBackgroundView.isHidden = true
        }
    }
    
    @IBAction func muteButtonPressed(_ sender: Any) {
        
        playSound()
        
        if (Settings.getMuteSetting() == false){
            Settings.setMuteSetting(newSetting: true)
            muteButton.backgroundColor = UIColor.red
            muteButton.setTitle(NSLocalizedString("unmute audio", comment: ""), for: UIControl.State.normal)
        }else{
            Settings.setMuteSetting(newSetting: false)
            muteButton.backgroundColor = buttonColorFive
            muteButton.setTitle(NSLocalizedString("mute audio", comment: ""), for: UIControl.State.normal)
        }
        
        saveSettings() // if you call when the return button is pressed, it won't save in time. It probably needs a completion handler or something. Not a big deal here, though. 
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        
        playSound()
        warpCore.stopWarpCore()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func playSound() {
        
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
    }
    
    func setUpBackground(){
        
        leftOne.backgroundColor = backgroundColorOne
        leftOne.layer.cornerRadius = 30
        leftOne.layer.maskedCorners = [.layerMinXMinYCorner]
        leftTwo.backgroundColor = backgroundColorTwo
        leftThree.backgroundColor = backgroundColorOne
        leftFour.backgroundColor = backgroundColorOne
        leftFour.layer.cornerRadius = 30
        leftFour.layer.maskedCorners = [.layerMinXMaxYCorner]
        topCenter.backgroundColor = backgroundColorOne
        topRight.backgroundColor = backgroundColorOne
        topRight.layer.cornerRadius = 15
        topRight.layer.maskedCorners = [.layerMaxXMinYCorner]
        rightTwo.backgroundColor = .black
        rightThree.backgroundColor = .black
        bottomCenter.backgroundColor = backgroundColorOne
        bottomRight.backgroundColor = backgroundColorOne
        bottomRight.layer.cornerRadius = 15
        bottomRight.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        configureWarpCore()
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        tipLabel.text = String(Int(sender.value)) + "% tip"
        Settings.setPercentTip(newTip: Int(sender.value))
        saveSettings()
    }
    
    
    func saveSettings(){
        UserDefaults.standard.set(Settings.getMuteSetting(), forKey: "muteSetting")
        UserDefaults.standard.set(Settings.getPercentTip(), forKey: "tipSetting")
    }
    
    func configureWarpCore(){
        
        view.insertSubview(warpCore, at: 2)
        
        warpCore.translatesAutoresizingMaskIntoConstraints = false
        warpCore.rightAnchor.constraint(equalTo: warpCoreBackgroundStack.rightAnchor).isActive = true
        warpCore.bottomAnchor.constraint(equalTo: warpCoreBackgroundStack.bottomAnchor, constant: -30).isActive = true
        warpCore.leftAnchor.constraint(equalTo: warpCoreBackgroundStack.leftAnchor, constant: 120).isActive = true
        warpCore.topAnchor.constraint(equalTo: warpCoreBackgroundStack.topAnchor, constant: 30).isActive = true
        
        adjustForSizeClass()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        adjustForSizeClass()
    }
    
    func adjustForSizeClass(){
        if traitCollection.horizontalSizeClass == .compact {
            warpCoreBackgroundStack.isHidden = true
            warpCore.isHidden = true
        } else {
            warpCoreBackgroundStack.isHidden = false
            warpCore.isHidden = false
        }
    }

}
