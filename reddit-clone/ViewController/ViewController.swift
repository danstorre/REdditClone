//
//  ViewController.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit


class ViewController: UIViewController, PostTableViewCellDelegate, NavigationPostDetail{
    
    @IBOutlet var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var loader = NetworkPostLoader()
    var postViewList: PostViewList? = nil
    
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
        tableView.tableFooterView = UIView()
        loadData()
        
        let string = "Pull to refresh"
        let mutableAtributesString = NSMutableAttributedString(string: string)
        mutableAtributesString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(named: "white")!],
                                             range: NSRange(location: 0, length: string.count))
        
        refreshControl.attributedTitle = mutableAtributesString
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func loadData() {
        loader.loadPosts { [weak self] (postList) in
            DispatchQueue.main.async {
                
                guard let postList = postList else {
                    return
                }
                
                let postViews = postList.posts.map { (post) -> PostView in
                    return PostView(post: post, isRead: false)
                }
                
                guard let sSelf = self else{
                    return
                }
                
                guard sSelf.postViewList == nil else {
                    sSelf.tableView.performBatchUpdates({
                        sSelf.postViewList?.appendNew(posts: postViews)
                        sSelf.postViewList?.after = postList.after
                    }, completion: nil)
                    sSelf.refreshControl.endRefreshing()
                    return
                }
                
                let newPostViewList = PostViewList(posts: postViews, after: postList.after)
                sSelf.postViewList = newPostViewList
                sSelf.dataSource =  PostsTableViewDataSource(posts: newPostViewList)
                sSelf.delegate = PostTableViewDelegate(posts: newPostViewList, delegate: sSelf, navigationDelegate: sSelf)
                sSelf.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func refresh() {
        loadData()
    }
    
    func dismissButtonDidPressed(postudid: String?) {
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
    
    @IBAction func dismissAllButtonPressed(_ sender: UIButton) {
        tableView.performBatchUpdates({
            guard let postViews = dataSource?.posts.availablePosts else {
                return
            }
            
            for postView in postViews {
                postView.isDeleted = true
            }
            tableView.deleteSections(IndexSet(arrayLiteral: 0),
                                     with: UITableView.RowAnimation.left)
        }, completion: nil)
    }
    
    func userDidSelectOn(postView: PostView?) {
        guard let postView = postView else {
            return
        }
        
        if let vc = storyboard?.instantiateViewController(identifier: "DetailPostViewController") as? DetailPostViewController {
            vc.postView = postView
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

