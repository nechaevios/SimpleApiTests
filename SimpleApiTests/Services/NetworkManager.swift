//
//  NetworkManager.swift
//  SimpleApiTests
//
//  Created by Nechaev Sergey  on 25.09.2021.
//

import Foundation
import UIKit

class TestApi {
    
    var loadedImage = UIImage(systemName: "face.smiling")
    let apiUrl: String
    
    var imageUrl = ""
    private var imageId = ""
    private var imageWidth = 0
    private var imageHeight = 0
    
    init(apiUrl: String) {
        self.apiUrl = apiUrl
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
                DispatchQueue.main.async {
                    self.imageUrl = imageData.first?.url ?? ""
                    self.imageId = imageData.first?.id ?? ""
                    self.imageWidth = imageData.first?.width ?? 0
                    self.imageHeight = imageData.first?.height ?? 0
                    print(self.imageUrl)
                }
            } catch let error {
                print(error)
            }
        }.resume()
        
    }
    
    func fetchImage() {
        guard let url = URL(string: self.imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "No error description")
                return
            }
            
            if let image = UIImage(data: data) {
                self.loadedImage = image
            }
            
//            guard let image = UIImage(data: data) else { return }
            
//            DispatchQueue.main.async {
//                self.imageView.image = image
//                self.activityIndicator.stopAnimating()
//            }
        }.resume()
        
    }
    
}
