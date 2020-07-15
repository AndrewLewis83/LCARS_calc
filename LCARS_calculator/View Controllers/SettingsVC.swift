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
    
    // Warp core outlets
    @IBOutlet weak var warpCoreStackView: UIStackView!
    @IBOutlet weak var topCap: UIImageView!
    @IBOutlet weak var warpSectionOne: UIImageView!
    @IBOutlet weak var warpSectionTwo: UIImageView!
    @IBOutlet weak var warpSectionThree: UIImageView!
    @IBOutlet weak var warpSectionFour: UIImageView!
    @IBOutlet weak var warpSectionFive: UIImageView!
    @IBOutlet weak var centerSection: UIImageView!
    @IBOutlet weak var warpSectionSix: UIImageView!
    @IBOutlet weak var warpSectionSeven: UIImageView!
    @IBOutlet weak var warpSectionEight: UIImageView!
    @IBOutlet weak var warpSectionNine: UIImageView!
    @IBOutlet weak var warpSectionTen: UIImageView!
    @IBOutlet weak var bottomCap: UIImageView!
    
    //sound effects
    private var soundEffect: AVAudioPlayer?
    var sequence = 0
    private var timer = Timer()
    
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
        
        if (Settings.getMuteSetting() == false){
            muteButton.setBackgroundImage(UIImage(named: "LCARS_mute_button.png"), for: .normal)
            muteButton.setTitle(NSLocalizedString("mute audio", comment: ""), for: UIControl.State.normal)
        }else{
            muteButton.setBackgroundImage(UIImage(named: "LCARS_mute_button_2.png"), for: .normal)
            muteButton.setTitle(NSLocalizedString("unmute audio", comment: ""), for: UIControl.State.normal)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            bottomCap.transform = bottomCap.transform.rotated(by: .pi)
            configureIPadView()
        }else{
            warpCoreStackView.isHidden = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let viewControllers = navigationController?.viewControllers,
            let index = viewControllers.index(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
    }
    
    @IBAction func muteButtonPressed(_ sender: Any) {
        
        playSound()
        
        if (Settings.getMuteSetting() == false){
            Settings.setMuteSetting(newSetting: true)
            muteButton.setBackgroundImage(UIImage(named: "LCARS_mute_button_2.png"), for: .normal)
            muteButton.setTitle(NSLocalizedString("unmute audio", comment: ""), for: UIControl.State.normal)
        }else{
            Settings.setMuteSetting(newSetting: false)
            muteButton.setBackgroundImage(UIImage(named: "LCARS_mute_button.png"), for: .normal)
            muteButton.setTitle(NSLocalizedString("mute audio", comment: ""), for: UIControl.State.normal)
        }
        
        saveSettings() // if you call when the return button is pressed, it won't save in time. It probably needs a completion handler or something. Not a big deal here, though. 
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        
        playSound()
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
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        tipLabel.text = String(Int(sender.value)) + "% tip"
        Settings.setPercentTip(newTip: Int(sender.value))
        saveSettings()
    }
    
    
    func saveSettings(){
        UserDefaults.standard.set(Settings.getMuteSetting(), forKey: "muteSetting")
        UserDefaults.standard.set(Settings.getPercentTip(), forKey: "tipSetting")
    }
    
    func configureIPadView(){
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        
        warpSectionOne.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionOne.tintColor = warpColorOne
        warpSectionTwo.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionTwo.tintColor = warpColorOne
        warpSectionThree.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionThree.tintColor = warpColorOne
        warpSectionFour.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionFour.tintColor = warpColorOne
        warpSectionFive.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionFive.tintColor = warpColorOne
        warpSectionSix.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionSix.tintColor = warpColorOne
        warpSectionSeven.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionSeven.tintColor = warpColorOne
        warpSectionEight.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionEight.tintColor = warpColorOne
        warpSectionNine.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionNine.tintColor = warpColorOne
        warpSectionTen.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionTen.tintColor = warpColorOne
        
        warpSectionOne.tintColor = warpColorOne
           
    }
    
    @objc func counter(){
        
        sequence += 1
        
        if sequence > 3 {
            sequence = 0
        }
        
        if sequence == 0 {
            warpSectionOne.tintColor = warpColorOne
            warpSectionTwo.tintColor = warpColorTwo
            warpSectionThree.tintColor = warpColorThree
            warpSectionFour.tintColor = warpColorTwo
            warpSectionFive.tintColor = warpColorOne
            warpSectionSix.tintColor = warpColorTwo
            warpSectionSeven.tintColor = warpColorThree
            warpSectionEight.tintColor = warpColorTwo
            warpSectionNine.tintColor = warpColorOne
            warpSectionTen.tintColor = warpColorTwo
        }else if sequence == 1 {
            warpSectionOne.tintColor = warpColorTwo
            warpSectionTwo.tintColor = warpColorThree
            warpSectionThree.tintColor = warpColorTwo
            warpSectionFour.tintColor = warpColorOne
            warpSectionFive.tintColor = warpColorTwo
            warpSectionSix.tintColor = warpColorThree
            warpSectionSeven.tintColor = warpColorTwo
            warpSectionEight.tintColor = warpColorOne
            warpSectionNine.tintColor = warpColorTwo
            warpSectionTen.tintColor = warpColorThree
        }else if sequence == 2 {
            warpSectionOne.tintColor = warpColorThree
            warpSectionTwo.tintColor = warpColorTwo
            warpSectionThree.tintColor = warpColorOne
            warpSectionFour.tintColor = warpColorTwo
            warpSectionFive.tintColor = warpColorThree
            warpSectionSix.tintColor = warpColorTwo
            warpSectionSeven.tintColor = warpColorOne
            warpSectionEight.tintColor = warpColorTwo
            warpSectionNine.tintColor = warpColorThree
            warpSectionTen.tintColor = warpColorTwo
        }else if sequence == 3 {
            warpSectionOne.tintColor = warpColorTwo
            warpSectionTwo.tintColor = warpColorThree
            warpSectionThree.tintColor = warpColorTwo
            warpSectionFour.tintColor = warpColorOne
            warpSectionFive.tintColor = warpColorTwo
            warpSectionSix.tintColor = warpColorThree
            warpSectionSeven.tintColor = warpColorTwo
            warpSectionEight.tintColor = warpColorOne
            warpSectionNine.tintColor = warpColorTwo
            warpSectionTen.tintColor = warpColorThree
        }
        
    }
}
