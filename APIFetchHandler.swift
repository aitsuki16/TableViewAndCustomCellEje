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
        print("Fetching data...") //         
        Alamofire.request("https://qiita.com/api/v2/items").responseJSON { response in
            switch response.result {
            case .success(let value):
                if let responseValue = value as? [[String: Any]] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: responseValue)
                        let decoder = JSONDecoder()
                        let articles = try decoder.decode([Article].self, from: jsonData)
                        
                        print("Parsed Articles:")
                        print(articles)
                        
                        completion(articles, nil)
                    } catch {
                        print("JSON Parsing Error:", error)
                        completion(nil, error)
                    }
                } else {
                    
                    print("Invalid response data")
                    completion(nil, NSError(domain: "Invalid response data", code: 0, userInfo: nil))
                }
            case .failure(let error):
                print("Network Request Error:", error)
                completion(nil, error)
            }
        }
    }
}

struct Article: Codable {
    let title: String?
    let url: URL
    let updated_at: Date?
    let user: User?
    
    struct User: Codable {
        let id: Int?
        let profileImageUrl: URL?
        let name: String?
    }
}
