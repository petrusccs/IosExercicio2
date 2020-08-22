//
//  ListTableViewCell.swift
//  TodoList
//
//  Created by Petrus Souza on 10/08/20.
//  Copyright © 2020 Petrus Souza. All rights reserved.
//

import UIKit

final class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
}

extension ListTableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with model: TodoModel){
        lineView.backgroundColor = model.type.typeColor
        titleLabel.text = model.type.typeDescription
        titleLabel.textColor = model.type.typeColor
        
        todoLabel.text = model.todoDescription
        createdAtLabel.text = formatDate(model.date)
    }
    
    private func formatDate(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        return "at \(formatter.string(from: date))"
    }
}
