//
//  ViewController.swift
//  FirstCollectionView
//
//  Created by Larry Mcdowell on 8/7/19.
//  Copyright © 2019 Larry Mcdowell. All rights reserved.
//

import UIKit
struct myData {
    var names:[String]
}

class MyCollectionViewCell: UICollectionViewCell {
    
    var text:String?{
        didSet{
            nameLabel.text = text!
        }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        
    }

        var nameLabel:UILabel =
        {
            var lbl = UILabel()
            lbl.font = UIFont(name: "GillSans", size: 20)
            lbl.layer.cornerRadius = 8
            lbl.layer.borderWidth = 3
            lbl.layer.borderColor = UIColor.black.cgColor
            lbl.textAlignment = .center
            return lbl
        }()
        
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class myCollectionViewController: UICollectionViewController,
UICollectionViewDelegateFlowLayout,UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData!.names.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mine") as! UITableViewCell
        cell.textLabel!.text = viewData!.names[indexPath.row]
        return cell
    }
 

    
    let CELL_ID = "CELL_ID"
    var viewData:myData?
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData!.names.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath) as! MyCollectionViewCell
        cell.backgroundColor = UIColor.green
        cell.text = viewData!.names[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = viewData!.names.remove(at: sourceIndexPath.item)
        viewData!.names.insert(temp, at: destinationIndexPath.item)
    }
   
//   override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let width = CGFloat(300)//collectionView.contentSize.width
//        collectionView.widthAnchor.constraint(equalToConstant: width).isActive = true
//
//        self.view.setNeedsLayout()
//        self.view.layoutIfNeeded()
//
//    }
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        viewData = myData(names:["Thomas","Jerry","George","Mitch","Pam","Susan"])
       let flowLayout = UICollectionViewFlowLayout()
        
//        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout:flowLayout)
//
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 250, height: UIScreen.main.bounds.height - 20), collectionViewLayout: flowLayout)
        cv.backgroundColor = .yellow
        cv.translatesAutoresizingMaskIntoConstraints = false
       
       //self.collectionView = cv
        let myContainer = UIView(frame: CGRect(x: 30, y: 30, width: 380, height: UIScreen.main.bounds.height))
        myContainer.layer.borderWidth = 10
        myContainer.layer.borderColor = UIColor.red.cgColor
        myContainer.backgroundColor = .blue
       // myContainer.translatesAutoresizingMaskIntoConstraints = false

        
        
       // cv.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.widthAnchor.constraint(equalToConstant: CGFloat(integerLiteral: 200))
        collectionView.heightAnchor.constraint(equalToConstant: 500)
     
        
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: CELL_ID)
    //    collectionView.delegate = self
    //    collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.cyan
        collectionView.isUserInteractionEnabled = true
        
                //  let flowLayoutTwo = UICollectionViewFlowLayout()
                //  let secondCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        let mytb = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 200), style: .plain)
        mytb.dataSource = self
        mytb.delegate = self
        mytb.register(UITableViewCell.self, forCellReuseIdentifier: "mine")
        mytb.backgroundColor = .gray
        //mytb.translatesAutoresizingMaskIntoConstraints = false
      
        myContainer.addSubview(cv)
        
        mytb.frame = CGRect(x: 270, y: 60, width: 80, height: 200)
              myContainer.addSubview(mytb)
//        cv.leadingAnchor.constraint(equalTo: myContainer.leadingAnchor, constant: 0).isActive = true
//        cv.topAnchor.constraint(equalTo: myContainer.topAnchor, constant: 0).isActive = true
//        cv.widthAnchor.constraint(equalToConstant: 250)
//        cv.heightAnchor.constraint(equalToConstant: 400)
//          mytb.leadingAnchor.constraint(equalTo: cv.trailingAnchor, constant: 0).isActive = true
//            mytb.widthAnchor.constraint(equalToConstant: 100)
//            mytb.heightAnchor.constraint(equalToConstant: 200)
//        mytb.trailingAnchor.constraint(equalTo: myContainer.trailingAnchor, constant: 0)
        self.view.addSubview(myContainer)
        
    }

}

