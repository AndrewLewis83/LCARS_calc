//
//  ViewController.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 2/23/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import UIKit
import AVFoundation

class iPhoneMainVC: UIViewController {
    
    @IBOutlet weak var readoutBackgroundView: UIView!
    @IBOutlet weak var readoutBlackBackgroundPanel: UIView!
    
    @IBOutlet weak var mainPanelBackground: UIView!
    @IBOutlet weak var mainPanelBlackBackground: UIView!
  
    // number buttons
    @IBOutlet weak var one_button: UIButton!
    @IBOutlet weak var two_button: UIButton!
    @IBOutlet weak var three_button: UIButton!
    @IBOutlet weak var four_button: UIButton!
    @IBOutlet weak var five_button: UIButton!
    @IBOutlet weak var six_button: UIButton!
    @IBOutlet weak var seven_button: UIButton!
    @IBOutlet weak var eight_button: UIButton!
    @IBOutlet weak var nine_button: UIButton!
    @IBOutlet weak var zero_button: UIButton!
    @IBOutlet weak var decimal_point_button: UIButton!
    @IBOutlet weak var clear_button: UIButton!
    @IBOutlet weak var backspaceButton: UIButton!
    
    // function buttons
    @IBOutlet weak var division_button: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var subtractionButton: UIButton!
    @IBOutlet weak var additionButton: UIButton!
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var negativePositiveButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var mainReadout: UILabel!
    @IBOutlet weak var secondaryReadout: UILabel!
    
    private var cornerRadius: CGFloat = 0
    private var spacing: CGFloat = 0
    @IBOutlet weak var mainStackViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var firstRowStackView: UIStackView!
    @IBOutlet weak var secondRowStackView: UIStackView!
    @IBOutlet weak var thirdRowStackView: UIStackView!
    @IBOutlet weak var fourthRowStackView: UIStackView!
    @IBOutlet weak var fifthRowStackView: UIStackView!
    @IBOutlet weak var extraButtonsStackView: UIStackView!
    
    //sound effects
    private var soundEffect: AVAudioPlayer?
    private let errorSoundPath = Bundle.main.path(forResource: "consolewarning.mp3", ofType:nil)!
    private let buttonSoundPath = Bundle.main.path(forResource: "computerbeep_5.mp3", ofType:nil)!
    private let alertSoundPath = Bundle.main.path(forResource: "computerbeep_13.mp3", ofType:nil)!

    //variables
    private var _hasDecimal = false
    private var _mainValue: Double = 0
    private var _secondaryValue: Double = 0
    private var _currentOperation = CurrentOperation.addition
    private var _typingInProgress = false
    private enum CurrentOperation {
        
        case addition, subtraction, multiplication, division
        
        func simpleDescription() -> String {
            switch self {
            case .addition:
                return "addition"
            case .subtraction:
                return "discrete"
            case .multiplication:
                return "multiplication"
            case .division:
                return "division"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainReadout.text = "0.0"
        secondaryReadout.text = "Enter value"
        loadUserDefaults()
        tipButton.setTitle(String(Settings.getPercentTip()) + "%", for: .normal)
        setModelConstraints(modelName: UIDevice.modelName)
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UIDevice.modelName != "iPod touch (5th generation)" && UIDevice.modelName != "iPod touch (6th generation)" && UIDevice.modelName != "iPod touch (7th generation)" {
            tipButton.setTitle(String(Settings.getPercentTip()) + "%", for: .normal)
        }

    }
    
    func setModelConstraints(modelName: String){
        print(modelName)
        
        if modelName == "iPhone 12 Pro Max" {
        
            cornerRadius = 40
            spacing = 8
            
        } else if modelName == "iPhone 12 mini" {

            cornerRadius = 35
            spacing = 4
            
        } else if modelName == "iPhone SE (2nd generation)" || modelName == "iPhone 7" || modelName == "iPhone 8" {
            
            cornerRadius = 30
            spacing = 4
            infoButton.isHidden = true
            copyButton.frame.size.height = 45
            settingsButton.frame.size.height = 45
            mainStackViewBottomConstraint.constant = spacing
            
        } else if modelName == "iPod touch (5th generation)" || modelName == "iPod touch (6th generation)" || modelName == "iPod touch (7th generation)" {
            
            cornerRadius = 30
            spacing = 4
            infoButton.isHidden = true
            copyButton.isHidden = true
            settingsButton.isHidden = true
            if #available(iOS 13.0, *) {
                tipButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
            }
            tipButton.setTitle("", for: .normal)
            mainStackViewBottomConstraint.constant = spacing
            
        } else {
            
            cornerRadius = one_button.frame.height/2
            spacing = 8
        }
            
    }
    
