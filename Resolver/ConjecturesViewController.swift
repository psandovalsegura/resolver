//
//  ConjecturesViewController.swift
//  Resolver
//
//  Created by Pedro Sandoval on 3/14/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import UIKit

protocol ConjecturesViewControllerDelegate {
    func addConjecture(conjecture: Conjecture)
}

class ConjecturesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ConjecturesViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var conjectures: [Conjecture] = [Conjecture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Conjectures"
        
        // Table View Setup
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Hardcode Test
        let nd = Logic(name: "Natural Deduction")
        let conjecture1 = Conjecture(conjecture: "F ∨ G, ¬F ⊢ G", logic: nd, solved: true)
        let conjecture2 = Conjecture(conjecture: "(F → G) ∧ (F → H) ⊢ F → (G ∧ H)", logic: nd, solved: false)
        let conjecture3 = Conjecture(conjecture: "A ∧ B ⊢ B", logic: nd, solved: true)
        self.conjectures.append(conjecture1)
        self.conjectures.append(conjecture2)
        self.conjectures.append(conjecture3)
    }

    @IBAction func onAddConjecture(_ sender: Any) {
        performSegue(withIdentifier: "toConjectureCreator", sender: nil)
    }
    
    func addConjecture(conjecture: Conjecture) {
        self.conjectures.append(conjecture)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conjectures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "conjectureCell") as! ConjectureTableViewCell
        let currentConjecture = self.conjectures[indexPath.row]
        cell.conjectureLabel.text = currentConjecture.fullConjecture!
        cell.conjectureLogicLabel.text = currentConjecture.logic?.name!
        cell.completeImageView.isHidden = !((currentConjecture.solved)!)
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let conjectureCreatorVC = segue.destination as! ConjectureCreatorViewController
        conjectureCreatorVC.delegate = self
    }

}
