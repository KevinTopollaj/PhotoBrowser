//
//  HomeViewController.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

class HomeViewController: UIViewController {
  
  lazy var photoListView: PhotoListView = {
    let photoListView = PhotoListView()
    photoListView.translatesAutoresizingMaskIntoConstraints = false
    photoListView.delegate = self
    return photoListView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupView()
  }
  
  func setupView() {
    view.addSubview(photoListView)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      photoListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      photoListView.topAnchor.constraint(equalTo: view.topAnchor),
      photoListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      photoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

extension HomeViewController: PhotoListViewDelegate {
  func selectedPhoto(sender: PhotoListView, photo: Photo) {
    // launch detail vc here
  }
}

