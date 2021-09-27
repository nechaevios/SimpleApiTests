//
//  NetworkManager.swift
//  SimpleApiTests
//
//  Created by Nechaev Sergey  on 25.09.2021.
//

import UIKit
import WebKit

class DataManager {
    
    let apiUrl: String
    
    var imageUrl = ""
    
    private var imageId = ""
    private var imageWidth = 0
    private var imageHeight = 0
    
    var description: String {
        """
        id: \(imageId)
        width: \(imageWidth)
        height: \(imageHeight)
        """
    }
    
    init(apiUrl: ApiLinks) {
        self.apiUrl = apiUrl.rawValue
        
    }
    
    func getImageData() {
        guard let url = URL(string: apiUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "No error description")
                return
            }
            
            do {
                let imageData = try JSONDecoder().decode([ImageData].self, from: data)
                
                self.imageUrl = imageData.first?.url ?? ""
                self.imageId = imageData.first?.id ?? ""
                self.imageWidth = imageData.first?.width ?? 0
                self.imageHeight = imageData.first?.height ?? 0
                
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
