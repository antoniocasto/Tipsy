//
//  TipsBrain.swift
//  Tipsy
//
//  Created by Antonio Casto on 02/10/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct TipsBrain {

    var tip = Tip()
    
    func getPct() -> Float {
        return tip.pct
    }
    
    mutating func setPct(percentage: Float) {
        tip.pct = percentage
    }
    
    mutating func setPeople(people: Double) {
        tip.people = people
    }
    
    func getPeople() -> Double {
        return tip.people
    }
    
    func computeResult(amount: Float) -> Float {
        return (amount + amount * tip.pct) / Float(tip.people)
    }

}
