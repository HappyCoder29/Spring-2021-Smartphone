//
//  AddProductViewController.swift
//  AdminAddProducts
//
//  Created by Ashish Ashish on 4/20/21.
//

import UIKit
import Firebase

class AddProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
   
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtCategory: UITextField!
    
    @IBOutlet weak var txtDescription: UITextField!
    
    @IBOutlet weak var isVegetarianSwitch: UISwitch!
    
    @IBOutlet weak var isActiveSwitch: UISwitch!
   
    @IBOutlet weak var txtUnitType: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var txtKeywords: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    
    var pickerViewCategories = UIPickerView()
    var pickerViewUnits = UIPickerView()
    
    
    var arrProductCategories = [ProductCategoriesModel]()
    
    var arrUnits = ["Pounds", "Dozen", "Kilograms", "Number"]
    
    var db: Firestore!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Query DB to get product Categories
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        getProductCategories()
        
        
        // Picker View Categories stubs
        pickerViewCategories.delegate = self
        pickerViewCategories.dataSource = self
        pickerViewCategories.tag = 0
        txtCategory.inputView = pickerViewCategories
        
        //Picker View Units
        pickerViewUnits.delegate = self
        pickerViewUnits.dataSource = self
        pickerViewUnits.tag = 1
        txtUnitType.inputView = pickerViewUnits
        
 

    }
    
    
    func getProductCategories(){
        db.collection("productCategories").getDocuments() { (querySnapshot, err) in
            if err != nil {
                self.lblStatus.text = "Error in getting Categories \(err?.localizedDescription ?? "Error")"
                return
            }
            
            self.arrProductCategories.removeAll()
            
            for document in querySnapshot!.documents{

                let name = document.data()["name"] as! String
                let categoryID = document.data()["categoryID"] as! String
                let image = document.data()["image"] as! String
                
                let category = ProductCategoriesModel(categoryID, name, image)
                
                self.arrProductCategories.append(category)
                
            }
        }
        
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
        
        if areAllValuesValid() == false {
            return
        }
        
        let product = getProductModel()
        
        let storageRef = Storage.storage().reference()
        // Data in memory
        let data = imgView.image?.pngData()
        // Create a reference to the file you want to upload
        let productRef = storageRef.child("products/" + txtName.text! + ".png")
        
        _ = productRef.putData(data!, metadata: nil) { (metadata, error) in
            
            if error != nil {
                self.lblStatus.text = "Unable to upload image \(error!.localizedDescription)"
                return
            }
            
            // We are able to successfully upload image file
            productRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    self.lblStatus.text = "Unable to get URL \(error!.localizedDescription)"
                    return
                }
                // Assign the image to the downloadURL
                product.image = downloadURL.absoluteString
                
                self.addProductToDB(product)
                
            }
            
        }
        
    }
    
    
    func addProductToDB(_ product : ProductModel){
        
        let newProduct = db.collection("products").document()
        
        product.productID = newProduct.documentID
        
        newProduct.setData([
            "categoryID" : product.categoryID,
            "description" : product.description,
            "image" : product.image,
            "isActive" : product.isActive,
            "isVegetarian" : product.isVegetarian,
            "keywords" : product.keywords,
            "name" : product.name,
            "productID" : product.productID,
            "unitType" : product.unitType
        ])
        self.navigationController?.popViewController(animated: true)
    }
    
    func areAllValuesValid() -> Bool{
        
        if  txtCategory.text == "" ||
            txtDescription.text == "" ||
            txtKeywords.text == "" ||
            txtUnitType.text == "" ||
            txtName.text == "" {
            lblStatus.text = "Please enter all values"
            return false
        }
        return true
        
    }
    
    func getProductModel() -> ProductModel{
        let product = ProductModel()
        product.categoryID = arrProductCategories.filter{ $0.name == txtCategory.text }.first!.categoryID
        product.description = txtDescription.text!
        product.isActive = isActiveSwitch.isOn
        product.isVegetarian = isVegetarianSwitch.isOn
        product.keywords = (txtKeywords.text?.components(separatedBy: ","))!
        product.name = txtName.text!
        product.unitType = txtUnitType.text!
        
        return product
        
    }
    
    
    
    //MARK : Picker view Stubs
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if pickerView.tag == 0 {
            return arrProductCategories.count
        }
        
        return arrUnits.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return arrProductCategories[row].name
        }
        return arrUnits[row]

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            txtCategory.text = arrProductCategories[row].name
            txtCategory.resignFirstResponder()
        }
        else {
            txtUnitType.text = arrUnits[row]
            txtUnitType.resignFirstResponder()
        }
        
    }
    

}
