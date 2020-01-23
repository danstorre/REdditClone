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
        cell.readIconImage.alpha = postViewForCell.isRead ? 0 : 1
        cell.titlePostLabel?.text = postViewForCell.author
        
        retrieveImage(from: postViewForCell.post) { (image) in
            DispatchQueue.main.async {
                cell.postImage?.image = image
            }
        }
        return cell
    }
    
    func retrieveImage(from post: Post, closure: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .utility).async { 
            guard let urlimage = post.postImageURL else {
                print("there is no image to be shown from post \(String(describing: post.identifier.description))")
                closure(nil)
                return
            }
            do {
                let data = try Data(contentsOf: urlimage)
                let image = UIImage(data: data)
                closure(image)
            } catch {
                print("can't read image from post \(String(describing: post.identifier.description))")
                closure(nil)
            }
        }
    }
}
