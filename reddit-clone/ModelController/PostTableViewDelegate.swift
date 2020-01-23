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
}

class PostTableViewDelegate: NSObject, UITableViewDelegate, PostTableViewCellDelegate {
    var posts: PostViewList?
    let imageCacher: ImageCacher = ImageCacher()
    let viewerCacher: ViewerCache = ViewerCache()
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
        
        do {
            try viewerCacher.setObject(postCache: PostViewItemCache(uuid: postView.post.identifier, read: true))
        }catch {
            print("could not cache post viewed with identifier: \(postView.post.identifier)")
        }
        
        tableView.performBatchUpdates({
            if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    cell.readIcon.isHidden = true
                    self?.navigationDelegate?.userDidSelectOn(postView: postView)
                }
            }
        }) { (completed) in
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PostTableViewCell else {
            fatalError("PostTableViewCell cell not found")
        }
        
        cell.delegate = self
        cell.readIcon.layer.cornerRadius = 5
    }
    
    func dismissButtonDidPressed(postudid: String?){
        delegate?.dismissButtonDidPressed(postudid: postudid)
    }
}
