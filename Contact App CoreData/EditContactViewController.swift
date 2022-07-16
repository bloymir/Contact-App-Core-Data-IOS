//
//  EditContactViewController.swift
//  Contact App CoreData
//
//  Created by nelson tapia on 15-07-22.
//

import UIKit

class EditContactViewController: UIViewController {
    
    var receivedName: String?
    var receivedPhone: Int64?
    var receivedAdress: String?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var contactImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.text = receivedName
        phoneTextField.text = ("\(receivedPhone)")
        adressTextField.text = receivedAdress
        
        //MARK: - Agregar Gestura Imagen
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickImagen))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        //Agregar Gestura a imagen
        contactImage.addGestureRecognizer(gesture)
        contactImage.isUserInteractionEnabled = true
        
        
    }
    
    @objc func clickImagen(gesture: UITapGestureRecognizer){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    

    @IBAction func takePhotoBT(_ sender: UIBarButtonItem) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func saveBT(_ sender: UIButton) {
    }
    
    @IBAction func CancellBT(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Protocolo para gestura de imagen y seleccionar imagen
extension EditContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Que va a pasar cuando el usuario selecciona una imagen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            contactImage.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
