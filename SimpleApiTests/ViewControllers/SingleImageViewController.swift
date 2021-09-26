//
//  SingleImageViewController.swift
//  SimpleApiTests
//
//  Created by Nechaev Sergey  on 25.09.2021.
//

import UIKit

class SingleImageViewController: UIViewController {
    
    @IBOutlet weak var singleImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageIdLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var imageData: TestApi!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
        imageIdLabel.text = imageData.description
    }
    
    @IBAction func reloadImage() {
        imageData.getImageData()
        imageIdLabel.text = imageData.description
        fetchImage()
        
    }
    
    private func fetchImage() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let url = URL(string: imageData.imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
                        
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.singleImageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
    
}
