//
//  ViewController.swift
//  PartOne
//
//  Created by Mauricio Vazquez on 9/28/17.
//  Copyright © 2017 Mauricio Vazquez. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  var imagesUrl = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.loadImages()
  }
  
  func loadImages() {
    API.sharedInstance.loadImages( completionClosure: { [weak self] success, jsonResponse in
      if let response = jsonResponse {
        self?.imagesUrl = response
        self?.collectionView.reloadData()
      }
    })
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
    let url = URL(string: imagesUrl[indexPath.row])
    cell.coverImageView.kf.setImage(with: url)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.imagesUrl.count
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    return CGSize(width:self.view.frame.width * 0.4, height: self.view.frame.width * 0.3)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: self.view.frame.width * 0.05, left: self.view.frame.width * 0.05, bottom: 0, right: self.view.frame.width * 0.05)
  }
}

