//
//  PhotosDetailsViewController.swift
//  Koinz Assignment
//
//  Created by Ahmed Abd Elaziz on 22/05/2022.
//

import UIKit

class PhotosDetailsViewController: UIViewController {

    var farm: Int?
    var server: String?
    var id: String?
    var secret: String?
    
    init(farm: Int, server: String, id: String, secret: String) {
        self.farm = farm
        self.server = server
        self.id = id
        self.secret = secret
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    private lazy var photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFit
        if let farm = farm, let server = server, let id = id, let secret = secret {
            var url = URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
            photo.kf.setImage(with: url)
        }
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
    
    private func setupPhotoImageViewConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func addSubviews() {
        view.addSubview(photoImageView)
    }
    
    private func addConstraints() {
        setupPhotoImageViewConstraints()
    }
    
    private func viewSetup() {
        self.title = "Photos"
        view.backgroundColor = .white
    }
    
    private func layoutUI() {
        viewSetup()
        addSubviews()
        addConstraints()
    }
}
