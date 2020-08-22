//
//  ListCollectionViewCell.swift
//  TodoList
//
//  Created by Petrus Souza on 21/08/20.
//  Copyright © 2020 Petrus Souza. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet var labels: Array<UILabel>!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(with modelType: TodoModel.ModelType, lastsTodos: [TodoModel]){
       contentView.backgroundColor = modelType.typeColor
       contentView.layer.cornerRadius = frame.size.height / 10
       typeTitle.text = modelType.typeDescription
       var indice = 0
       for label in labels{
          label.text = ""
       }
        
       for todo in lastsTodos{
         labels[indice].text = todo.todoDescription
         indice = indice + 1
       }
    }

}
