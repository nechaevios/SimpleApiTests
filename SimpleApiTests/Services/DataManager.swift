//
//  NetworkManager.swift
//  SimpleApiTests
//
//  Created by Nechaev Sergey  on 25.09.2021.
//

import Foundation

class DataManager {
    
    let apiUrl: String
        
    var imageListData: [ImageData] = []
    
    init(apiUrl: ApiLinks) {
        self.apiUrl = apiUrl.rawValue
        
    }
    
    func fetchApiData() {
        guard let url = URL(string: apiUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "No error description")
                return
            }
            
            do {
                self.imageListData = try JSONDecoder().decode([ImageData].self, from: data)
                
            } catch let error {
                print(error)
            }
        }.resume()
        
    }
}


extension DataManager {
    enum ApiLinks: String {
        case singleImageUrl = "https://api.thecatapi.com/v1/images/search?mime_types=jpg,png"
        case singleGifUrl = "https://api.thecatapi.com/v1/images/search?mime_types=gif"
        
    }
}
