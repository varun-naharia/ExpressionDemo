//
//  ViewController.swift
//  ExpressionDemo
//
//  Created by Varun Naharia on 20/12/17.
//  Copyright © 2017 Varun Naharia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var inputField: UITextView!
    @IBOutlet weak var outputView: UILabel!
    private var output = NSMutableAttributedString()
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var toolbarTitle: UIBarButtonItem!
    var arrVariable:[String] = []
    
    private func addOutput(_ string: String, color: UIColor) {
        let text = NSAttributedString(string: string + "\n\n", attributes: [
            NSAttributedStringKey.foregroundColor: color,
            NSAttributedStringKey.font: outputView.font!,
            ])
        output.replaceCharacters(in: NSMakeRange(0, 0), with: text)
        outputView.attributedText = output
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        output.append(outputView.attributedText!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textViewDidChange(_ textView: UITextView) {
        if let text = inputField.text, text != "" {
            do {
                let result = try Expression(text).evaluate()
                addOutput(String(format: "= %g", result), color: .black)
            } catch {
                addOutput("\(error)", color: .red)
            }
        }
    }
}

extension ViewController:UIPickerViewDelegate, UIPickerViewDataSource
{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        toolbarTitle.title = "Variable"
        return arrVariable.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrVariable[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        expressionBuilderView.addFunction(functionName: arrFunctions[row]["FunctionName"] as! String, minArg: arrFunctions[row]["MinArg"] as! Int, maxArg: arrFunctions[row]["MaxArg"] as! Int)
    }
    func addDoneButtonOnKeyboard()
    {
        expressionBuilderView.expressionField.inputAccessoryView = toolbar
    }
    
    func removeDoneButtonOnKeyboard()
    {
        expressionBuilderView.expressionField.inputAccessoryView = nil
    }
    
}


