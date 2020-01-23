//
//  PostView.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

protocol Readable {
    var isRead: Bool { get set }
}

protocol Deletable {
    var isDeleted: Bool {get set}
}

struct PostView: Readable, Deletable, Hashable{
    var post: Post
    var isRead: Bool
    var isDeleted: Bool
    let identifier = UUID()
    
    var readableDate: String {
        return post.entryDate.getElapsedInterval()
    }
    
    var numberOfComments: String {
        return "\(post.comments) comments"
    }
    
    var minimumDescription: String {
        return post.title.components(separatedBy: ".").first ?? post.title
    }
    
    init(post: Post, isRead: Bool) {
        self.post = post
        self.isRead = isRead
        self.isDeleted = false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: PostView, rhs: PostView) -> Bool {
        return lhs.post == rhs.post
    }
}

extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"
            
        }
        
    }
}
