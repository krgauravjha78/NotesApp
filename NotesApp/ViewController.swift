//
//  ViewController.swift
//  NotesApp
//
//  Created by Gaurav Kumar on 04/02/20.
//  Copyright © 2020 Gaurav Kumar. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnAddNotes: UIButton!
    @IBOutlet weak var searchNotes: UISearchBar!
    @IBOutlet weak var tblNotesList: UITableView!
    
    var notesData: Results<NotesData>!
    var filteredNotesData: Results<NotesData>!
    var selectedNoteId = String()
    var parentScreen = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNotesList.register(UINib(nibName: "AddNotesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "addNotesCell")
        self.tblNotesList.estimatedRowHeight = 100
        tblNotesList.delegate = self
        tblNotesList.dataSource =  self
//        tblNotesList.reloadData()
        tblNotesList.separatorColor = .clear
        searchNotes.delegate = self
        parentScreen = ""
        tblNotesList.layoutIfNeeded()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if parentScreen == "FilterDataTableViewCell" {
            notesData = NotesDataFunction.sharedInstance.QueryDataFromNotesDataTable().sorted(byKeyPath: "createdTime", ascending: false)
            filteredNotesData = notesData
        }else{
            notesData = NotesDataFunction.sharedInstance.QueryDataFromNotesDataTable()
            filteredNotesData = notesData
        }
        
        tblNotesList.reloadData()
    }
    
    @IBAction func btnAddNotesClicked(_ sender: Any) {
        self .performSegue(withIdentifier: "notesListToAddNotesSegue", sender: nil)
    }
    
    @IBAction func btnFilterClicked(_ sender: Any) {
        self .performSegue(withIdentifier: "notesListToFilterSegue", sender: nil)
    }
    
    @IBAction func unwindtoNotesListScreen(segue:UIStoryboardSegue) {
        if segue.identifier == "UWToNotesList" {
            let viewController = segue.source as! FilterNotesViewController
            if viewController.selectedFilter{
                self.parentScreen = "FilterDataTableViewCell"
            }else{
                self.parentScreen = ""
            }
        }
    }
    
}

extension ViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData(text: searchText)
    }
    
    func searchData(text: String) {
        if text == "" {
            notesData = filteredNotesData
        } else {
            notesData = filteredNotesData.filter("title contains[c] %@ OR descriptionText contains[c] %@", text,text)
        }
        
        tblNotesList.reloadData()
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if notesData != nil {
            return notesData.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addNotesCell") as! AddNotesTableViewCell
        
        cell.lblTag.text = notesData[indexPath.row].tags
        cell.lblTitle.text = notesData[indexPath.row].title
        cell.lbldescription.text = notesData[indexPath.row].descriptionText
        cell.lblTime.text = notesData[indexPath.row].createdTime
        
        if let filePath = filePath(forKey: notesData[indexPath.row].notesId),
            let fileData = FileManager.default.contents(atPath: filePath.path),
            let image = UIImage(data: fileData) {
            cell.imgMedia.image = image
            cell.imgWidth.constant = 80
        }else{
            cell.imgMedia.image = #imageLiteral(resourceName: "Clock")
            cell.imgWidth.constant = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNoteId = notesData[indexPath.row].notesId
        self .performSegue(withIdentifier: "notesListToDetailsSegue", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "notesListToDetailsSegue"{
            if let tvC = segue.destination as? NoteDetailsViewController {
                tvC.notesId = selectedNoteId
            }
        }
        
        
    }
    
    
}

