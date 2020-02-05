//
//  AddNotesViewController.swift
//  NotesApp
//
//  Created by Gaurav Kumar on 04/02/20.
//  Copyright © 2020 Gaurav Kumar. All rights reserved.
//

import UIKit
import RealmSwift

class AddNotesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAttachNotes: UIButton!
    @IBOutlet weak var btnAddNotes: UIButton!
    @IBOutlet weak var lblAddTitle: UILabel!
    @IBOutlet weak var lblAddTag: UILabel!
    @IBOutlet weak var lblAddDescription: UILabel!
    @IBOutlet weak var tfAddTitle: UITextField!
    @IBOutlet weak var tfAddTag: UITextField!
    @IBOutlet weak var tvDescription: UITextView!
    
    let picker = UIImagePickerController()
    var noteId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteId = generateNoteId()
        picker.delegate = self
        btnAttachNotes.setTitleColor(.white, for: .normal)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        if let pngRepresentation = chosenImage.pngData() {
                if let filePath = filePath(forKey: noteId) {
                    var deletePath  = filePath
                    deletePath.removeAllCachedResourceValues()
                    do  {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
        }
        btnAttachNotes.setTitleColor(.systemGreen, for: .normal)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    

    @IBAction func btnAddNotesClicked(_ sender: Any) {
        
        if tfAddTitle.text == "" || tvDescription.text == "" {
            showAlertMessage(vc: self, titleStr:"Alert", messageStr: "Please Fill The Required Items Title & Description")
        }else{
            let title = tfAddTitle.text
            let tag = tfAddTag.text
            let description = tvDescription.text
            let currentTime = Date()
            let createdTime = currentTime.toString(dateFormat: "yyyy-MM-dd HH:mm:ss")
            let finalNotes = ["notesId":noteId,"createdTime":createdTime,"tags":tag,"descriptionText":description,"title":title] as! [String:String]
            NotesDataFunction.sharedInstance.InsertIntoNotesData(NotesDataArray: [finalNotes])
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func btnAttachMediaClicked(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        }else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            picker.sourceType = .savedPhotosAlbum
            picker.allowsEditing = false
            present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
