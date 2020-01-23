//
//  ViewController.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var dataSource: PostsTableViewDataSource? {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostFileLoader().loadPosts { [weak self] (postViewList) in
            if let postViewList = postViewList {
                self?.dataSource =  PostsTableViewDataSource(posts: postViewList)
            }
        }
    }
    
    
}

