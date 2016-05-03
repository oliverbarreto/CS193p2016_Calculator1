//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by David Oliver Barreto Rodríguez on 1/5/16.
//  Copyright © 2016 Oliver Barreto. All rights reserved.
//

import Foundation

class CalculatorBrain {
  
  // MARK: Properties
  private var accumulator = 0.0
  
  
  private var operations: Dictionary<String,Operation> = [
    // Constants
    "=" : Operation.Equals,

    // Constants
    "π" : Operation.Constant(M_PI),
    "e" : Operation.Constant(M_E),
    "C" : Operation.Constant(0),
    
    
    // Unary Ops
    "%" : Operation.UnaryOperation( {$0/100} ),
    "±" : Operation.UnaryOperation( {-$0} ),
    "√" : Operation.UnaryOperation(sqrt),
    "cos" : Operation.UnaryOperation(cos),
    "sen" : Operation.UnaryOperation(sin),
    "x^2" : Operation.UnaryOperation( {$0*$0} ),
    "rnd" : Operation.UnaryOperation( {_ in drand48()} ),
    "rndX" : Operation.UnaryOperation( {Double(arc4random_uniform(UInt32($0+1)))} ),
    
    // Binary Ops
    "÷" : Operation.BinaryOperation( {$0 / $1}),
    "×" : Operation.BinaryOperation( {$0 * $1} ),
    "+" : Operation.BinaryOperation( {$0 + $1}),
    "−" : Operation.BinaryOperation( {$0 - $1}),
    "x^y" : Operation.BinaryOperation(pow)
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