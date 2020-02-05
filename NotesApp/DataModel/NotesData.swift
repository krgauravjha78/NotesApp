//
//  NotesData.swift
//  NotesApp
//
//  Created by Gaurav Kumar on 05/02/20.
//  Copyright © 2020 Gaurav Kumar. All rights reserved.
//

import Foundation
import RealmSwift

class NotesData: Object {
    @objc dynamic var notesId = ""
    @objc dynamic var createdTime = ""
    @objc dynamic var tags = ""
    @objc dynamic var descriptionText = ""
    @objc dynamic var title = ""
    
    override static func primaryKey() -> String?{
        return "notesId"
    }
    
    func persistData(NotesData: NotesData)  {
        let realm = try! Realm()
        try! realm.write({
            realm.add(NotesData, update: .all
            )
        })
    }
    
    func deleteDataFromCurrentTripTableData(deleteData: NotesData){
        let realm = try! Realm()
        try! realm.write({
            let notesData = realm.objects(NotesData.self)
            realm.delete(notesData)
        })
    }
}
