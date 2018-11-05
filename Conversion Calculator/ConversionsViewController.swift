//
//  ConversionsViewController.swift
//  FINAL PROJECT - Conversion Calculator
//
//  Created by Riley Evans on 10/23/18.
//  Copyright © 2018 Riley Evans. All rights reserved.
//

import UIKit

class ConversionsViewController: UIViewController {
    
    var model = Model()

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    @IBAction func converterButtonAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: "Choose Converter", preferredStyle: .actionSheet)
        for x in 0..<model.converterArray.count {
            actionSheet.addAction(UIAlertAction(title: model.converterArray[x].label, style: .default , handler:{ (UIAlertAction)in
                self.changeConverter(index: x)
            }))
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func signButtonAction(_ sender: Any) {
        if (model.currentIn == "") { return }
        if (model.currentIn.first == "-") {model.currentIn.removeFirst()}
        else {model.currentIn = "-" + model.currentIn}
        model.currentOut = String(format: "%.2f", Double(convert(model.currentIn, model.currentConverter))!)
        updateView()
    }
    @IBAction func clearButtonAction(_ sender: Any) {
        model.currentIn = ""
        model.currentOut = ""
        model.decimalFlag = false
        updateView()
    }
    @IBAction func numberButtonAction(_ sender: Any) {
        if (((sender as! UIButton).titleLabel?.text!)! == ".") {
            if (model.decimalFlag == false) {
                model.currentIn.append(((sender as! UIButton).titleLabel?.text!)!)
                updateView()
                model.decimalFlag = true
                return
            } else { return }
        }
        model.currentIn.append(((sender as! UIButton).titleLabel?.text!)!)
        model.currentOut = String(format: "%.2f", Double(convert(model.currentIn, model.currentConverter))!)
        updateView()
    }
    func updateView() {
        outputDisplay.text = model.currentOut + " " + model.converterArray[model.currentConverter].outputUnit!
        inputDisplay.text = model.currentIn + " " + model.converterArray[model.currentConverter].inputUnit!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func changeConverter(index: Int) {
        clearButtonAction(clearButton)
        inputDisplay.text = model.converterArray[index].inputUnit
        outputDisplay.text = model.converterArray[index].outputUnit
        model.currentConverter = index
    }
    
    func doubleFromInput(_ input: String) -> Double? {
        var input = input
        if (input.last == ".") { input = String(input.dropLast()) }
        return Double(input)
    }

    func convert(_ input: String,_ classifier: Int) -> String {
        let input = doubleFromInput(input)
        var output = 0.0
        if (input == nil) { return "" }
        switch classifier {
            case 0 : output = (input! - 32) * 5/9
            case 1 : output = (input! * 9/5) + 32
            case 2 : output = (input! / 0.62137)
            case 3 : output = (input! * 0.62137)
            default : output = 0.0
        }
        return String(output)
    }
}
