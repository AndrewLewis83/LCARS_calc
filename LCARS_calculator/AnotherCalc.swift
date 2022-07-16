//
//  AnotherCalc.swift
//  AnotherCalc
//
//  Created by Andy Lewis on 7/8/22.
//

import Foundation

public struct Operation {
    
    let primaryValue: Double
    let secondaryValue: Double?
    let operation: Operations
    let tipPercentage: Double?
}

public enum Operations {
    
    case addition
    case subtraction
    case multiplication
    case division
    case tip
    case none
}

public class AnotherCalc {
    
    public init (recordHistory: Bool){
        self.recordHistory = recordHistory
    }
    
    fileprivate let recordHistory: Bool!
    fileprivate var operation: Operations = .none
    fileprivate var history: [Operation] = []
    fileprivate var primaryReadoutValue: String = "0.0"
    fileprivate var secondaryReadoutValue: String = ""
    
    fileprivate var primaryValue: Double = 0
    fileprivate var secondaryValue: Double = 0
    
    public var validOperation: Bool {
        
        if operation == .division && secondaryValue == 0 {
            return false
        }
        
        return secondaryValue != 0
    }
    
    public var operationHistory: [Operation] {
        get {
            return history
        }
    }
    
    public var primaryReadout: String {
        get {
            return primaryReadoutValue
        }
        
        set(value) {
            if let _ = Double(value) {
                primaryReadoutValue = value
            }
        }
    }
    
    public var secondaryReadout: String {
        get {
            return secondaryReadoutValue
        }
    }
    
    // MARK: private
    fileprivate func convertToDouble() -> Bool {
        
        guard let value = Double(primaryReadoutValue) else { return false }
        secondaryValue = value
        primaryReadoutValue = "0.0"
        return true
    }
    
    @discardableResult
    fileprivate func removeTipSettings() -> Bool {
        
        if operation == .tip {
            
            primaryReadoutValue = primaryReadoutValue.replacingOccurrences(of: "tip = $", with: "")
            operation = .none
            secondaryReadoutValue = ""
            
            return true
            
        } else {
            return false
        }
    }
    
    @discardableResult
    fileprivate func calculate() -> Bool {
        
        guard validOperation else { return false }
        
        if recordHistory {
            history.insert(Operation(primaryValue: primaryValue, secondaryValue: secondaryValue, operation: operation, tipPercentage: nil), at: 0)
        }
        
        secondaryReadoutValue = String(format: "%.2f", primaryValue)
        
        switch operation {
        case .addition:
            secondaryReadoutValue += " + "
            primaryValue += secondaryValue
        case .subtraction:
            secondaryReadoutValue += " - "
            primaryValue -= secondaryValue
        case .multiplication:
            secondaryReadoutValue += " x "
            primaryValue *= secondaryValue
        case .division:
            secondaryReadoutValue += " / "
            primaryValue /= secondaryValue
        case .tip:
            secondaryReadoutValue = ""
            primaryReadoutValue = "\(primaryValue)"
            secondaryValue = 0
            return true
        case.none:
            
            primaryValue = secondaryValue
            return true
        }
        
        secondaryReadoutValue += String(format: "%.2f", secondaryValue) + " = " + String(format: "%.2f", primaryValue)
        primaryReadoutValue = "\(primaryValue)"
        secondaryValue = 0
        return true
    }

    // MARK: public
    
    @discardableResult
    public func plus() -> Bool {
        
        guard convertToDouble() else { return false }
        calculate()
        operation = .addition
        return true
    }
    
    @discardableResult
    public func minus() -> Bool {
        
        guard convertToDouble() else { return false }
        calculate()
        operation = .subtraction
        return true
    }
    
    @discardableResult
    public func times() -> Bool {
        
        guard convertToDouble() else { return false }
        calculate()
        operation = .multiplication
        return true
    }
    
    @discardableResult
    public func divide() -> Bool {
        
        guard convertToDouble() else { return false }
        calculate()
        operation = .division
        return true
    }
    
    @discardableResult
    public func equals() -> Bool {
        
        guard operation != .none, convertToDouble() else { return false }
        let success = calculate()
        operation = .none
        return success
    }
    
    @discardableResult
    public func addNewDigit(digit: Int) -> Bool {
            
        if primaryReadoutValue == "0.0" && digit > 0 {
            
            primaryReadoutValue = "\(digit)"
            
        } else if digit > 0 || primaryReadoutValue != "0.0" {
            
            primaryReadoutValue = "\(primaryReadoutValue)" + "\(digit)"
            
        } else {
            return false
        }
        
        secondaryReadoutValue = ""
        return true
    }
    
    @discardableResult
    public func negative() -> Bool {
        
        removeTipSettings()
        
        if primaryReadoutValue == "0.0" {
            primaryReadoutValue = "-"
        } else if let index = primaryReadoutValue.firstIndex(of: "-") {
            primaryReadoutValue.remove(at: index)
        } else {
            primaryReadoutValue = "-" + primaryReadoutValue
        }
        
        return true
    }
    
    @discardableResult
    public func addDecimal() -> Bool {
        
        if primaryReadoutValue.contains(".") {
            return false
        } else {
            primaryReadoutValue = primaryReadoutValue + "."
            return true
        }
    }
    
    @discardableResult
    public func backSpace() -> Bool {
        
        guard primaryReadoutValue != "0.0" else { return false }
        
        guard removeTipSettings() == false else { return true } // needs to return true. This will remove the "tip = $" substring, but the user needs to tap backspace again in order to actually start removing characters. It's a better experience.
            
        var value:String = primaryReadoutValue
        value.removeLast()
        
        if value == "" {
            value = "0.0"
        }
        
        primaryReadoutValue = value
        
        return true
    }
    
    @discardableResult
    public func clear() -> Bool {
        
        if primaryReadoutValue == "0.0" {
            
            return false
            
        } else {
            
            primaryReadoutValue = "0.0"
            secondaryReadoutValue = "enter value"
            primaryValue = 0
            secondaryValue = 0
            operation = .none
            
            return true
        }
    }
    
    // MARK: tip
    @discardableResult
    public func calculateTip(_ tipPercentage: Double) -> Bool {
        
        guard tipPercentage < 1 else { return false }
        
        guard primaryReadoutValue.contains("-") == false else { return false }

        guard let value = Double(primaryReadoutValue) else { return false }
        let tip = value * tipPercentage
        
        primaryReadoutValue = "tip = $" + String(format: "%.2f", tip)
        secondaryReadoutValue = "$" + String(format: "%.2f", value) + " + $" + String(format: "%.2f", tip) + " = $" + String(format: "%.2f", value + tip)
        
        if recordHistory {
            history.insert(Operation(primaryValue: secondaryValue, secondaryValue: nil, operation: .tip, tipPercentage: tipPercentage), at: 0)
        }
    
        operation = .tip
        
        return true
    }
    
    // MARK: history
    public func clearHistory() {
        history.removeAll()
    }
    
    public func logOperation(operation: Operation, index: Int){
        self.history.insert(operation, at: index)
    }
    
    public func removeOperation(index: Int){
        self.history.remove(at: index)
    }

}
