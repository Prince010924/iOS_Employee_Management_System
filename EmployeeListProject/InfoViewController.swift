//
//  InfoViewController.swift
//  EmployeeListProject
//
//  Created by DA MAC M1 124 on 2023/05/25.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    @IBOutlet weak var employeeNumber: UILabel!
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var middleName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var department: UILabel!
    
    var fName: String?
    var mName: String?
    var lName: String?
    var eMail: String?
    var dEpartment: String?
    var empNum: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.text = fName
        middleName.text = mName
        lastName.text = lName
        email.text = eMail
        department.text = dEpartment
        employeeNumber.text = empNum

        // Do any additional setup after loading the view.
    }
    

    

}
