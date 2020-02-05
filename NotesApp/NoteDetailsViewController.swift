//
//  NoteDetailsViewController.swift
//  NotesApp
//
//  Created by Gaurav Kumar on 04/02/20.
//  Copyright © 2020 Gaurav Kumar. All rights reserved.
//

import UIKit
import RealmSwift

class NoteDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var imgMedia: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var notesId = String()
    var notesData: Results<NotesData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesData = NotesDataFunction.sharedInstance.QueryDataFromNotesDataTableId(selectedId: notesId)
        
        if let filePath = filePath(forKey: notesId),
            let fileData = FileManager.default.contents(atPath: filePath.path),
            let image = UIImage(data: fileData) {
            imgMedia.image = image
        }else{
            imgMedia.image = #imageLiteral(resourceName: "defaultImage")
        }
        
        lblHeading.text = notesData[0].notesId
        lblTime.text = notesData[0].createdTime
        lblTag.text = notesData[0].tags
        lblTitle.text = notesData[0].title
        tvDescription.text = notesData[0].descriptionText
        
    }
    

    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
