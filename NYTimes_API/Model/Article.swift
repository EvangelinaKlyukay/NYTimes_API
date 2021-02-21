//
//  New.swift
//  NYTimes_API
//
//  Created by Евангелина Клюкай on 19.02.2021.
//

import Foundation

struct Article: Codable {
    let url: String
    let publishedDate: String
    let byline: String
    let title: String
    let section: String
    let media:[Media]
    
    struct Media: Codable {
        let caption: String
        let mediaMetadata: [MediaMetadata]
        
        struct MediaMetadata: Codable {
            let url: String
            let format: String
        }
        
        enum CodingKeys: String, CodingKey {
            case mediaMetadata = "media-metadata"
            case caption
        }
    }
}
