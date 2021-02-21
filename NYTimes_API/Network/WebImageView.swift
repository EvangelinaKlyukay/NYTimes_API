//
//  WebImageView.swift
//  NYTimes_API
//
//  Created by Евангелина Клюкай on 19.02.2021.
//

import UIKit

class WebImageView: UIImageView {
    func load(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, respons, error) in
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
    
}
