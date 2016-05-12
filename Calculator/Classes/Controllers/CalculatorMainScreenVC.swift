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
  
  // Calculator Main Display
  @IBOutlet private weak var display: UILabel!

  @IBOutlet weak var opsDescriptionDisplay: UILabel!
  
  
  // To manage hide/show when device Orientation changes (hide left stackview panel when protrait) 
  @IBOutlet weak var stackviewLeftPanel: UIStackView!
  
  
  // Model
  private var brain = CalculatorBrain()
  
  // Tracks display input
  private var userIsInTheMiddleOfTyping = false
  private var isPartialResult = false
  
  // Keeps the UI updated everytime we set the property
  private var displayValue: Double {
    get {
      return Double(display.text!)!
      //return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
    }
    set {
      //display.text = NSString(format: "%.5f", newValue) as String
      if String(newValue).rangeOfString(".0") != nil {
        display.text = String(Int(newValue))
      } else {
        display.text = String(newValue)
      }
      
      opsDescriptionDisplay.text = brain.description + (brain.isPartialResult ? " ..." : " =")
    }
  }
  
  // MARK: Public Methods
  @IBAction private func pressDigit(sender: UIButton) {
    
    if let digit = sender.titleLabel?.text {
      
      if userIsInTheMiddleOfTyping {
        if (digit == ".") && display.text!.rangeOfString(".") != nil { return }
        if (digit == "0") && (display.text! == "0" || display.text! == "-0") { return }
        if (digit != ".") && (display.text! == "0" || display.text! == "-0") {
          if (display.text == "0") {
            display.text = digit
          } else {
            display.text = "-" + digit
          }
        } else {
          display.text = display.text! + digit
        }
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
      enter()
    }
    
    // Operation
    if let operation = sender.currentTitle {
      print("\(operation)")
    
      if operation == "AC" {
        clear()
        return
      } else {
        brain.performOperation(operation)
      }
    }
    displayValue = brain.result
  }

  
  // MARK: Private Methods
  private func enter() {
    brain.setOperand(displayValue)
    userIsInTheMiddleOfTyping = false
  }
  
  private func clear() {
      displayValue = 0
      opsDescriptionDisplay.text = " "
      brain = CalculatorBrain()
  }
}


extension CalculatorMainScreenVC {
 
  // MARK: VC LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView(traitCollection.verticalSizeClass)
  }
  
  // Manage device orientation
  override func willTransitionToTraitCollection(newCollection: UITraitCollection,
                        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    
    super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
    
    configureView(newCollection.verticalSizeClass)
  }
 
  
  // MARK: Utility Method that helps hide the left panel stackview in the calculator when in portrait 
  
  private func configureView(verticalSizeClass: UIUserInterfaceSizeClass) {
    guard stackviewLeftPanel != nil else {
      return
    }
    stackviewLeftPanel.hidden = (verticalSizeClass == .Regular)
  }
  
}

