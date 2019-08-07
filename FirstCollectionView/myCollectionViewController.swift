//
//  ViewController.swift
//  FirstCollectionView
//
//  Created by Larry Mcdowell on 8/7/19.
//  Copyright © 2019 Larry Mcdowell. All rights reserved.
//

import UIKit
///////

class myCell: UICollectionViewCell {
    
    var text:String? { didSet{
        myLabel.text = text
        
        }}
     var myLabel: UILabel = {
       let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.backgroundColor = .clear
        lb.layer.cornerRadius = 5
       
        return lb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//////////
struct myData {
    var names:[String]
}


class childData {
    var children:[String]
   // childData(children: ["hello","good-bye","later","minutes","adios"])
    init(children:[String]){
        self.children = children
    }
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

    var cv:UICollectionView?

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData!.names.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mine") as! UITableViewCell
        cell.textLabel!.text = viewData!.names[indexPath.row]
        return cell
    }
 
/////////////////////////////
    private let reuseIdentifier = "SecondCell"
    let CELL_ID = "CELL_ID"
    var viewData:myData?
    var data:childData?
    
    //    var data:[String] = ["hello","good-bye","later","minutes","adios"]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
        return viewData!.names.count
        } else {
            return data!.children.count
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath) as! MyCollectionViewCell
            cell.backgroundColor = UIColor.green
            cell.text = viewData!.names[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! myCell
            
            // Configure the cell
            cell.text = data!.children[indexPath.row]
            
            if indexPath.row == lastPath.row {
           
                cell.backgroundColor = UIColor.red // Selected
            }else {
                cell.backgroundColor = .orange
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
        return CGSize(width: 100, height: 100)
        } else {
            return CGSize(width:80,height:80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if collectionView == self.collectionView {
        let temp = viewData!.names.remove(at: sourceIndexPath.item)
        viewData!.names.insert(temp, at: destinationIndexPath.item)
        } else {
            print("improtve")
            let temp = data!.children.remove(at: sourceIndexPath.item)
        data!.children.insert(temp, at: destinationIndexPath.item)
        }
    }
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        viewData = myData(names:["Thomas","Jerry","George","Mitch","Pam","Susan"])
        data = childData(children: ["hello","good-bye","later","minutes","adios"])
       let flowLayout = UICollectionViewFlowLayout()
        
//        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout:flowLayout)
//
        cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 250, height: UIScreen.main.bounds.height - 20), collectionViewLayout: flowLayout)
        cv!.backgroundColor = .yellow
        let childCVController = ChildCollectionViewController()
//        cv.delegate = childCVController
//        cv.dataSource = childCVController
        cv!.delegate = self
        cv!.dataSource = self
        cv!.register(myCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        cv!.isUserInteractionEnabled = true
      //  childCVController.viewDidLoad()
       
       //self.collectionView = cv
        let myContainer = UIView(frame: CGRect(x: 30, y: 30, width: 380, height: UIScreen.main.bounds.height))
        myContainer.layer.borderWidth = 10
        myContainer.layer.borderColor = UIColor.red.cgColor
        myContainer.backgroundColor = .blue
       // myContainer.translatesAutoresizingMaskIntoConstraints = false

        let viewTapGestureRec = UITapGestureRecognizer(target:self,action:#selector(handleViewTap(_:)))
        viewTapGestureRec.cancelsTouchesInView = false
        
     
        
        
        cv!.addGestureRecognizer(viewTapGestureRec)
       // cv.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
       // collectionView.widthAnchor.constraint(equalToConstant: CGFloat(integerLiteral: 200))
        //collectionView.heightAnchor.constraint(equalToConstant: 500)
     
        
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
       
      
        myContainer.addSubview(cv!)
        
       // mytb.frame = CGRect(x: 270, y: 60, width: 80, height: 200)
              myContainer.addSubview(mytb)
         self.view.addSubview(myContainer)
            cv!.translatesAutoresizingMaskIntoConstraints = false
        cv!.leadingAnchor.constraint(equalTo: myContainer.leadingAnchor, constant: 20).isActive = true
        cv!.topAnchor.constraint(equalTo: myContainer.topAnchor, constant: 0).isActive = true
        cv!.widthAnchor.constraint(equalToConstant: 150).isActive = true
        cv!.heightAnchor.constraint(equalToConstant: 400).isActive = true
     
            mytb.translatesAutoresizingMaskIntoConstraints = false
            mytb.topAnchor.constraint(equalTo:myContainer.topAnchor, constant: 40).isActive = true
            mytb.leadingAnchor.constraint(equalTo: cv!.trailingAnchor, constant: 20).isActive = true
            mytb.widthAnchor.constraint(equalToConstant: 80).isActive = true
            mytb.heightAnchor.constraint(equalToConstant: 200).isActive = true
        

        
    }
    @objc func handleViewTap(_ recognizer: UIGestureRecognizer){
        collectionView.resignFirstResponder()
        print("inactivated bottom collection view")
    }
    
    var lastPath:IndexPath = IndexPath(item: 0, section: 0)
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != self.collectionView{
           // var cell = cv!.cellForItem(at: indexPath)!
           // cell.backgroundColor = .blue
            print("Selected")
            print("improtve")
//            if let lastPath = lastPath {
            let temp = data!.children.remove(at: lastPath.item)
            data!.children.insert(temp, at: indexPath.item)
            
            //swap instead of remove and insert since you're clicking
//            let last = data!.children[lastPath.item]
//            let curr = data!.children[indexPath.item]
//            data!.children[indexPath.item] = last
//            data!.children[lastPath.item] = curr
            lastPath = indexPath
            cv!.reloadData()
        }
    }
}

