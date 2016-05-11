//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by David Oliver Barreto Rodríguez on 1/5/16.
//  Copyright © 2016 Oliver Barreto. All rights reserved.
//

import Foundation

// MARK: Global Math functions
// Calculates the factorial of a number
func factorial(num: Double) -> Double {
  if num == 0 {
    return 1
  }
  var fact = 1
  for i in 1...Int(round(num)) {
    fact *= i
  }
  return Double(fact)
}


// MARK: CalculatorBrain Class
class CalculatorBrain {
  
  // MARK: Properties
  private var accumulator = 0.0
  private var isPartialResult = false

  
  private var operations: Dictionary<String,Operation> = [
    // Basic Calculator View 
    "AC" : Operation.Constant(0),
    "±" : Operation.UnaryOperation( {-$0} ),
    "%" : Operation.UnaryOperation( {$0/100} ),

    "÷" : Operation.BinaryOperation( {$0 / $1}),
    "×" : Operation.BinaryOperation( {$0 * $1} ),
    "+" : Operation.BinaryOperation( {$0 + $1}),
    "−" : Operation.BinaryOperation( {$0 - $1}),

    //"↲" : 
    "=" : Operation.Equals,
    

    // Advanced Calculator View
    
    // (
    // )
    // mc memory clear
    // +m add display value to memory
    // -m remove display value from  memory
    // mr recover memory value to display

    "2ⁿ" : Operation.UnaryOperation( {pow(2,$0)} ),
    "x²" : Operation.UnaryOperation( {pow($0,2)} ),
    "x³" : Operation.UnaryOperation( {pow($0,3)} ),
    "xʸ" : Operation.BinaryOperation( {pow($0,$1)} ),
    "eˣ" : Operation.UnaryOperation( {pow(M_E,$0)} ),
    "10ˣ" : Operation.UnaryOperation( {pow(10,$0)} ),
    
    "1/x" : Operation.UnaryOperation( {1/$0} ),
    "√" : Operation.UnaryOperation(sqrt),
    "²√x" : Operation.UnaryOperation(sqrt),
    "³√x" : Operation.UnaryOperation( {pow($0,1/3)} ),
    "ʸ√x" : Operation.BinaryOperation( {pow($0,1/$1)} ),
    "ln" : Operation.UnaryOperation(log),
    "log₁₀" : Operation.UnaryOperation(log),
    
    "x!" : Operation.UnaryOperation( { factorial($0)} ),
    "sin" : Operation.UnaryOperation(sin),
    "cos" : Operation.UnaryOperation(cos),
    "tan" : Operation.UnaryOperation(tan),
    "e" : Operation.Constant(M_E),
    "rdn" : Operation.UnaryOperation( {_ in Double((arc4random_uniform(UInt32(100000000)))/100000000)} ),

    //Rad - Radians vs Degrees Toggle
    "sinh" : Operation.UnaryOperation(sinh),
    "cosh" : Operation.UnaryOperation(cosh),
    "tanh" : Operation.UnaryOperation(tanh),
    "π" : Operation.Constant(M_PI),
    "rdn⒳" : Operation.UnaryOperation( {Double(arc4random_uniform(UInt32($0+1)))} )
    
  ]
  
  
  // Valid Types of Operations
   private enum Operation {
    case Constant(Double)
    
    case UnaryOperation(Double -> Double)
    
    case BinaryOperation((Double, Double) -> Double)
    
    case Equals
  }
  
  
  // Pending Binary Operation implementation
  private var pending: PendingBinaryOperationInfo?
  
  private struct PendingBinaryOperationInfo {
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
  }

  
  // MARK: Utility Methods
  private func executePendingOperation() {
    
    if pending != nil {
      accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
      pending = nil
    }    
  }

  
  // MARK: Public Methods
  func setOperand(operand:Double) {
    accumulator = operand
  }
  
  
  func performOperation(operationSymbol: String) {

    if let operation = operations[operationSymbol] {
      switch (operation) {
        case .Constant(let value):
          accumulator = value
        
        case .UnaryOperation(let function):
          accumulator = function(accumulator)
        
        case .BinaryOperation(let function):
          executePendingOperation()
          
          pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
      
        case .Equals:
          executePendingOperation()
      }
    }
  }
  
  var result: Double {
    get {
      return accumulator
    }
  }
  
}

extension CalculatorBrain {

  

}