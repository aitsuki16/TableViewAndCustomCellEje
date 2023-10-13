//
//  APIFetchHandler.swift
//  TableViewAndCutomCellEje
//
//  Created by user on 2023/10/08.
//
import Foundation
import Alamofire


class APIFetchHandler {
    func fetchData(completion: @escaping ([Article]?, Error?) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request("https://qiita.com/api/v2/items").responseDecodable(of: [Article].self){ response in
            switch response.result {
            case .success:
                if let articles = response.value {
                    print("articles: \(articles)")
                } else {
                    print("articles is nil")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
struct Article: Codable {
    let title: String
    let url: URL
    let updatedAt: String?
    let user: User
    
    struct User: Codable {
        let id: String
        let profile_image_url: URL
        let name: String
        
    }
}
