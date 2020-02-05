//
//  CommonFunction.swift
//  NotesApp
//
//  Created by Gaurav Kumar on 05/02/20.
//  Copyright © 2020 Gaurav Kumar. All rights reserved.
//

import Foundation
import UIKit

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}

func generateNoteId() -> String {
    let note =  UUID().uuidString
    let noteVal = note.index(note.startIndex, offsetBy: 6)
    let noteId = note[..<noteVal]
    return "GA_"+String(noteId)
}

func filePath(forKey key: String) -> URL? {
    let fileManager = FileManager.default
    guard let documentURL = fileManager.urls(for: .documentDirectory,
                                            in: FileManager.SearchPathDomainMask.userDomainMask).first
    else {
        return nil
    }
    return documentURL.appendingPathComponent(key + ".png")
}

func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
    let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
    let okAction = UIAlertAction(title: "OK", style: .default)
    alert.addAction(okAction)
    vc.present(alert, animated: true, completion: nil)
}
