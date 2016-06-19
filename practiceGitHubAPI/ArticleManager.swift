//
//  ArticleManager.swift
//  practiceGitHubAPI
//
//  Created by Fumiya Yamanaka on 2016/06/19.
//  Copyright © 2016年 fumiya yamanaka. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ArticleManager {
    static let sharedInstance = ArticleManager()
    
    func getArticles(params: [String], callBackClosure: ([Article]) -> ()) {
        var articles = [Article]()
        
        let urlString = "https://api.github.com/search/repositories?q=\(params.first!)+language:assembly&sort=\(params[1])&order=\(params.last!)"

        Alamofire.request(.GET, urlString).responseJSON { response in
            guard let responseValue = response.result.value else { return }
            let json = JSON(responseValue)["items"]
            json.forEach { (_, json) in
                guard let name = json["name"].string,
                    let owner = json["owner"]["login"].string,
                    let url = json["html_url"].string,
                    let description = json["description"].string,
                    let stars = json["stargazers_count"].int,
                    let forks = json["forks_count"].int,
                    let updatedAt = json["updated_at"].string
                else { return }
                
                let article = Article(name: name, owner: owner, url: url, description: description, stars: stars, forks: forks, updatedDate: updatedAt)
                articles.append(article)
            }
            
            callBackClosure(articles)
        }
    }
    
}