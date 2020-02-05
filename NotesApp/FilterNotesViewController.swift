//
//  FilterNotesViewController.swift
//  NotesApp
//
//  Created by Gaurav Kumar on 04/02/20.
//  Copyright © 2020 Gaurav Kumar. All rights reserved.
//

import UIKit
import RealmSwift

class FilterNotesViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var tblFilterList: UITableView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnApplyFilter: UIButton!
    @IBOutlet weak var lblSortBy: UILabel!
    
    var selectedFilter = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnApplyFilterClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "UWToNotesList", sender: nil)
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        selectedFilter = false
        tblFilterList.reloadData()
    }

}

extension FilterNotesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterDataCell", for: indexPath as IndexPath) as! FilterDataTableViewCell
        cell.lblDate.text = "Date"
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        selectedFilter = true
        
    }
    
}
