//
//  ViewController.swift
//  PictureViewer
//
//  Created by Лера Тарасенко on 09.02.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    let picture: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(picture: UIImage) {
        super.init(nibName: nil, bundle: nil)
        
        self.picture.image = picture
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(picture)
        picture.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        picture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        picture.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        picture.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        date.text = "Дата скачивания: " + UserSetting.dateDownload
        view.addSubview(date)
        date.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        date.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        date.bottomAnchor.constraint(equalTo: picture.bottomAnchor, constant: -10).isActive = true
        
    }
    
}
