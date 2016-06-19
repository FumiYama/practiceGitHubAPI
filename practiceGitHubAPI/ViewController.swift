//
//  ViewController.swift
//  practiceGitHubAPI
//
//  Created by Fumiya Yamanaka on 2016/06/11.
//  Copyright © 2016年 fumiya yamanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var orderSegmentedControl: UISegmentedControl!
    
    private var articles = [Article]()
    private var array: [String] = ["q", "stars", "desc"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let articleNib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.registerNib(articleNib, forCellReuseIdentifier: "articleCell")
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPathForSelectedRow, animated: true)
        }
    }
    
    func getData() {
        ArticleManager.sharedInstance.getArticles(array) { [weak self] articles in
            guard let me = self else { return }
            
            me.articles = articles
            me.tableView.reloadData()
        }
    }
    
    //サーチバー更新時
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        array[0] = searchText
        getData()
    }
    
//    セグメント選択
    @IBAction func changeSortSC(sender: AnyObject) {
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0:
            print("stars選択")
            array[1] = "stars"
        case 1:
            print("forks選択")
            array[1] = "forks"
        case 2:
            print("updated選択")
            array[1] = "updated"
        default:
            print("Error")
        }
        getData()
    }
    
    @IBAction func changeOrderSC(sender: AnyObject) {
        switch orderSegmentedControl.selectedSegmentIndex {
        case 0:
            print("desc選択")
            array[2] = "desc"
        case 1:
            print("asc選択")
            array[2] = "asc"
        default:
            print("Error")
        }
        getData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell") as! ArticleTableViewCell
        cell.nameLabel.text = articles[indexPath.row].name
        cell.ownerLabel.text = "user: " + articles[indexPath.row].owner
        cell.descriptionLabel.text = articles[indexPath.row].description
        cell.forksLabel.text = "Forks: " + String(articles[indexPath.row].forks)
        cell.starsLabel.text = "Stars: " + String(articles[indexPath.row].stars)
        cell.updatedDateLabel.text = "update: " + articles[indexPath.row].updatedDate

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("セルの選択: \(indexPath.row)")

        guard let url = NSURL(string: articles[indexPath.row].url) else { return }
        if UIApplication.sharedApplication().canOpenURL(url){
            UIApplication.sharedApplication().openURL(url)
        }
    }
}
