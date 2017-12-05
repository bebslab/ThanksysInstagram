//
//  SearchCollectionViewController.swift
//  InstagramThanksys
//
//  Created by Hubert LABORDE on 30/11/2017.
//  Copyright © 2017 Hubert LABORDE. All rights reserved.
//

import UIKit
private let reuseIdentifier = "CellInstagram"

class SearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pictures = [Item]()
    var itemSection1 = [Item]()
    var itemSection2 = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        self.collectionView?.register(UINib(nibName: "CellView", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func fetchItems() {
        Network.sharedInstance.getPictures(success: { (items) in
            self.pictures = items
            self.sortItems()
            DispatchQueue.main.async( execute: {
                self.collectionView?.reloadData()
            })
        }) { (raison, error) in
            print("Error to download pictures!!!")
        }
    }
    
    func sortItems() {
        for _ in pictures {
            let _ =  pictures.sorted(by: { $0.date?.compare($1.date!) == ComparisonResult.orderedAscending })
        }
        let totalItemPerSection = (pictures.count - 1)/2
        for i in 0 ... totalItemPerSection - 1{
            itemSection1.append(pictures[i])
        }
        for i in totalItemPerSection ... pictures.count - 1{
            itemSection2.append(pictures[i])
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return itemSection1.count
        }
        return itemSection2.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CellView
        if (indexPath.section == 0) {
            cell.thumbnail.loadImageUsingCache(withUrl: itemSection1[indexPath.row].url!)
        } else {
            cell.thumbnail.loadImageUsingCache(withUrl: itemSection2[indexPath.row].url!)
        }
        cell.thumbnail.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        cell.thumbnail.contentMode = .scaleToFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width)/3.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth - 1, height: yourHeight - 1)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: (self.collectionView?.bounds.width)!, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var titleSection = ""
        var numberItems = ""
        if(indexPath.section == 0){
            titleSection = "meilleures publications".uppercased()
        } else {
            titleSection = "plus récentes".uppercased()
            numberItems = "83 956 publications"
        }
        guard let sectionHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader else {
            return UICollectionReusableView()
        }
        setSection(cell: sectionHeaderCell)
        sectionHeaderCell.sectionHeaderlabel.text = titleSection
        sectionHeaderCell.totalItems.text = numberItems
        return sectionHeaderCell
    }
    
    func setSection(cell: SectionHeader){
        cell.sectionHeaderlabel.textColor = .lightGray
        cell.sectionHeaderlabel.font = .boldSystemFont(ofSize: 12)
        cell.totalItems.textColor = .lightGray
        cell.totalItems.font = .boldSystemFont(ofSize: 12)
        cell.totalItems.textAlignment = .right
        
    }
    
}
