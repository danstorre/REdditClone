//
//  PostsTableViewDataSource.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit

class PostsTableViewDataSource: NSObject, UITableViewDataSource {
    
    var posts: PostViewList
    let imageCacher: ImageCacher = ImageCacher()
    
    init(posts: PostViewList) {
        self.posts = posts
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.availablePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else {
            fatalError("PostTableViewCell cell not found")
        }
        let postViewForCell = posts.availablePosts[indexPath.row]
        cell.commentsLabel?.text = postViewForCell.numberOfComments
        cell.descriptionLabel?.text = postViewForCell.minimumDescription
        cell.entryDate?.text = postViewForCell.readableDate
        cell.readIcon.alpha = postViewForCell.isRead ? 0 : 1
        cell.titlePostLabel?.text = postViewForCell.author
        
        
        
        retrieveImage(from: postViewForCell.post) { (image) in
            DispatchQueue.main.async {
                cell.postImage?.image = image
            }
        }
        
        cell.readIcon.layer.cornerRadius = 5
        
        cell.dismissPostButton.imageView?.tintColor = UIColor(named: "yellow")
        cell.dismissPostButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0);
//        cell.dismissPostButton.titleLabel?.numberOfLines = 0
        return cell
    }
    
    
    func retrieveImage(from post: Post, closure: @escaping (UIImage?) -> ()) {
        guard let urlimage = post.postImageURL else {
            print("there is no image to be shown from post \(String(describing: post.identifier.description))")
            closure(nil)
            return
        }
        
        imageCacher.retrieveObject(key: urlimage) { (image) in
            if let image = image {
                closure(image)
                return
            }
            
            DispatchQueue.global(qos: .utility).async { [weak self] in
                do {
                    let data = try Data(contentsOf: urlimage)
                    let image = UIImage(data: data)
                    try self?.imageCacher.setObject(key: urlimage, object: image)
                    closure(image)
                } catch {
                    print("can't read image from post \(String(describing: post.identifier.description))")
                    closure(nil)
                }
            }
        }
    }
}
