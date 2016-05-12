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
  
  // Used for logic of Calculator Brain - Operations
  private var accumulator = 0.0
  
  // Used for logic of Calculator Brain - Display of Operations History  
  private var descriptionAccumulator = "0"
  
  private var operations: Dictionary<String,Operation> = [
    // Basic Calculator View 
    "AC" : Operation.Constant(0),
    "±" : Operation.UnaryOperation( {-$0}, { (Double($0) >= 0) ? ("-" + $0) : $0} ),
    "%" : Operation.UnaryOperation( {$0/100}, {"%" + $0 } ),

    "÷" : Operation.BinaryOperation( {$0 / $1}, {$0 + " ÷ " + $1} ),
    "×" : Operation.BinaryOperation( {$0 * $1}, {$0 + " × " + $1} ),
    "+" : Operation.BinaryOperation( {$0 + $1}, {$0 + " + " + $1} ),
    "−" : Operation.BinaryOperation( {$0 - $1}, {$0 + " − " + $1} ),

    //"↲" : 
    "=" : Operation.Equals,
    

    // Advanced Calculator View
    
    // (
    // )
    // mc memory clear
    // +m add display value to memory
    // -m remove display value from  memory
    // mr recover memory value to display

    "2ⁿ" : Operation.UnaryOperation(  {pow(2,$0)}, {"2^" + $0 } ),
    "x²" : Operation.UnaryOperation(  {pow($0,2)}, {$0 + "²" } ),
    "x³" : Operation.UnaryOperation(  {pow($0,3)}, {$0 + "³"} ),
    "xʸ" : Operation.BinaryOperation( {pow($0,$1)}, {$0 + "^" + $1} ),
    "eˣ" : Operation.UnaryOperation(  {pow(M_E,$0)}, {"e^" + $0 } ),
    "10ˣ" : Operation.UnaryOperation( {pow(10,$0)}, {"10^" + $0 } ),
    
    "1/x" : Operation.UnaryOperation( {1/$0}, {"1/" + $0 } ),
    "√" : Operation.UnaryOperation(sqrt, {"²√(" + $0 + ")"} ),
    "²√x" : Operation.UnaryOperation(sqrt, {"²√(" + $0  + ")"} ),
    "³√x" : Operation.UnaryOperation(   {pow($0,1/3)}, {"³√(" + $0 + ")"} ),
    "ʸ√x" : Operation.BinaryOperation(  {pow($0,1/$1)}, {"(" + $1 + "√(" + $0 + "))"} ),
    "ln" : Operation.UnaryOperation(log, {"ln " + $0 } ),
    "log₁₀" : Operation.UnaryOperation(log, {"log₁₀ " + $0 } ),
    
    "x!" : Operation.UnaryOperation( { factorial($0)}, {$0 + "! "} ),
    "sin" : Operation.UnaryOperation(sin, {"sin(" + $0 + ")"} ),
    "cos" : Operation.UnaryOperation(cos, {"cos(" + $0 + ")"} ),
    "tan" : Operation.UnaryOperation(tan, {"tan(" + $0 + ")"} ),
    "e" : Operation.Constant(M_E),
    "rdn" : Operation.UnaryOperation( {_ in Double((arc4random_uniform(UInt32(100000000)))/100000000)}, {_ in "rdn"} ),

    //Rad - Radians vs Degrees Toggle
    "sinh" : Operation.UnaryOperation(sinh, {"sinh(" + $0 + ")"} ),
    "cosh" : Operation.UnaryOperation(cosh, {"cosh(" + $0 + ")"} ),
    "tanh" : Operation.UnaryOperation(tanh, {"tanh(" + $0 + ")"} ),
    "π" : Operation.Constant(M_PI),
    "rdn⒳" : Operation.UnaryOperation( {Double(arc4random_uniform(UInt32($0+1)))}, {"rdn(" + $0 + ")"}  )
    
  ]
  
  
  // Valid Types of Operations
  // Operations have associated values for ops to provide a) Math Function; and b) "How-To Print" itself Function
  private enum Operation {
    case Constant(Double)
    
    case UnaryOperation((Double) -> Double, (String) -> String)
    
    case BinaryOperation((Double, Double) -> Double, (String, String) -> String)
    
    case Equals
  }
  
  
  // Pending Binary Operation implementation
  private var pending: PendingBinaryOperationInfo?
  
  private struct PendingBinaryOperationInfo {
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
    var descriptionFunction: (String, String) -> String
    var descriptionFirstOperand: String
  }

  
  // MARK: Utility Methods
  
  // Prints Integers or Doubles with/without decimals
  private func prettyPrinter(str: String) -> String {
    
    if str.rangeOfString(".0") != nil {
      return String(str.characters.dropLast(2))
    } else {
      return str
    }
  }
  
  // Executes pending operations
  private func executePendingOperation() {
    
    if pending != nil {
      accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
      descriptionAccumulator = pending!.descriptionFunction(pending!.descriptionFirstOperand, descriptionAccumulator)
      pending = nil
    }    
  }

  
  // MARK: Public Methods
  func setOperand(operand:Double) {
    accumulator = operand
    descriptionAccumulator = prettyPrinter(String(operand))
  }
  
  // Performs Operations based on symbols
  func performOperation(operationSymbol: String) {

    if let operation = operations[operationSymbol] {
      switch (operation) {
        case .Constant(let value):
          accumulator = value
          descriptionAccumulator = operationSymbol
        
        case .UnaryOperation(let function, let descriptionFunction):
          accumulator = function(accumulator)
          descriptionAccumulator = descriptionFunction(descriptionAccumulator)
        
        case .BinaryOperation(let function, let descriptionFunction):
          executePendingOperation()
          
          pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator, descriptionFunction: descriptionFunction, descriptionFirstOperand: descriptionAccumulator)
          
        case .Equals:
          executePendingOperation()
      }
    }
  }

  // Returns whether there is a binary operation pending (if so, return true, if not, false)
  var isPartialResult: Bool {
    get {
      return pending != nil
    }
  }
  
  // Returns the a string with all operations performed until new operands are introduced 
  var description: String {
    get {
      if pending == nil {
        return descriptionAccumulator 
      } else {
        return pending!.descriptionFunction(pending!.descriptionFirstOperand, pending!.descriptionFirstOperand != descriptionAccumulator ? descriptionAccumulator : "")
      }
    }
  }

  // Returns the result of any operations
  var result: Double {
    get {
      return accumulator
    }
  }
  
}

extension CalculatorBrain {

  

}