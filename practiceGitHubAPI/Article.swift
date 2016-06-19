//
//  Article.swift
//  practiceGitHubAPI
//
//  Created by Fumiya Yamanaka on 2016/06/19.
//  Copyright © 2016年 fumiya yamanaka. All rights reserved.
//

import Foundation

class Article {
    var name: String
    var owner: String
    var url: String
    var description: String
    var stars: Int
    var forks: Int
    var updatedDate: String
    
    init(name: String, owner: String, url: String, description: String, stars: Int, forks: Int, updatedDate: String) {
        self.name = name
        self.owner = owner
        self.url = url
        self.description = description
        self.stars = stars
        self.forks = forks

        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // "2016-06-17T21:38:46Z"
        let date: NSDate = formatter.dateFromString(updatedDate)!

        formatter.dateFormat = "yyyy/MM/dd"
        self.updatedDate = formatter.stringFromDate(date)
    }
    
}