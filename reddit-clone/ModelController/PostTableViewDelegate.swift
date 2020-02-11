//
//  PostTableViewDelegate.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit

protocol NavigationPostDetail: AnyObject {
    func userDidSelectOn(postView: PostView?)
    func didGotAtTheEnd()
}

class PostTableViewDelegate: NSObject, UITableViewDelegate, PostTableViewCellDelegate {
    var posts: PostViewList?
    let imageCacher: ImageCacher = ImageCacher()
    weak var delegate: PostTableViewCellDelegate?
    weak var navigationDelegate: NavigationPostDetail?
    
    init(posts: PostViewList, delegate: PostTableViewCellDelegate, navigationDelegate: NavigationPostDetail) {
        self.posts = posts
        self.delegate = delegate
        self.navigationDelegate = navigationDelegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let postView = posts?.availablePosts[indexPath.row] else {
            return
        }
        
        postView.isRead = true
        
        if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                var set = Set(appDelegate.postCacheArray)
                set.insert(PostViewItemCache(uuid: postView.post.identifier, read: true))
                appDelegate.postCacheArray = Array(set)
            }
            cell.showIcon = false
            navigationDelegate?.userDidSelectOn(postView: postView)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PostTableViewCell, let postViewForCell = posts?.availablePosts[indexPath.row] else {
            fatalError("PostTableViewCell cell not found")
        }
        
        cell.delegate = self
        cell.readIcon.layer.cornerRadius = 5
        cell.showIcon = !postViewForCell.isRead
        if let count = posts?.availablePosts.count, indexPath.row == (count - 1) {
            navigationDelegate?.didGotAtTheEnd()
        }
    }
    
    func dismissButtonDidPressed(postudid: String?){
        delegate?.dismissButtonDidPressed(postudid: postudid)
    }
}
