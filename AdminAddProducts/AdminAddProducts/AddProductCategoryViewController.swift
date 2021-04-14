//
//  AddProductCategoryViewController.swift
//  AdminAddProducts
//
//  Created by Ashish Ashish on 14/04/21.
//

import UIKit
import Firebase

class AddProductCategoryViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var txtCategory: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func uploadImageAction(_ sender: Any) {
        
        let name = txtCategory.text
        
        if name == "" {
            return
        }
        
        let storageRef = Storage.storage().reference()
        // Data in memory
        let data = imgView.image?.pngData()

        // Create a reference to the file you want to upload
        let categoryRef = storageRef.child("categories/" + name! + ".png")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = categoryRef.putData(data!, metadata: nil) { (metadata, error) in
   
            if error != nil {
                print(error?.localizedDescription)
                return
            }
   
          // You can also access to download URL after upload.
            categoryRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
                
            print(downloadURL)
          }
        }
        
    }
    
    
}
