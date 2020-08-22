//
//  AddViewController.swift
//  TodoList
//
//  Created by Petrus Souza on 13/08/20.
//  Copyright © 2020 Petrus Souza. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var backButton: CircleButton!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: CircleButton!
    
    private var selectedType: TodoModel.ModelType = .onPriority{
        didSet{
            configureColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureColor(animated: false)
        configureTextField()
        configureButtons()
        configureTypePicker()
    }
}

//MARK: Configuration methods extension
extension AddViewController{
    private func configureTextField(){
        todoTextField.borderStyle = .none
    }
    
    private func configureButtons(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .primaryActionTriggered)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .primaryActionTriggered)
    }
    
    private func configureTypePicker(){
        typePicker.delegate = self
        typePicker.dataSource = self
    }
    private func configureColor(animated: Bool = true){
        if animated {
            UIView.animate(withDuration: 0.3){
                self.backButton.backgroundColor = self.selectedType.typeColor
                self.sideView.backgroundColor = self.selectedType.typeColor
                self.saveButton.backgroundColor = self.selectedType.typeColor
            }
        }else{
            backButton.backgroundColor = self.selectedType.typeColor
            sideView.backgroundColor = self.selectedType.typeColor
            saveButton.backgroundColor = self.selectedType.typeColor
        }
    }
}
//MARK: Action methods extension
extension AddViewController{
    
    @objc
    private func backButtonPressed(){
        navigationController?.popViewController(animated: true)
    }
    @objc
    private func saveButtonPressed(){
        guard let text = todoTextField.text else{
            return
        }
        let model = TodoModel.init(type: selectedType, todoDescription: text, date: datePicker.date)
        TodoDataSource.shared.todos.append(model)
        navigationController?.popViewController(animated: true)
    }
}
//MARK: UIPickerView delegate and datasource methods extension
extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TodoModel.ModelType.allTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TodoModel.ModelType.allTypes[row].typeDescription
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = TodoModel.ModelType.allTypes[row]
    }
}
