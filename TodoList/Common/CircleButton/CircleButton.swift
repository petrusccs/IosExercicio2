//
//  CircleButton.swift
//  TodoList
//
//  Created by Petrus Souza on 12/08/20.
//  Copyright © 2020 Petrus Souza. All rights reserved.
//

import UIKit

final class CircleButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.height / 2
    }

}
