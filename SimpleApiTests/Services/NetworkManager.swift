//
//  NetworkManager.swift
//  SimpleApiTests
//
//  Created by Nechaev Sergey  on 25.09.2021.
//

import UIKit
import WebKit

class NetworkManager {
    
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
                
                self.imageUrl = imageData.first?.url ?? ""
                self.imageId = imageData.first?.id ?? ""
                self.imageWidth = imageData.first?.width ?? 0
                self.imageHeight = imageData.first?.height ?? 0
                
            } catch let error {
                print(error)
            }
        }.resume()
        
    }
    
    func fetchImage(fromData: NetworkManager, forImageView: UIImageView, andIndicator: UIActivityIndicatorView) {
        andIndicator.isHidden = false
        andIndicator.startAnimating()
        
        guard let url = URL(string: fromData.imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
                        
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                forImageView.image = image
                andIndicator.stopAnimating()
            }
        }.resume()
    }
    
    func fetchGif(fromData: NetworkManager, forWebView: WKWebView, andIndicator: UIActivityIndicatorView) {
        
        andIndicator.isHidden = false
        andIndicator.startAnimating()
        
        guard let gifImageUrl = URL(string: fromData.imageUrl) else { return }
        let urlRequest = URLRequest(url: gifImageUrl)
        
        forWebView.load(urlRequest)
        
    }
    
}
