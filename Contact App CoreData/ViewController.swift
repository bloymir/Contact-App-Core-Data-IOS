//
//  ViewController.swift
//  Contact App CoreData
//
//  Created by nelson tapia on 13-07-22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var contactsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registrar Celda
        contactsTable.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        contactsTable.delegate = self
        contactsTable.dataSource = self
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        
        cell.nameLabel.text = "nelson"
        cell.phoneLabel.text = "737272"
        
        
        return cell
    }
    
    
}

