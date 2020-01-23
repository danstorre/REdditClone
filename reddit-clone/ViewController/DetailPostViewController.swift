//
//  DetailPostViewController.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    @IBOutlet var titlePostLabel: UILabel!
    @IBOutlet var postImageButton: UIButton!
    @IBOutlet var descriptionPostLabel: UILabel!
    
    var postView: PostView?
    
    private var imageCacher = ImageCacher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let postView = postView else {
            return
        }
        
        titlePostLabel.text = postView.author
        if let urlImage = postView.urlImage {
            imageCacher.retrieveObject(key: urlImage) { [weak self] (image) in
                guard let image = image else{
                    return
                }
                DispatchQueue.main.async {
                    self?.postImageButton.setBackgroundImage(image, for: UIControl.State.normal)
                }
            }
        }
        descriptionPostLabel.text = postView.largeDescription
    }
    
    @IBAction func picturePostButtonPressed(_ sender: Any) {
        
        //save image in photos
    }
    
}