    func configureUI(){
        
        one_button.layer.cornerRadius = cornerRadius
        one_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        one_button.backgroundColor = buttonColorOne
        two_button.backgroundColor = buttonColorTwo
        three_button.backgroundColor = buttonColorThree
        four_button.layer.cornerRadius = cornerRadius
        four_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        four_button.backgroundColor = buttonColorFour
        five_button.backgroundColor = buttonColorOne
        six_button.backgroundColor = buttonColorTwo
        seven_button.layer.cornerRadius = cornerRadius
        seven_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        seven_button.backgroundColor = buttonColorThree
        eight_button.backgroundColor = buttonColorFour
        nine_button.backgroundColor = buttonColorOne
        clear_button.layer.cornerRadius = cornerRadius
        clear_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        zero_button.backgroundColor = buttonColorTwo
        backspaceButton.layer.cornerRadius = cornerRadius
        backspaceButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        tipButton.layer.cornerRadius = cornerRadius
        tipButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        buttonsStackView.spacing = spacing
        firstRowStackView.spacing = spacing
        secondRowStackView.spacing = spacing
        thirdRowStackView.spacing = spacing
        fourthRowStackView.spacing = spacing
        fifthRowStackView.spacing = spacing
        extraButtonsStackView.spacing = spacing
        mainStackView.spacing = spacing
        
        readoutBackgroundView.layer.cornerRadius = 30
        readoutBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        readoutBlackBackgroundPanel.layer.cornerRadius = 30
        readoutBlackBackgroundPanel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        mainPanelBackground.layer.cornerRadius = 30
        mainPanelBackground.layer.maskedCorners = [.layerMinXMinYCorner]
        mainPanelBlackBackground.layer.cornerRadius = 30
        mainPanelBlackBackground.layer.maskedCorners = [.layerMinXMinYCorner]
        
        mainPanelBackground.backgroundColor = backgroundColorThree
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        guard let viewControllers = navigationController?.viewControllers,
            let index = viewControllers.index(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
    }
    
    func loadUserDefaults(){
        
        Settings.setMuteSetting(newSetting: UserDefaults.standard.bool(forKey: "muteSetting"))
        Settings.setPercentTip(newTip: UserDefaults.standard.integer(forKey: "tipSetting"))
    }
    
    @IBAction func numberButtonPressed(_ sender: Any) {
        
        if _typingInProgress == false {
            mainReadout.text = ""
            secondaryReadout.text = ""
            _typingInProgress = true
        }
        
        if (sender as AnyObject).tag >= 0 && (sender as AnyObject).tag < 10 {
            if mainReadout.text! == "0" && (sender as AnyObject).tag == 0 {
                mainReadout.text! = "0"
            }else{
                if mainReadout.text! == "0"{
                    mainReadout.text = String((sender as AnyObject).tag)
                }else{
                    mainReadout.text = mainReadout.text! + String((sender as AnyObject).tag)

                }
            }
            
            if mainReadout.text != nil {
                _mainValue = Double(mainReadout.text!)!
            }
        }
        
        if (sender as AnyObject).tag == 10 {
            
            if _hasDecimal == false {
                mainReadout.text = mainReadout.text! + "."
                _hasDecimal = true
            }else{
                secondaryReadout.text = "Invalid operation"
                playSound(soundEffectName: "errorSound")
            }
        }
        
        playSound(soundEffectName: "buttonSound")
    }
    
    @IBAction func functionButtonPressed(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
            
        case 11: //division
            playSound(soundEffectName: "buttonSound")
            _currentOperation = CurrentOperation.division
            checkProgress()
        case 12://multiplication
            playSound(soundEffectName: "buttonSound")
            _currentOperation = CurrentOperation.multiplication
            checkProgress()
        case 13://subtraction
            playSound(soundEffectName: "buttonSound")
            _currentOperation = CurrentOperation.subtraction
            checkProgress()
        case 14://addition
            playSound(soundEffectName: "buttonSound")
            _currentOperation = CurrentOperation.addition
            checkProgress()
        case 15: //%20 or settings on iPod touch
            
            if UIDevice.modelName != "iPod touch (5th generation)" && UIDevice.modelName != "iPod touch (6th generation)" && UIDevice.modelName != "iPod touch (7th generation)" {
                
                if _mainValue == 0.0 && _secondaryValue == 0{
                    // play error sound and display error message.
                    secondaryReadout.text = "Invalid operation"
                    playSound(soundEffectName: "errorSound")
                } else if _secondaryValue == 0.0 {
                    _secondaryValue = _mainValue
                }
                
                if _secondaryValue != 0 {
            
                    let tip = _secondaryValue * (Double(Settings.getPercentTip()) * 0.01)
                    mainReadout.text = " Tip = $" + String(format: "%.2f", tip)
                    secondaryReadout.text = "$" + String(format: "%.2f", _secondaryValue) + " + $" + String(format: "%.2f", tip) + " = $" + String(format: "%.2f", _secondaryValue+tip)
                   
                    _secondaryValue = tip
                    playSound(soundEffectName: "buttonSound")
        
                }
                _hasDecimal = false
                
            }else{
                
                performSegue(withIdentifier: "showiPodSettings", sender: nil)
            }
            
        case 16: //equals
            
            performOperation()
            playSound(soundEffectName: "buttonSound")
            _hasDecimal = false
            
        case 17://copies secondaryValue to clipboard
            
            playSound(soundEffectName: "alertSound")
            
            if _secondaryValue == 0 {
            	UIPasteboard.general.string = String(_mainValue)
            } else {
            	UIPasteboard.general.string = String(_secondaryValue)
            }
            
            secondaryReadout.text = "Value copied to clipboard"
            _hasDecimal = false
            
        case 18: // Clear
            
            playSound(soundEffectName: "buttonSound")
            mainReadout.text = "0.0"
            secondaryReadout.text = "Enter value"
            _hasDecimal = false
            _mainValue = 0
            _secondaryValue = 0
        case 19: // Negative/positive
            
            playSound(soundEffectName: "buttonSound")
            if _mainValue != 0 {
                _mainValue = _mainValue * -1
                 mainReadout.text = String(_mainValue)
            }else{
                _secondaryValue = _secondaryValue * -1
                mainReadout.text = String(_secondaryValue)

            }
            
        case 20: //backspace
            playSound(soundEffectName: "buttonSound")
            
            var mainReadoutString: String = mainReadout.text ?? ""
            _mainValue = Double(mainReadoutString) ?? 0.0
            
            if mainReadoutString.contains("Tip") == true {
                
                mainReadoutString = String(format: "%.2f", _secondaryValue)
                mainReadout.text = mainReadoutString
                _mainValue = Double(mainReadoutString) ?? 0.0
                _secondaryValue = 0.0
                mainReadout.text = String(_mainValue)
                mainReadoutString = mainReadout.text ?? ""
                secondaryReadout.text = ""
                
            }
            
            if _mainValue != 0 {
                
                mainReadoutString.removeLast()
                _mainValue = Double(mainReadoutString) ?? 0.0
                mainReadout.text = mainReadoutString
                if mainReadout.text == "" || mainReadout.text == "-" {
                    _mainValue = 0.0
                    mainReadout.text = "0.0"
                }
                
                secondaryReadout.text = ""
            }else{
                
                playSound(soundEffectName: "errorSound")
                secondaryReadout.text = "Invalid operation"
            }
            
        default:
            break
        }
        
        _typingInProgress = false
    }
    
