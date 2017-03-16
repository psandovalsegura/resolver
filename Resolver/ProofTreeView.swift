//
//  ProofTreeView.swift
//  Resolver
//
//  Created by Pedro Sandoval on 3/15/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import UIKit

class ProofTreeView: ProofElementView {
    
    @IBOutlet var view: UIView!
    var subProofs: [ProofTreeView]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("ProofTreeView", owner: self, options: nil)
        view.frame = self.bounds //Constrain the UIView to the Symbols Keyboard view
        self.addSubview(view)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
