//
//  BooksTableViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/26/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var books = [[String:AnyObject]]()
    var selectedBook = [String:AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func downloadBooks(bookTitle: String) {
        
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(bookTitle)"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) {(data, response, error) in
            guard let jsonData = data else {
                print("no data has been downloaded")
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:AnyObject]
                
                let items = json["items"] as! [[String:AnyObject]]
                self.books = items
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("error with ")
            }
            
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as! BookTableViewCell

        // Configure the cell...
        if let volumeInfo = self.books[indexPath.row]["volumeInfo"] as? [String:AnyObject]{
//            cell.textLabel?.text = volumeInfo["title"] as? String
//            cell.detailTextLabel?.text = volumeInfo["subtitle"] as? String
            cell.bookCellView.layer.cornerRadius = cell.bookCellView.frame.height / 2
            cell.bookTitlelbl.text=volumeInfo["title"] as? String
            cell.bookSubtitlelbl.text=volumeInfo["subtitle"] as? String
        }

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        performSegue(withIdentifier: "bookDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? BookDetailViewController{
            
            print([(tableView.indexPathForSelectedRow?.row)!])
            destination.book = books[(tableView.indexPathForSelectedRow?.row)!]
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

extension BooksTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let bookTitle = searchBar.text!.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        self.downloadBooks(bookTitle: bookTitle!)
        searchBar.resignFirstResponder()
    }
}
