//
//  CalculatorMainScreenVC.swift
//  Calculator
//
//  Created by David Oliver Barreto Rodríguez on 1/5/16.
//  Copyright © 2016 Oliver Barreto. All rights reserved.
//

import UIKit

class CalculatorMainScreenVC: UIViewController {

  @IBOutlet weak var display: UILabel!
  
  @IBAction func pressDigit(sender: UIButton) {
    if let digit = sender.titleLabel?.text {
        print("\(digit)")
    }
    
  }
  
  @IBAction func performOperation(sender: UIButton) {
    if let operation = sender.titleLabel?.text {
      print("\(operation)")
    }
  }
  
}
