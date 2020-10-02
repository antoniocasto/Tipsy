//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Antonio Casto on 02/10/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var result: Float = 0.0
    var finalMessage: String = "DEFAULT_MESSAGE"
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = String(format: "%.2f", result) + " €"
        settingsLabel.text = finalMessage
    }
    
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
