//
//  NotesDataFunction.swift
//  NotesApp
//
//  Created by Gaurav Kumar on 05/02/20.
//  Copyright © 2020 Gaurav Kumar. All rights reserved.
//

import Foundation
import RealmSwift

class NotesDataFunction: NSObject {
    
    static let sharedInstance = NotesDataFunction()
    
    func InsertIntoNotesData(NotesDataArray:[[String:String]]) {
        
        for data in NotesDataArray {
            
            let notesData = NotesData()
            
            if let notesId = data["notesId"] {
                notesData.notesId = notesId
            }
            if let createdTime = data["createdTime"] {
                notesData.createdTime = createdTime
            }
            if let tags = data["tags"] {
                notesData.tags = tags
            }
            if let descriptionText = data["descriptionText"] {
                notesData.descriptionText = descriptionText
            }
            if let title = data["title"] {
                notesData.title = title
            }
            
            notesData.persistData(NotesData: notesData)
            
        }
        
    }
    
    func QueryDataFromNotesDataTable()-> Results<NotesData>{
        do{
            let realm = try! Realm()
            let noteObject = realm.objects(NotesData.self)
            return noteObject
        }
    }
    
    func QueryDataFromNotesDataTableId(selectedId: String)-> Results<NotesData>{
        let realm = try! Realm()
        let noteRecord = realm.objects(NotesData.self).filter("notesId == '\(selectedId)'")
        return noteRecord
    }
    
    
}
