//
//  PhotosTableViewCell.swift
//  Koinz Assignment
//
//  Created by Ahmed Abd Elaziz on 22/05/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Kingfisher

class PhotosTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private var photoView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func setupPhotoViewConstraints() {
        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            photoView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3),
            photoView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 3) - 16),
            photoView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private var photoTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = .avenirMedium()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private func setupPhotoTitleConstraints() {
        NSLayoutConstraint.activate([
            photoTitle.topAnchor.constraint(equalTo: photoView.topAnchor),
            photoTitle.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16),
            photoTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(photoView)
        containerView.addSubview(photoTitle)
    }
    
    private func addConstraints() {
        setupContainerViewConstraints()
        setupPhotoViewConstraints()
        setupPhotoTitleConstraints()
    }
    
    private func customCellLayout() {
        selectionStyle = .none
    }
    
    private func layoutUI() {
        customCellLayout()
        addSubviews()
        addConstraints()
    }
    
    func bind(_ viewModel: Photo) {
        photoTitle.text = viewModel.title
        guard let farm = viewModel.farm else {return}
        guard let server = viewModel.server else {return}
        guard let id = viewModel.id else {return}
        guard let secret = viewModel.secret else {return}
        let url = URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
        photoView.kf.setImage(with: url)
    }
    
}
