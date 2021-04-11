//
//  PhotoListView.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import UIKit

// MARK: - PhotoListViewDelegate -
protocol PhotoListViewDelegate: class {
  func selectedPhoto(sender: PhotoListView, photo: Photo)
}

class PhotoListView: UIView {
  weak var delegate: PhotoListViewDelegate?
  
  lazy var viewModel: PhotoListViewModel = {
    let viewModel = PhotoListViewModel()
    viewModel.delegate = self
    return viewModel
  }()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.reuseIdentifier)
    return tableView
  }()
  
  // MARK: - Initializers -
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup View and Constraints -
  func setupView() {
    addSubview(tableView)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
    ])
  }
}

// MARK: - PhotoListViewModelDelegate -
extension PhotoListView: PhotoListViewModelDelegate {
  func photosLoaded(sender: PhotoListViewModel) {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

// MARK: - UITableViewDataSource -
extension PhotoListView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
    let photo = viewModel.getPhoto(at: indexPath)
    cell.photographerLabel.text = photo.photographer
    cell.photographerTagLabel.text = photo.photographer_tag
    return cell
  }
}

// MARK: - UITableViewDelegate -
extension PhotoListView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    200
  }
}
