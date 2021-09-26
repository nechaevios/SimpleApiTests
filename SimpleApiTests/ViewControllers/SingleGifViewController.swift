//
//  SingleGifViewController.swift
//  SimpleApiTests
//
//  Created by Nechaev Sergey  on 26.09.2021.
//

import UIKit
import WebKit

class SingleGifViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var gifIdLabel: UILabel!
    @IBOutlet weak var moreButtonLabel: UIButton!
    
    @IBOutlet weak var gifWebView: WKWebView!
    
    var imageData: TestApi!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        gifIdLabel.text = imageData.description
        
        gifWebView.uiDelegate = self
        self.view.addSubview(gifWebView)
        
        imageData.fetchGif(
            fromData: imageData,
            forWebView: gifWebView,
            andIndicator: activityIndicator
        )
        
    }

    @IBAction func reloadGif() {
        imageData.getImageData()
        
        gifIdLabel.text = imageData.description
        
        imageData.fetchGif(
            fromData: imageData,
            forWebView: gifWebView,
            andIndicator: activityIndicator
        )
        
    }
    
}
