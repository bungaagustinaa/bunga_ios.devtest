//
//  EmployeeListTableViewCell.swift
//  CRUD_TEST
//
//  Created by Bunga Agustina on 10/05/23.
//

import UIKit

class EmployeeListTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        editButton.layer.cornerRadius = 6
        deleteButton.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func editAct(_ sender: Any) {
        
    }
    
    @IBAction func deleteAct(_ sender: Any) {
        
    }
    
    func configureCell(employee: DataList) {
        idLabel.text = "ID: \(employee.id )"
        nameLabel.text = "Name: \(employee.employee_name )"
        salaryLabel.text = "Salary: \(employee.employee_salary )"
        ageLabel.text = "Age: \(employee.employee_age )"
    }
}
