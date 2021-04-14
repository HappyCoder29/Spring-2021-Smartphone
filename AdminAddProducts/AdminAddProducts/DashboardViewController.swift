//
//  DashboardViewController.swift
//  AdminAddProducts
//
//  Created by Ashish Ashish on 14/04/21.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            KeychainService().keyChain.delete("uid")
            self.navigationController?.popViewController(animated: true)
            
        } catch{
            print (error)
            
        }
        
    }
}
