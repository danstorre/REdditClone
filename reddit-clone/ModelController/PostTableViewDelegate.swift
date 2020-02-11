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
        
        if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
            do {
                try viewerCacher.setObject(postCache: PostViewItemCache(uuid: postView.post.identifier, read: true))
            }catch {
                print("could not cache post viewed with identifier: \(postView.post.identifier)")
            }
            cell.showIcon = false
            navigationDelegate?.userDidSelectOn(postView: postView)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PostTableViewCell else {
            fatalError("PostTableViewCell cell not found")
        }
        
        cell.delegate = self
        cell.readIcon.layer.cornerRadius = 5
        
        if let count = posts?.availablePosts.count, indexPath.row == (count - 1) {
            navigationDelegate?.didGotAtTheEnd()
        }
    }
    
    func dismissButtonDidPressed(postudid: String?){
        delegate?.dismissButtonDidPressed(postudid: postudid)
    }
}
