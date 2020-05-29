//
//  ExpenseViewController.swift
//  SmartBillManager
//
//  Created by Ali Rauf on 22/04/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class ExpenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var totalExpLbl: UILabel!
    @IBOutlet weak var expenseTableView: UITableView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pickerr: UIPickerView!
    
    var expenseRef: DatabaseReference!
    var expensesDup: [Expense] = []
    var expenses: [Expense] = []
    var expenses2d : [[Expense]] = []
    
    var categories = Set<String>()
    var cat: [String] = [String]()
    
    var pickerMonth: String = "All"
    var pickerYear: String = "All"
    
    let monthArr = ["All","January", "February", "March", "April", "May", "June","July","August","September","October","November","December"]
    let yearArr = ["All","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025"]
    var months = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userID = Auth.auth().currentUser?.uid
        expenseRef = Database.database().reference().child("expenses").child(userID!)
        
        self.picker.delegate = self
        self.picker.dataSource = self
        expenseTableView.dataSource = self
        super.tabBarController?.title = "EXPENSES"
        self.title = "EXPENSES"
        
        months = [monthArr,yearArr]
        loadExpenses()
        self.expenseTableView.reloadData()
        self.expenseTableView.allowsSelection = false
        self.expenseTableView.separatorStyle = .none
        expenseTableView?.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
         picker.selectRow(0, inComponent:0, animated:true)
         picker.selectRow(0, inComponent:1, animated:true)
    
         loadExpenses()
         expenseTableView.reloadData()
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        super.tabBarController?.title = "EXPENSES"
        super.navigationController?.title = "EXPENSES"
    }
    
    func calculateTotal(arr: [Expense]){
        var sum: Double = 0
        for i in (0..<arr.count){
            sum+=arr[i].amount
        }
        self.totalExpLbl.text = "\(sum)"
    }

    func loadExpenses(month: String = "All", year: String = "All") {
        expenseRef.observe(.value, with: {  snapshot in
            
        self.expenses = []
        self.expenses2d = []
        self.categories = []
            
        for expense in snapshot.children {
            let snap = expense as! DataSnapshot
            let expenseDict = snap.value as! [String: Any]
            let expenseCategory = expenseDict["expenseCategory"] as! String
            let expenseItem = expenseDict["expenseItem"] as! String
            let expenseAmount = expenseDict["expenseAmount"] as! String
            let expenseDate = expenseDict["expenseDate"] as! String
            let expenseId = snap.key
            let expenseAmountInt = Double(expenseAmount)
            let newExpense = Expense(category: expenseCategory, item: expenseItem, amount: expenseAmountInt!, dateCreated: expenseDate, expenseId: expenseId)
            self.expenses.append(newExpense)
            self.categories.insert(expenseCategory)
        }
            
        if month != "All" && year != "All"{
            self.categories = []
            var temp = [Expense]()
            for i in (0..<self.expenses.count){
                let tempDate = self.expenses[i].dateCreated.components(separatedBy: " ")
                let mon = tempDate[0]
                let yea = tempDate[2]
                if mon == month && yea == year {
                    temp.append(self.expenses[i])
                    self.categories.insert(self.expenses[i].category)
                }
            }
            self.expenses = []
            self.expenses = temp
            self.expenses2d = []
        }
        else if month != "All" && year == "All"{
            self.categories = []
            var temp = [Expense]()
            for i in (0..<self.expenses.count){
                let tempDate = self.expenses[i].dateCreated.components(separatedBy: " ")
                let mon = tempDate[0]
                if mon == month  {
                    temp.append(self.expenses[i])
                    self.categories.insert(self.expenses[i].category)
                }
            }
            self.expenses = []
            self.expenses = temp
            self.expenses2d = []
        }
        else if month == "All" && year != "All"{
            self.categories = []
            var temp = [Expense]()
            for i in (0..<self.expenses.count){
                let tempDate = self.expenses[i].dateCreated.components(separatedBy: " ")
                let yea = tempDate[2]
                if yea == year  {
                    temp.append(self.expenses[i])
                    self.categories.insert(self.expenses[i].category)
                }
            }
            self.expenses = []
            self.expenses = temp
            self.expenses2d = []
        }
            
        self.cat = [String](self.categories)
        var catItems = [Expense]()
        for i in (0..<self.categories.count){
            for j in (0..<self.expenses.count){
                if self.expenses[j].category == self.cat[i]{
                    catItems.append(self.expenses[j])
                }
            }
            self.expenses2d.append(catItems)
            catItems = []
        }
        self.calculateTotal(arr: self.expenses)
            
        DispatchQueue.main.async { //Fetch main thread to update data
            self.expenseTableView.reloadData()
        }
        })
    }
    
    //MARK: - Picker View Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return months[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return months[component][row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let m = pickerView.selectedRow(inComponent: 0)
        let y = pickerView.selectedRow(inComponent: 1)
        let month = monthArr[m]
        let year = yearArr[y]
        self.pickerMonth = month
        self.pickerYear = year
        loadExpenses(month: month,year: year)
        print("ExpensesDup: \(expensesDup)")
        expenseTableView.reloadData()
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "expDetails" {
            let destinationVC = segue.destination as! AddExpenseViewController
            destinationVC.callbackResult = { result in
    
                self.expenses = []
                self.categories = []
                self.cat = []
                self.loadExpenses()
                print("callbackresult")
                self.expenseTableView.reloadData()
            }
        }
    }
}

extension ExpenseViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - ExpenseTableView source Methods
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses2d[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expenseTableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ExpenseTableViewCell
        cell.lblItem?.text = "\(expenses2d[indexPath.section][indexPath.row].item)"
        cell.lblAmount?.text = "Amount: \(String(expenses2d[indexPath.section][indexPath.row].amount))"
        cell.lblDate?.text = "Date: \(expenses2d[indexPath.section][indexPath.row].dateCreated)"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = expenses2d[indexPath.section][indexPath.row].expenseId
            let ref = expenseRef.child(id)
            ref.removeValue { error, _ in
                print(error ?? "")
            }
            print("delete cell expenses at start: \(expenses2d)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        categories.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < categories.count {
            return cat[section]
        }
        return nil
    }
}

