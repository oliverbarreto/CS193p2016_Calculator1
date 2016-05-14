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

  // Displays history of operations  
  @IBOutlet weak var opsDescriptionDisplay: UILabel!
  
  // Displays the right decimal separator character for the NSUserLocale
  @IBOutlet weak var decimalSeparatorButton: UIButton!
  
  // To manage hide/show when device Orientation changes (hide left stackview panel when protrait) 
  @IBOutlet weak var stackviewLeftPanel: UIStackView!
  
  
  // Model
  private var brain = CalculatorBrain(decimalDigits: Constants.portraitMaxDecimalDigits)
  
  // Tracks display input
  private var userIsInTheMiddleOfTyping = false
  private var isPartialResult = false
  
	
	// NSNumberFormatter
	private var numberFormatter = NSNumberFormatter()
	
  // Manages the number of decimal digits in portratir vs landscape
  private var decimalDigits: Int {
		get {
			return getNumberOfDecimalDigits(self.traitCollection.verticalSizeClass)
		}
  }
  private struct Constants {
		static let landscapeMaxDecimalDigits: Int = 12
		static let portraitMaxDecimalDigits: Int = 6
  }
  
  // Returns the character used for decimal separator... depending on NSUserLocale!!!
  private var decimalSeparatorCharacter: String {
    return numberFormatter.decimalSeparator!
  }
  
	
  // Keeps the UI updated everytime we set the property
  private var displayValue: Double? {
    get {    
			if let displayText = display.text {      
        return numberFormatter.numberFromString(displayText)?.doubleValue
      } else {
        return nil  
      }
      
      //return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
      //display.text = NSString(format: "%.5f", newValue) as String
    }
		
    set {
      if let value = newValue {
				display.text = numberFormatter.stringFromNumber(value)
				//display.text = String(value)
        opsDescriptionDisplay.text = brain.description + (brain.isPartialResult ? " ..." : " =")
				
      } else {
        display.text = "0"
        opsDescriptionDisplay.text = "0"
        userIsInTheMiddleOfTyping = false
      }
    }
  }
	
	// Returns the number of decimal digits to show according to device orientation
	private func getNumberOfDecimalDigits(verticalOrientationSizeClass: UIUserInterfaceSizeClass) -> Int{
		if (verticalOrientationSizeClass == .Regular) {
			return Constants.portraitMaxDecimalDigits
		} else {
			return Constants.landscapeMaxDecimalDigits
		}	
	}
  
  // MARK: Public Methods
  @IBAction private func pressDigit(sender: UIButton) {
    
    if let digit = sender.titleLabel?.text {
      
      if userIsInTheMiddleOfTyping {
        if (digit == decimalSeparatorCharacter) && display.text!.rangeOfString(decimalSeparatorCharacter) != nil { return }
        if (digit == "0") && (display.text! == "0" || display.text! == "-0") { return }
        if (digit != decimalSeparatorCharacter) && (display.text! == "0" || display.text! == "-0") {
          if (display.text == "0") {
            display.text = digit
          } else {
            display.text = "-" + digit
          }
        } else {
          display.text = display.text! + digit
        }
      } else {
        if digit == decimalSeparatorCharacter {
          display.text = "0\(decimalSeparatorCharacter)"
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

  
  @IBAction func backspaceButtonPressed(sender: UIButton) {
    
    if userIsInTheMiddleOfTyping {
      if display.text != nil {
        display.text = String(display.text!.characters.dropLast(1))
        
        // If we remove the last decimal... remove the "."
        if display.text!.isEmpty {
          display.text = "0"
          userIsInTheMiddleOfTyping = false
        }
        if display.text!.characters.last == decimalSeparatorCharacter.characters.last {
          display.text = String(display.text!.characters.dropLast(1))
        }
        
      } else {
        display.text = "0"
      }
    }
  }
  
	
	
  // MARK: Private Methods
  private func enter() {
    brain.setOperand(displayValue!)
    userIsInTheMiddleOfTyping = false
  }
  
  private func clear() {
      //displayValue = 0
      //opsDescriptionDisplay.text = " "
      displayValue = nil
		brain = CalculatorBrain(decimalDigits: decimalDigits)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  @objc private func localeDidChange() {
    self.decimalSeparatorButton.setTitle(decimalSeparatorCharacter, forState: .Normal)
  }

}


extension CalculatorMainScreenVC {
 
  // MARK: VC LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Hide StackView according to current traitcollection size-class
    configureView(traitCollection.verticalSizeClass)
    
    // Set Observer on NSLocale changes
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CalculatorMainScreenVC.localeDidChange), name:NSCurrentLocaleDidChangeNotification, object: nil)
    
    
    // Show the right decimal separator character on UIButton
    decimalSeparatorButton.setTitle(decimalSeparatorCharacter, forState: .Normal)
		
		
		// initial configuration of NumberFormatter
		numberFormatter.numberStyle = .DecimalStyle
		numberFormatter.maximumFractionDigits = decimalDigits
  }
  
  
  
  // Manage device orientation
  override func willTransitionToTraitCollection(newCollection: UITraitCollection,
                        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    
    super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
    
    configureView(newCollection.verticalSizeClass)
		numberFormatter.maximumFractionDigits = getNumberOfDecimalDigits(newCollection.verticalSizeClass)
		brain.numberOfMaximunDecimalDigits = numberFormatter.maximumFractionDigits
  }
 
  
  // MARK: Utility Method that helps hide the left panel stackview in the calculator when in portrait
	// ... it also sets the right number of decimal digits after the separator according to orientation
  
  private func configureView(verticalSizeClass: UIUserInterfaceSizeClass) {
    guard stackviewLeftPanel != nil else {
      return
    }
    stackviewLeftPanel.hidden = (verticalSizeClass == .Regular)		
  }
}

