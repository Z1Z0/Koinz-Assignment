//
//  PhotosTableViewController.swift
//  Koinz Assignment
//
//  Created by Ahmed Abd Elaziz on 22/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver

class PhotosTableViewController: UIViewController {

    let disposeBag = DisposeBag()
    @Injected var viewModel: PhotosTableViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutUI()
        bindPhotos()
        selectedCell()
    }
    
    private lazy var photosTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func setupPhotoTableViewConstraints() {
        NSLayoutConstraint.activate([
            photosTableView.topAnchor.constraint(equalTo: view.topAnchor),
            photosTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photosTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            photosTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func addSubviews() {
        view.addSubview(photosTableView)
    }
    
    private func addConstraints() {
        setupPhotoTableViewConstraints()
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
    
    private func bindPhotos() {
        let viewDidLoad = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        let input = PhotosTableViewModel.Input(viewDidLoadTrigger: Driver.merge(viewDidLoad))

        let output = viewModel.transform(input: input)
        
        output.photos.bind(to: photosTableView.rx.items(cellIdentifier: "PhotosTableViewCell", cellType: PhotosTableViewCell.self)) {
            index, model, cell in
            
            cell.bind(model)
        }
        .disposed(by: disposeBag)
    }
    
    private func selectedCell() {
        photosTableView.rx
            .modelSelected(Photo.self)
            .subscribe { [weak self] photos in
                guard let self = self else {return}
                photos.map { photo in
                    if let farm = photo.farm, let server = photo.server, let id = photo.id, let secret = photo.secret {
                        self.show(PhotosDetailsViewController(farm: farm, server: server, id: id, secret: secret), sender: nil)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}

extension PhotosTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 3
    }
}
