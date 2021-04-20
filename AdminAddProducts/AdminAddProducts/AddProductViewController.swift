//
//  AddProductViewController.swift
//  AdminAddProducts
//
//  Created by Ashish Ashish on 4/20/21.
//

import UIKit

class AddProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtCategory: UITextField!
    
    @IBOutlet weak var txtDescription: UITextField!
    
    @IBOutlet weak var isVegetarianSwitch: UISwitch!
    
    @IBOutlet weak var isActivSwitch: UISwitch!
   
    @IBOutlet weak var txtUnitType: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func selectImageAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let pickedImage = info[.originalImage] as? UIImage{
            imgView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
    }
    
    
    

}
