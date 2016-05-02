//
//  CalculatorMainScreenVC.swift
//  Calculator
//
//  Created by David Oliver Barreto Rodríguez on 1/5/16.
//  Copyright © 2016 Oliver Barreto. All rights reserved.
//

import UIKit

class CalculatorMainScreenVC: UIViewController {

  // MARK: Properties & Outlets
  @IBOutlet private weak var display: UILabel!
  
  // Model
  private var brain = CalculatorBrain()
  
  // Tracks display input
  private var userIsInTheMiddleOfTyping = false
  
  
  // Keeps the UI updated everytime we set the property
  private var displayValue: Double {
    get {
      return Double(display.text!)!
      //return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
    }
    set {
      display.text = NSString(format: "%.5f", newValue) as String
    }
  }
  
  // MARK: Methods
  @IBAction private func pressDigit(sender: UIButton) {
    
    if let digit = sender.titleLabel?.text {
      print("\(digit)")
      if userIsInTheMiddleOfTyping {
        if (digit == ".") && display.text!.rangeOfString(".") != nil {return }
        display.text = display.text! + digit
      } else {
        if digit == "." {
          display.text = "0."
        } else {
          display.text = digit
        }
      }
      userIsInTheMiddleOfTyping = true        
    }
    
  }
  
  @IBAction private func performOperation(sender: UIButton) {
    
    // Operand
    if userIsInTheMiddleOfTyping {
      brain.setOperand(displayValue)
      userIsInTheMiddleOfTyping = false
    }
    
    // Operation
    if let operation = sender.currentTitle {
      print("\(operation)")
      brain.performOperation(operation)
    }
    displayValue = brain.result
  }
  
}
