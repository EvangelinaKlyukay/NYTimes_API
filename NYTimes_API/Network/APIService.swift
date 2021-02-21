//
//  APIService.swift
//  NYTimes_API
//
//  Created by Евангелина Клюкай on 19.02.2021.
//

import Foundation
import Alamofire

class APIService {

    let api_key = "tGfkijceXaIxcSsmKYMkMAFrbxl9lFOb"

    func getArticles(completion: @escaping ([Article]) -> Void, onFail: ((Error) -> Void)?) {

        AF.request("https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(api_key)").responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let json = data as? [String: Any], let results = json["results"] as? [[String: Any]] else {
                    print("Unable to parse response")
                    return
                }

                let articles = results.map({ Article(data: $0)})
                completion(articles)

            case .failure(let error):
                print(error.localizedDescription)
                onFail?(error)
            }
        }
    }
}
