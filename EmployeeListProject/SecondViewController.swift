//
//  SecondViewController.swift
//  EmployeeListProject
//
//  Created by DA MAC M1 124 on 2023/05/24.
//

import UIKit

class SecondViewController: UIViewController {
    var arr = [Employee]()
    var searchingArray = [Employee]()
    var searching = false
    

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchingArray = arr
        
        fetchApiData(URL: "http://localhost:8080/employee"){ result in
            //self.data = result
            self.arr = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        // Do any additional setup after loading the view.
    }
        
        tableView.refreshControl = UIRefreshControl()
                tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
            
    


}
    
    
    @objc func callPullToRefresh(){
        self.fetchApiData(URL: "http://localhost:8080/employee/employees"){ result in
            self.arr = result
            self.searchingArray = result
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }

func fetchApiData(URL url: String, completion: @escaping([Employee]) -> Void){
    
    let url = URL(string: url)
    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: url!) {  data, response, error in
        if data != nil && error == nil {
            do {
                let parsingData = try JSONDecoder().decode([Employee].self , from: data!)
                completion(parsingData)
                
            } catch {
                print("parsing error")
            }
            
        }
    }
        dataTask.resume()
    }
}

extension SecondViewController: UITableViewDataSource , UITableViewDelegate , UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchingArray.count
        } else {
            return arr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        let employee: Employee
               if searching {
                   employee = searchingArray[indexPath.row]
               } else {
                   employee = arr[indexPath.row]
               }
        cell.firstName.text = employee.firstName
        cell.empNumber.text = "\(employee.employeeNumber)"
        cell.lastName.text = employee.surname
               return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        tableView.beginUpdates()
//        arr.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .fade)
//        tableView.endUpdates()
        
//        if editingStyle == .delete {
//              let employeeNumberToDelete = arr[indexPath.row].employeeNumber
//              deleteEmployee(employeeNumber: employeeNumberToDelete)
//
//              tableView.beginUpdates()
//              arr.remove(at: indexPath.row)
//              tableView.deleteRows(at: [indexPath], with: .fade)
//              tableView.endUpdates()
//          }
        
        
        if editingStyle == .delete {
               let employeeToDelete = arr[indexPath.row]
               
               let alert = UIAlertController(title: "Delete Employee", message: "Are you sure you want to delete this employee?", preferredStyle: .alert)
               
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               
               let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                   self.deleteEmployee(employee: employeeToDelete, at: indexPath)
               }
               
               alert.addAction(cancelAction)
               alert.addAction(deleteAction)
               
               present(alert, animated: true, completion: nil)
           }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingArray = arr.filter({$0.firstName.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.surname.lowercased().prefix(searchText.count) == searchText.lowercased() })
        searching = true
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController
        
        vc?.empNum = "\(arr[indexPath.row].employeeNumber)"
        vc?.fName = arr[indexPath.row].firstName
        vc?.mName = arr[indexPath.row].middleName
        vc?.lName = arr[indexPath.row].surname
        vc?.eMail = arr[indexPath.row].email
        vc?.dEpartment = arr[indexPath.row].department
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
        let vcc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as? InfoViewController
        
        vcc?.empNum = "\(arr[indexPath.row].employeeNumber)"
        vcc?.fName = arr[indexPath.row].firstName
        vcc?.mName = arr[indexPath.row].middleName
        vcc?.lName = arr[indexPath.row].surname
        vcc?.eMail = arr[indexPath.row].email
        vcc?.dEpartment = arr[indexPath.row].department
        
    
        
    }
    
    
   
    
    
    
    func deleteEmployee(employee: Employee, at indexPath: IndexPath) {
        let employeeNumberToDelete = employee.employeeNumber
        let urlString = "http://localhost:8080/employee/\(employeeNumberToDelete)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                // Employee deleted successfully
                print("Employee deleted successfully")
                
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.arr.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tableView.endUpdates()
                }
            } else {
                print("Failed to delete employee. Status code: \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
    }
}
