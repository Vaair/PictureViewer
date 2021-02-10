//
//  CollectionViewCell.swift
//  PictureViewer
//
//  Created by Лера Тарасенко on 09.02.2021.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CollectionViewCell"
    
    var unsplashPicture: Picture! {
        didSet{
            let phoroURL = unsplashPicture.urls["regular"]
            guard let imageURL = phoroURL, let url = URL(string: imageURL) else { return }
            picture.sd_setImage(with: url, completed: nil)
        }
    }
    
    let userName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.alpha = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let picture: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let resolution: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.alpha = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        picture.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(picture)
        picture.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        picture.topAnchor.constraint(equalTo: topAnchor).isActive = true
        picture.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        picture.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(userName)
        userName.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        userName.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        userName.topAnchor.constraint(equalTo: picture.topAnchor).isActive = true
        
        addSubview(resolution)
        resolution.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        resolution.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        resolution.bottomAnchor.constraint(equalTo: picture.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
