//
//  ViewController.swift
//  Contact App CoreData
//
//  Created by nelson tapia on 13-07-22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Variables
    var contacts = [Contact]()
    var contactEditName: String?
    var contactEditPhone: Int64?
    var contactEditAdress: String?
    
    
    @IBOutlet weak var contactsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newContact = Contact(name: "Nelson", phone: 833837, adress: "Casa")
        contacts.append(newContact)
        
        //Registrar Celda
        contactsTable.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        contactsTable.delegate = self
        contactsTable.dataSource = self
    }
    
    //MARK: - IBAction
    @IBAction func addPressedBt(_ sender: Any) {
        let alert = UIAlertController(title: "Agregar", message: "Nuevo Contacto", preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "Agregar", style: .default) { (_) in
            print("Se agrego el contacto")
            
            guard let nameAlert = alert.textFields?[0].text else {return}
            guard let phoneAlert = alert.textFields?[1].text else {return}
            guard let adressAlert = alert.textFields?[2].text else {return}
            
            let newContact = Contact(name: nameAlert, phone: Int64(phoneAlert), adress: adressAlert)
            
            self.contacts.append(newContact)
            
            self.contactsTable.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default) { (_) in
            print("Cancelado")
        }
        
        alert.addTextField { (nameTF) in
            nameTF.placeholder = "Nombre"
        }
        alert.addTextField { (phoneTF) in
            phoneTF.placeholder = "Teléfono"
        }
        alert.addTextField { (adressTF) in
            adressTF.placeholder = "Dirección"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(acceptAction)
        
        present(alert, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        
        cell.nameLabel.text = contacts[indexPath.row].name
        cell.phoneLabel.text = "📞\(contacts[indexPath.row].phone ?? 0000)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        contactsTable.deselectRow(at: indexPath, animated: true)
        
        contactEditName = contacts[indexPath.row].name
        contactEditPhone = contacts[indexPath.row].phone
        contactEditAdress = contacts[indexPath.row].adress
        
        performSegue(withIdentifier: "editContact", sender: self)
    }
    
    //Metodos SwipeActions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "") { (_, _, _) in
            print("Borrar")
        }
        action.image = UIImage(named: "borrar.png")
        action.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionCall = UIContextualAction(style: .normal, title: "") { (_, _, _) in
            print("Llamando")
        }
        actionCall.image = UIImage(named: "llamar.png")
        actionCall.backgroundColor = .blue
        
        let actionMensaje = UIContextualAction(style: .normal, title: "") { (_, _, _) in
            print("Mensaje")
        }
        actionMensaje.image = UIImage(named: "mensaje.png")
        actionMensaje.backgroundColor = .yellow
        
        return UISwipeActionsConfiguration(actions: [actionCall, actionMensaje])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            let objEditContact = segue.destination as! EditContactViewController
            
            objEditContact.receivedName = contactEditName
            objEditContact.receivedPhone = contactEditPhone
            objEditContact.receivedAdress = contactEditAdress
            
            
        }
    }
    
    
}

