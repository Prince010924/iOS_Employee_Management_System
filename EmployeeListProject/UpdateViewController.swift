//
//  UpdateViewController.swift
//  EmployeeListProject
//
//  Created by DA MAC M1 124 on 2023/05/26.
//

import UIKit

class UpdateViewController: UIViewController {
    
    // MARK: - Properties
    
    var employeeNumber: String = ""
    
    @IBOutlet weak var firstnametextfield: UITextField!
    
    @IBOutlet weak var middleNameTextfiend: UITextField!
    
    
    @IBOutlet weak var surnameTextfield: UITextField!
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var departmentTextfield: UITextField!
    
    
    var empNum: String = ""
        var fName: String = ""
        var mName: String = ""
        var lName: String = ""
        var eMail: String = ""
        var dEpartment: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstnametextfield.text = fName
        middleNameTextfiend.text = mName
        surnameTextfield.text = lName
        emailTextfield.text = eMail
        departmentTextfield.text = dEpartment
        
        // Do any additional setup after loading the view.
    }
    
    
    
}
