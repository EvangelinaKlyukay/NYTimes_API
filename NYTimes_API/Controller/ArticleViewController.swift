//
//  ArticleViewController.swift
//  NYTimes_API
//
//  Created by Евангелина Клюкай on 20.02.2021.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {
    
    var article: Article?
    
    @IBOutlet weak var imageArticle: WebImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd MMM yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article = article {
            titleLabel.text = article.title
            bylineLabel.text = article.byline
            dateLabel.text = "\(dateFormatter.string(from: article.publishedDate!))"
            articleLabel.text = article.abstract
            if let url = article.getMultimedia(maxWidth: 2048, maxHeight: 1365)?.url {
                imageArticle.load(url: url)
            } else {
                imageArticle.image = nil
            }
        }
    }
}
