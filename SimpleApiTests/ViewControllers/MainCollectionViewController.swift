//
//  MainCollectionViewController.swift
//  SimpleApiTests
//
//  Created by Nechaev Sergey  on 25.09.2021.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {
    
    let userActions = UserActions.allCases
    let singleImage = TestApi.init(apiUrl: ApiLinks.singleImageUrl.rawValue)
    let singleGif = TestApi.init(apiUrl: ApiLinks.singleGifUrl.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleImage.getImageData()
        singleGif.getImageData()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
        
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        return cell
        
    }
        
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .getRandomImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .showAll: performSegue(withIdentifier: "showGif", sender: nil)
        case .showGif: performSegue(withIdentifier: "showGif", sender: nil)
        }
        
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            guard let singleImageVC = segue.destination as? SingleImageViewController else { return }
            singleImageVC.imageData = singleImage
        } else if segue.identifier == "showGif" {
            guard let singleGifVC = segue.destination as? SingleGifViewController else { return }
            singleGifVC.imageData = singleGif
        }
    }

}
