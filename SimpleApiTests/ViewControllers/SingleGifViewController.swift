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
    
    var imageData: DataManager!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        gifIdLabel.text = imageData.imageListData.first?.description
        
        gifWebView.uiDelegate = self
        self.view.addSubview(gifWebView)
        
        fetchGif(
            fromData: imageData,
            forWebView: gifWebView,
            andIndicator: activityIndicator
        )
        
    }

    @IBAction func reloadGif() {
        imageData.fetchApiData()
        
        gifIdLabel.text = imageData.imageListData.first?.description
        
        fetchGif(
            fromData: imageData,
            forWebView: gifWebView,
            andIndicator: activityIndicator
        )
        
    }
    
}

extension SingleGifViewController {
    func fetchGif(fromData: DataManager, forWebView: WKWebView, andIndicator: UIActivityIndicatorView) {
        
        andIndicator.isHidden = false
        andIndicator.startAnimating()
        
        guard let gifImageUrl = URL(string: fromData.imageListData.first?.url ?? "") else { return }
        let urlRequest = URLRequest(url: gifImageUrl)
        
        forWebView.load(urlRequest)
        
    }
}

