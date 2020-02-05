//
//  AddNotesTableViewCell.swift
//  NotesApp
//
//  Created by Gaurav Kumar on 04/02/20.
//  Copyright © 2020 Gaurav Kumar. All rights reserved.
//

import UIKit

class AddNotesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgClock: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgTag: UIImageView!
    
    @IBOutlet weak var imgMedia: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
