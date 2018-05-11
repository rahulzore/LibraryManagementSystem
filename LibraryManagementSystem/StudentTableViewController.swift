//
//  StudentTableViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/28/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class StudentTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var username:String?
    var tempBI = [BookIssued]()
    var filteredIssue = [BookIssued]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let fetchRequest: NSFetchRequest<BookIssued> = BookIssued.fetchRequest()
        do{
            SingletonController.bookIssuedArray = try PersistenceService.context.fetch(fetchRequest)
        } catch{

        }
        
        for bi in SingletonController.bookIssuedArray{
            if bi.student?.name == username{
                tempBI.append(bi)
            }
        }
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Books Issued"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        for b in tempBI{
            print(b.book?.title)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredIssue = SingletonController.bookIssuedArray.filter({( bookIssue : BookIssued) -> Bool in
            return (bookIssue.book?.title?.lowercased().contains(searchText.lowercased()))!
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(isFiltering()){
            return filteredIssue.count
        } else {
        return tempBI.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as! StudentBookTableViewCell
        
        let bi : BookIssued
        if(isFiltering()){
            bi = filteredIssue[indexPath.row]
        } else {
            bi = tempBI[indexPath.row]
        }
        cell.layer.cornerRadius = cell.layer.frame.height / 2
        cell.bookLabel.text = bi.book?.title
        if bi.returned == false{
            cell.pendinglabel.text = "Return Pending"
        } else {
            cell.pendinglabel.text = "Returned"
        }
        cell.layer.cornerRadius = cell.frame.height / 2

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "tempStudentSegue2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StudentBookIssueDetailsViewController {
            if(isFiltering()){
                destination.bookIssued = filteredIssue[(tableView.indexPathForSelectedRow?.row)!]
            } else {
            destination.bookIssued = tempBI[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StudentTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
