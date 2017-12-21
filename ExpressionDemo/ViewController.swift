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
    var arrVariable:[String] = ["num1", "num2"] // this array should be bind with following variable.
    var num1: Int = 0
    var num2:Int = 1
    var timer = Timer()
    
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
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
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
    
    @objc func updateCounting() {
        num1 = Int(arc4random())
        num2 = Int(arc4random())
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        picker.delegate = nil
        picker.dataSource = nil
        inputField.inputView = nil
        inputField.resignFirstResponder()
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        
        inputField.text = "\(inputField.text!)\(arrVariable[picker.selectedRow(inComponent: 0)])"
        inputField.resignFirstResponder()
        removeDoneButtonOnKeyboard()
        picker.delegate = nil
        picker.dataSource = nil
        inputField.inputView = nil
    }
    
    @IBAction func addVariableAction(_ sender: UIButton) {
        inputField.resignFirstResponder()
        picker.delegate = self
        picker.dataSource = self
        inputField.inputView = picker
        self.addDoneButtonOnKeyboard()
        inputField.becomeFirstResponder()
        removeDoneButtonOnKeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
    }
    func addDoneButtonOnKeyboard()
    {
        inputField.inputAccessoryView = toolbar
    }
    
    func removeDoneButtonOnKeyboard()
    {
        inputField.inputAccessoryView = nil
    }
    
}


