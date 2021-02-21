//
//  New.swift
//  NYTimes_API
//
//  Created by Евангелина Клюкай on 19.02.2021.
//

import Foundation

class Article: NSObject {

    let title: String
    let abstract: String
    let byline: String
    let publishedDate: Date?
    let url: URL?

    private let multimediaItems: [Multimedia]
    
    init(data: [String: Any]) {
        self.title = data["title"] as? String ?? ""
        self.abstract = data["abstract"] as? String ?? ""
        self.byline = data["byline"] as? String ?? ""
        
        if let urlString = data["url"] as? String {
            self.url = URL(string: urlString)
        } else {
            self.url = nil
        }
        
        if let multimediaData = data["multimedia"] as? [[String: Any]] {
            self.multimediaItems = multimediaData.map({Multimedia(data: $0)})
        } else {
            self.multimediaItems = []
        }

        if let dateString = data["published_date"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

            self.publishedDate = dateFormatter.date(from: dateString)
        } else {
            self.publishedDate = nil
        }
    }
    
    func getMultimedia(maxWidth: Int, maxHeight: Int) -> Multimedia? {
        var resultMultimedia: Multimedia? = nil
        
        for multimedia in multimediaItems {
            if (multimedia.height > maxHeight || multimedia.width > maxWidth) {
                continue
            }
            
            if resultMultimedia == nil {
                resultMultimedia = multimedia
            } else if (multimedia.height > resultMultimedia!.height && multimedia.width > resultMultimedia!.width) {
                resultMultimedia = multimedia
            }
        }
        
        return resultMultimedia
    }
    
}

class Multimedia: NSObject {
    
    let width: Int
    let height: Int
    let url: URL?

    init(data: [String: Any]) {
        
        width = data["width"] as? Int ?? 0
        height = data["height"] as? Int ?? 0
        
        if let urlString = data["url"] as? String {
            self.url = URL(string: urlString)
        } else {
            self.url = nil
        }
    }
}
