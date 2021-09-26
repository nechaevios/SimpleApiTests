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
        
        imageIdLabel.text = imageData.description
        
        imageData.fetchImage(
            fromData: imageData,
            forImageView: singleImageView,
            andIndicator: activityIndicator
        )
        
    }
    
    @IBAction func reloadImage() {
        imageData.getImageData()
        
        imageIdLabel.text = imageData.description

        imageData.fetchImage(
            fromData: imageData,
            forImageView: singleImageView,
            andIndicator: activityIndicator
        )

    }
    
}
