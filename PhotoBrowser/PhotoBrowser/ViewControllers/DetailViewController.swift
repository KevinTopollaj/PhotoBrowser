//
//  DetailViewController.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

class DetailViewController: UIViewController {
  
  var photo: Photo?
  
  private lazy var mainPhotoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private lazy var closeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("X", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(didTapCloseButton(sender:)), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setupView()
    displayImage()
  }
  
  func setupView() {
    view.addSubview(mainPhotoImageView)
    view.addSubview(closeButton)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
      closeButton.widthAnchor.constraint(equalToConstant: 40),
      closeButton.heightAnchor.constraint(equalToConstant: 40),
      
      mainPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mainPhotoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mainPhotoImageView.topAnchor.constraint(equalTo: view.topAnchor),
      mainPhotoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  func displayImage() {
    guard let portraitImageURLString = photo?.src.portrait else { return }
    
    if let url = URL(string: portraitImageURLString) {
      _ = ImageLoader().loadImage(url: url) { [weak self] (result) in
        guard let self = self else { return }
        
        switch result {
        case .success(let image):
          DispatchQueue.main.async {
            self.mainPhotoImageView.image = image
          }
        case .failure(let error):
          print(error)
        }
      }
    }
  }
  
  @objc func didTapCloseButton(sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
