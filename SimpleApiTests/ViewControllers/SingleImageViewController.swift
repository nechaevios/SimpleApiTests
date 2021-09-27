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
    
    var imageData: DataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        imageIdLabel.text = imageData.description
        
        fetchImage(
            fromData: imageData,
            forImageView: singleImageView,
            andIndicator: activityIndicator
        )
        
    }
    
    @IBAction func reloadImage() {
        imageData.getImageData()
        
        imageIdLabel.text = imageData.description

        fetchImage(
            fromData: imageData,
            forImageView: singleImageView,
            andIndicator: activityIndicator
        )

    }
    
}

extension SingleImageViewController {
    func fetchImage(fromData: DataManager, forImageView: UIImageView, andIndicator: UIActivityIndicatorView) {
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
}
