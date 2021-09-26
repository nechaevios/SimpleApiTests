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
    
    var singleImageLoader = TestApi.init(apiUrl: ApiLinks.singleImageUrl.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        singleImageLoader.getImageData()
        print(singleImageLoader.imageUrl)
        
        singleImageLoader.fetchImage()
        singleImageView.image = singleImageLoader.loadedImage
        activityIndicator.stopAnimating()
    
    }
 

}
