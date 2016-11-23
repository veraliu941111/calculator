//
//  ViewController.swift
//  Calculator
//
//  Created by 刘宝的电脑 on 2016/11/22.
//  Copyright © 2016年 刘宝的电脑. All rights reserved.
//

import UIKit

extension Double {
    fileprivate var displayString: String {
        let floor = self.rounded(.towardZero)
        let isInteger = self.distance(to: floor).isZero
        let string = String(self)
        if isInteger {
            if let indexOfDot = string.characters.index(of: ".") {
                return string.substring(to: indexOfDot)
            }
        }
        return String(self)
    }
}


class ViewController: UIViewController {
    var core = Core<Double>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var labelResult: UILabel!
    
    
    
    @IBAction func AC(_ sender: UIButton) {
        self.labelResult.text = "0"
        self.core = Core<Double>()
    }

    
    @IBAction func condition(_ sender: UIButton) {
        let currentText = self.labelResult.text ?? "0"
        var currentNumber = Double(currentText)!
        currentNumber = -currentNumber
        self.labelResult.text = String(currentNumber)
    }
    
    @IBAction func percent(_ sender: UIButton) {
        let currentText = self.labelResult.text ?? "0"
        var currentNumber = Double(currentText)!
        currentNumber *= 0.01
        self.labelResult.text = String(currentNumber)
        
    }
    
    @IBAction func number(_ sender: UIButton) {
        let numericButtonDigit = sender.tag - 1000
        let currentText = self.labelResult.text ?? "0"
        if currentText == "0" {
            self.labelResult.text = "\(numericButtonDigit)"
        } else {
            self.labelResult.text = currentText + String(numericButtonDigit)
        }
    }
    
    @IBAction func dot(_ sender: UIButton) {
        let currentText = self.labelResult.text ?? "0"
        guard !currentText.contains(".") else {
            return
        }
        self.labelResult.text = currentText + "."
    }
    
    @IBAction func operatorButton(_ sender: UIButton) {
        let currentText = self.labelResult.text ?? "0"
        let currentNumber = Double(currentText)!
        try! self.core.addStep(currentNumber)
        self.labelResult.text = "0"
        switch sender.tag {
        case 111: // Add
            try! self.core.addStep(+)
        case 222: // Sub
            try! self.core.addStep(-)
        case 333: // Mul
            try! self.core.addStep(*)
        case 444: // Div
            try! self.core.addStep(/)
        default:
            fatalError("Unknown operator button: \(sender)")
        }
    }
    
    
    @IBAction func resultNumber(_ sender: UIButton) {
        let currentNumber = Double(self.labelResult.text ?? "0")!
        try! self.core.addStep(currentNumber)
        let result = self.core.calculate()!
        self.labelResult.text = result.displayString
        self.core = Core<Double>()
    }
}

