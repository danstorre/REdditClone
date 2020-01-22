//
//  PostTableViewCell.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet var titlePostLabel: UILabel!
    @IBOutlet var entryDate: UILabel!
    @IBOutlet var readIconImage: UIImage!
    @IBOutlet var postImage: UIImage!
    @IBOutlet var commentsLabel: UIImage!
    @IBOutlet var dismissPostButton: UIButton!
    @IBOutlet var descriptionLabel: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
