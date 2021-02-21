//
//  ArticleViewCell.swift
//  NYTimes_API
//
//  Created by Евангелина Клюкай on 20.02.2021.
//

import UIKit

class ArticleViewCell: UITableViewCell {

    @IBOutlet weak var previewImageView: WebImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
     
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy HH:mm"
        return formatter
    }()
    
    var article: Article? {
        didSet {
            guard let article = self.article else { return }
            
            titleLabel.text = article.title
            dateLabel.text = "\(dateFormatter.string(from: article.publishedDate!))"
            
            if let url = article.getMultimedia(maxWidth: 150, maxHeight: 150)?.url {
                previewImageView.load(url: url)
            } else {
                previewImageView.image = nil
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewImageView.layer.cornerRadius = 12
    }
}
