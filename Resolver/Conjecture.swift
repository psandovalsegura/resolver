//
//  Conjecture.swift
//  Resolver
//
//  Created by Pedro Sandoval on 3/14/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import Foundation

class Conjecture {
    var fullConjecture: String?
    var premises: [String]?
    var conclusion: String?
    var logic: Logic?
    var solved: Bool?
    
    init(conjecture: String, logic: Logic, solved: Bool) {
        // Remove spaces from the conjecture and store the conjecture
        let trimmedConjecture = conjecture.replacingOccurrences(of: " ", with: "")
        self.fullConjecture = trimmedConjecture
        
        // Parse the full conjecture as an array of premises and a conclusion
        self.premises = [String]()
        let statements = trimmedConjecture.components(separatedBy: "⊢")
        
        // There should only be two statements [Premises, Conclusion]
        self.premises = statements[0].components(separatedBy: ",")
        self.conclusion = statements[1]
        
        self.logic = logic
        self.solved = solved
    }
}
