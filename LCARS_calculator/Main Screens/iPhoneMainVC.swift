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
//        one_button.layer.borderWidth = 2
//        one_button.layer.borderColor = UIColor.black.cgColor
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

public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                    return "iPad (8th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                    return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                    return "iPad Air (4th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "AudioAccessory5,1":                       return "HomePod mini"
            case "i386", "x86_64":                          return "\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}



