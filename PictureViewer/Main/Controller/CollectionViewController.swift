//
//  CollectionViewController.swift
//  PictureViewer
//
//  Created by Лера Тарасенко on 09.02.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFetcher()
    
    private var pictures = [Picture]()
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Picture Viewer"
        
        setupCollectionView()
        
        networkDataFetcher.getchImages {(results) in
            guard let fetchedPhotos = results else { return }
            self.pictures = fetchedPhotos
            self.collectionView.reloadData()
        }
        
        first()
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "collectionWasDownload")
  
    }
    
    private func first() {
        let userDefaults = UserDefaults.standard
        let collectionWasDownload = userDefaults.bool(forKey: "collectionWasDownload")
        
        if !collectionWasDownload {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy H:mm:ss"
            
            formatter.locale = Locale(identifier: "ru_RU")
            let dateString = formatter.string(from: Date())

            UserSetting.dateDownload = dateString
        }
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        
        let unsplashPicture = pictures[indexPath.item]
        cell.unsplashPicture = unsplashPicture
        cell.resolution.text = String(unsplashPicture.width) + "x" + String(unsplashPicture.height)
        cell.userName.text = unsplashPicture.user.name
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        guard let image = cell.picture.image else { return }
        
        let vc = DetailViewController(picture: image)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let picture = pictures[indexPath.item]
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(picture.height) * widthPerItem / CGFloat(picture.width)
        
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
