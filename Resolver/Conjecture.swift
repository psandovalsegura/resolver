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
    var logic: Logic?
    var solved: Bool?
    
    init(conjecture: String, logic: Logic, solved: Bool) {
        self.fullConjecture = conjecture
        self.logic = logic
        self.solved = solved
    }
}