    func checkProgress(){
        
        _hasDecimal = false
        if _secondaryValue == 0 {
            _secondaryValue = _mainValue
        } else if _mainValue != 0 {
            performOperation()
        }
    }
    
    func performOperation(){
        
        var finalValue:Double = 0
        var operationSymbol = ""
        
        switch(_currentOperation){
            
        case CurrentOperation.division:
            if _mainValue == 0 {
                playSound(soundEffectName: "errorSound")
                secondaryReadout.text = "Invalid operation: cannot divide by zero."
            }else{
                finalValue = _secondaryValue/_mainValue
                operationSymbol = "/"
            }
            
        case CurrentOperation.multiplication:
            finalValue = _mainValue*_secondaryValue
            operationSymbol = "X"
        case CurrentOperation.subtraction:
            finalValue = _secondaryValue-_mainValue
            operationSymbol = "-"
        case CurrentOperation.addition:
            finalValue = _mainValue+_secondaryValue
            operationSymbol = "+"
        }
        
        mainReadout.text = String(format: "%.3f", finalValue)
        if _mainValue != 0{

            secondaryReadout.text = "\(String(format: "%.3f", _secondaryValue)) \(operationSymbol) \(String(format: "%.3f", _mainValue))"
  
        }
        _secondaryValue = finalValue
        _mainValue = 0
        _typingInProgress = false

    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        playSound(soundEffectName: "buttonSound")
        performSegue(withIdentifier: "showInfoScreen", sender: nil)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        //placeholder for possible future functionality
        playSound(soundEffectName: "buttonSound")
        performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    
    func playSound(soundEffectName: String){
        
        if Settings.getMuteSetting() == false {
        
            var url = URL(fileURLWithPath: errorSoundPath)
            
            switch (soundEffectName) {
            case "errorSound":
                url = URL(fileURLWithPath: errorSoundPath)
            case "buttonSound":
                url = URL(fileURLWithPath: buttonSoundPath)
            case "alertSound":
                url = URL(fileURLWithPath: alertSoundPath)
            default:
                url = URL(fileURLWithPath: errorSoundPath)
            }
            
            do {
                soundEffect = try AVAudioPlayer(contentsOf: url)
                soundEffect?.play()
            } catch {
                // couldn't load sound file
                print("Couldn't load sound file in playSound()")
            }
        }
    }
}



