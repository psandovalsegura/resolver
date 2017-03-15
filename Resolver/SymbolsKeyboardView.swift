//
//  SymbolsKeyboardView.swift
//  Resolver
//
//  Created by Pedro Sandoval on 3/14/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import UIKit

protocol SymbolsKeyboardDelegate: class {
    func onSymbolTap(buttonTag: Int)
}

class SymbolsKeyboardView: UIView {
    
    var delegate: SymbolsKeyboardDelegate?
    @IBOutlet var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("SymbolsKeyboardView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    @IBAction func onButtonTap(_ sender: UIButton) {
        self.delegate?.onSymbolTap(buttonTag: sender.tag)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
