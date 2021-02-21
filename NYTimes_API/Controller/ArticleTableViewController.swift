//
//  ViewController.swift
//  NYTimes_API
//
//  Created by Евангелина Клюкай on 19.02.2021.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    private var articles: [Article] = []
    private var network = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    @objc func refresh(_ sender : AnyObject) {
        fetchData()
    }
    
    private func fetchData() {
        
        network.getArticles(completion: { (articles) in
            DispatchQueue.main.async {
                self.articles = articles
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }) { (error) in
            print(error.localizedDescription)
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showNews" {
            let articleController = segue.destination as! ArticleViewController
            articleController.article = sender as? Article
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.item]
        self.performSegue(withIdentifier: "showNews", sender: article)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleViewCell
        cell.article = articles[indexPath.row]
        return cell

    }

}

