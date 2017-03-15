//
//  ConjectureCreatorViewController.swift
//  Resolver
//
//  Created by Pedro Sandoval on 3/14/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import UIKit

class ConjectureCreatorViewController: UIViewController, UITextFieldDelegate, SymbolsKeyboardDelegate {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var symbolsKeyboardView: SymbolsKeyboardView!
    var delegate: ConjecturesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        textField.becomeFirstResponder()
        self.symbolsKeyboardView.delegate = self
    }

    func onSymbolTap(buttonTag: Int) {
        switch buttonTag {
        case 0:
            self.textField.text?.append("⊢")
        case 1:
            self.textField.text?.append("→")
        case 2:
            self.textField.text?.append("∧")
        case 3:
            self.textField.text?.append("∨")
        case 4:
            self.textField.text?.append("¬")
        case 5:
            self.textField.text?.append("⊥")
        case 6:
            self.textField.text?.append("⊤")
        default: break
        }
    }
    
    @IBAction func onDone(_ sender: Any) {
        dismiss(animated: true) { 
            // TODO: Save conjecture to the array of conjectures
            // TODO: Figure out if the conjecture is valid
            let defaultLogic = Logic(name: "Natural Deduction")
            let newConjecture = Conjecture(conjecture: self.textField.text!, logic: defaultLogic, solved: false)
            self.delegate?.addConjecture(conjecture: newConjecture)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
