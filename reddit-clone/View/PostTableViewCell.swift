//
//  PostTableViewCell.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit


protocol PostTableViewCellDelegate: AnyObject {
    func dismissButtonDidPressed(postudid: String?)
}

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet var titlePostLabel: UILabel!
    @IBOutlet var entryDate: UILabel!
    @IBOutlet var readIcon: UIView!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var dismissPostButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    var delegate: PostTableViewCellDelegate?
    
    var identifierPost: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func dismissButtonDidPressed(_ sender: UIButton) {
        delegate?.dismissButtonDidPressed(postudid: identifierPost)
    }
    
}
