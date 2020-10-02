//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButoon: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLayer: UILabel!
    @IBOutlet weak var splitStepper: UIStepper!
    
    var tipsBrain = TipsBrain()
    var res: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitStepper.value = 2
        splitNumberLayer.text = String(format: "%.0f", splitStepper.value)
        splitStepper.minimumValue = 0
        splitStepper.maximumValue = 100
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        if zeroPctButton.currentTitle == sender.currentTitle {
            tipsBrain.setPct(percentage: 0.0)
            zeroPctButton.isSelected = true
            tenPctButoon.isSelected = false
            twentyPctButton.isSelected = false
        } else if tenPctButoon.currentTitle == sender.currentTitle {
            tipsBrain.setPct(percentage: 0.10)
            tenPctButoon.isSelected = true
            zeroPctButton.isSelected = false
            twentyPctButton.isSelected = false
        } else if twentyPctButton.currentTitle == sender.currentTitle {
            tipsBrain.setPct(percentage: 0.20)
            twentyPctButton.isSelected = true
            zeroPctButton.isSelected = false
            tenPctButoon.isSelected = false
        }
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        tipsBrain.setPeople(people: splitStepper.value)
        splitNumberLayer.text = String(format: "%.0f", tipsBrain.getPeople())
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let textFieldText = billTextField.hasText ? billTextField.text!.replacingOccurrences(of: ",", with: ".") : "0.0"
        
        if textFieldText.split(separator: ".").count > 2 {
            showToast(controller: self, message: "Currency input must be i.e. 12.50", seconds: 3.0)
            billTextField.text = ""
            return
        }
        
        let amount: Float = Float(textFieldText)!
        
        res = tipsBrain.computeResult(amount: amount)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = res
            destinationVC.finalMessage = "Split between \(String(format: "%.0f", tipsBrain.getPeople())) people, with \(String(format: "%.0f", tipsBrain.getPct() * 100))% tip."
        }
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.view.backgroundColor = .systemGray3
        alert.view.alpha = 0.3
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
}

