//
//  ViewController.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit


class ViewController: UIViewController, PostTableViewCellDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var dataSource: PostsTableViewDataSource? {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }
    
    var delegate: PostTableViewDelegate? {
        didSet {
            tableView.delegate = delegate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostFileLoader().loadPosts { [weak self] (postViewList) in
            if let postViewList = postViewList {
                
                guard let sSelf = self else{
                    return
                }
                sSelf.dataSource =  PostsTableViewDataSource(posts: postViewList)
                sSelf.delegate = PostTableViewDelegate(posts: postViewList, delegate: sSelf)
            }
        }
    }
    
    func dismissButtonDidPressed(postudid: UUID?) {
        tableView.performBatchUpdates({
            let postView = dataSource?.posts.availablePosts.filter({ (postView) -> Bool in
                return postudid == postView.post.identifier
                }).first
            
            postView?.isDeleted = true
            
            let theCellToDelete = tableView.visibleCells.filter { (cell) -> Bool in
                guard let cell = cell as? PostTableViewCell,
                    let postView = postView,
                    let idenfierCell = cell.identifierPost,
                    postView.post.identifier == idenfierCell else {
                    return false
                }
                return true
            }.first
            
            if let theCellToDelete = theCellToDelete, let indexPathOfCell = tableView.indexPath(for: theCellToDelete) {
                tableView.deleteRows(at: [indexPathOfCell], with: .left)
            }
        }, completion: nil)
    }
}

