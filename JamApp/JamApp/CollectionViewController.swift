//
//  CollectionViewController.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 03/03/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {
    fileprivate let reuseIdentifier = "PhotoCell"
    fileprivate let thumbnailSize:CGFloat = 170.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 10, left: 5.0, bottom: 10.0, right: 5.0)
    fileprivate var photos:[String] = []
    fileprivate var descriptions:[String] = []
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var queue: FMDatabaseQueue?
    override func viewDidLoad() {
        let db = FMDatabase(path: databasePath as String)
        
        queue = FMDatabaseQueue(path: databasePath as String!)
        
        if (db?.open())! {
            
            queue?.inDatabase() {
                db in
                
                if let rs = db?.executeQuery("select * from Jam", withArgumentsIn:nil) {
                    while rs.next() {
                        if (rs.string(forColumn: "image_menu")) != nil{
                            self.photos.append(rs.string(forColumn: "image_menu"))
                            
                        }
                        if (rs.string(forColumn: "Description")) != nil{
                            self.descriptions.append(rs.string(forColumn: "Description"))
                            
                        }
                    }
                } else {
                    print("select failure: \(String(describing: db?.lastErrorMessage()))")
                }
            }
            db?.close()
        } else {
            print("Error: \(String(describing: db?.lastErrorMessage()))")
        }
        
        // burger side bar menu
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView?.indexPath(for: cell), let zoomedPhotoViewController = segue.destination as? ZoomedPhotoViewController {
            zoomedPhotoViewController.photoName = photos[indexPath.row]
            zoomedPhotoViewController.descriptionOfJam = descriptions[indexPath.row]
        }
    }
    
    
}

// MARK: UICollectionViewDataSource
extension CollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        let fullSizedImage = UIImage(named:photos[indexPath.row])
        cell.imageView.image = fullSizedImage?.thumbnailOfSize(thumbnailSize)
        return cell
    }
}

// MARK:UICollectionViewDelegateFlowLayout
extension CollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: thumbnailSize, height: thumbnailSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
