//
//  ListViewController.swift
//  TodoList
//
//  Created by Petrus Souza on 10/08/20.
//  Copyright © 2020 Petrus Souza. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fabButton: CircleButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var isLandscape: Bool = false{
        didSet {
            animateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureCollectionView()
        
        configureNavigationBar()
        fabButton.isHidden = traitCollection.horizontalSizeClass == .regular
        isLandscape = traitCollection.horizontalSizeClass == .regular
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        //para horizontal regular = landscape e compact = portrait
        isLandscape = newCollection.horizontalSizeClass == .regular
        fabButton.isHidden = isLandscape
        configureCollectionView(willTrasition: true)
        tableView.reloadData()
        collectionView.reloadData()
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Add", bundle: nil).instantiateInitialViewController() else{
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: Configuration methods extensions
extension ListViewController{
    private func configureTableView(){
        //configure table view
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ListTableViewCellID")
    }
    
    private func configureCollectionView(willTrasition: Bool = false){
        //configure collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        
        var width = UIScreen.main.bounds.size.width
        var height = UIScreen.main.bounds.size.height
        
        if willTrasition {
            width = UIScreen.main.bounds.size.height
            height = UIScreen.main.bounds.size.width
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ((width - 128) / 3), height: height * 0.7)
        
        collectionView.collectionViewLayout = layout
        
        let nib = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ListCollectionViewCellID")
    }
    
    private func configureNavigationBar(){
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    private func animateViews(){
        UIView.animate(withDuration: 0.3){
            self.tableView.isHidden = self.isLandscape
            self.collectionView.isHidden = !self.isLandscape
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoDataSource.shared.todos.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCellID") as? ListTableViewCell
            else{
                return UITableViewCell()
            }
        
        cell.configure(with: TodoDataSource.shared.todos[indexPath.row])
        return cell
    }
       
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TodoModel.ModelType.allTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCellID",
                                                            for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let type = TodoModel.ModelType.allTypes[indexPath.row]
        let lastsTodos: [TodoModel] = TodoDataSource.shared.getLastsTodoTypeModel(type: type)
        cell.configure(with:type, lastsTodos: lastsTodos)
        return cell
    }
    
    
}
