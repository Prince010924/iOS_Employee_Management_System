//
//  AddViewController.swift
//  EmployeeListProject
//
//  Created by DA MAC M1 124 on 2023/05/25.
//

import UIKit

class AddViewController: UIViewController  {
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var middleName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var department: UITextField!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Set the table view's data source
           
       }
    

   
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
       

        addEmployee(firstName: firstName.text!, middleName: middleName.text!, lastName: lastName.text!, email: email.text!, department: department.text!)
        
        showSuccessAlert()
        
        
        
        
        
    }
    
    func addEmployee(firstName: String, middleName: String, lastName: String, email: String, department: String) {
        let urlString = "http://localhost:8080/employee/employees"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Validate first name
            guard !firstName.isEmpty else {
                showAlert(message: "Please enter your first name")
                return
            }
        
        // Validate middle name
        guard !middleName.isEmpty else {
            showAlert(message: "Please enter your middle name")
            
            return
        }
            
            // Validate last name
            guard !lastName.isEmpty else {
                showAlert(message: "Please enter your surname")
                return
            }
            
            // Validate email format
            guard isValidEmail(email) else {
                showAlert(message: "Please enter your email address as it is not in the correct format")
                return
            }
            
            // Validate department
            guard !department.isEmpty else {
                showAlert(message: "Please enter your department")
                return
            }
        
        // Create the user object with the given attributes
        let user = Employee(employeeNumber: Int(0),
                            firstName: firstName,
                            middleName: middleName,
                            surname: lastName,
                            email: email,
                            department: department)
        
       
        
        // Create the HTTP request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the request body as JSON
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode user data: \(error)")
            return
        }
        
        // Set the request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Send the HTTP request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("User registered successfully")
            } else {
                print("Failed to register user. Status code: \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Basic email format validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showSuccessAlert() {
        let alertController = UIAlertController(title: "Success", message: "Employee successfully added", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }

    
   

}
