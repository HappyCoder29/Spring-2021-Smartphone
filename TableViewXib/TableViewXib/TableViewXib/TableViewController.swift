//
//  TableViewController.swift
//  TableViewXib
//
//  Created by Ashish Ashish on 10/02/21.
//

import UIKit

class TableViewController: UITableViewController {

    let cities = ["Seattle", "Portand", "SFO", "LA", "Diego", "NY", "Maimi", "Washington DC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        
        cell.lblCity.text = cities[indexPath.row]

        return cell
    }


}