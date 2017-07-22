//
//  ViewController.swift
//  MLJournal
//
//  Created by Waseef Akhtar on 7/21/17.
//  Copyright © 2017 Waseef Akhtar. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewModel = [TableViewModel]()
    var items = [TableViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeFirebase()
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Journal"
    }
    
    
    func initializeFirebase() {
        ref = Database.database().reference()

    }

    func loadData() {
        // To avoid duplication of data when the table updates or refreshes.
        self.tableViewModel.removeAll(keepingCapacity: false)
        self.items = []
        //print("Table View Model Cleared: \(self.tableViewModel)")
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ref.child("journals").observe(.childAdded, with: { snapshot in
            
            guard let snapshotValue = snapshot.value as? [String: Any] else {
                print("no array of dictionary.")
                return
            }
            
            print("SnapshotValue: \(snapshotValue)")
            
            let item = TableViewModel(json: snapshotValue)
            self.items.append(item)
            
            // Display as descending order.
            //self.tableViewModel = self.items.reversed() as [TableViewModel]
            self.tableViewModel = self.items as [TableViewModel]

            
            // Upon first load, don't reload the tableView until all children are loaded.
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        })
    
        // The .Value event fires after .ChildAdded events to reload the tableView the first time and to set subsequent .ChildAdded events to load after each child is added in the future.
        ref.child("journals").observeSingleEvent(of: .value, with: { snapshot in
            //print("Displaying .Value event: \(self.tableViewModel)")
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
        
    }
    
}

// MARK: UITableView DataSource

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) 
        
        self.tableViewPopulation(cell, indexPath: indexPath, cellIdentifier: cellIdentifier)
        
        return cell

    }
    
    func tableViewPopulation(_ cell: UITableViewCell, indexPath: IndexPath, cellIdentifier: String) {
        
        //Populate Table View
        cell.textLabel?.text = tableViewModel[indexPath.row].title
        cell.detailTextLabel?.text = tableViewModel[indexPath.row].subtitle
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let selectedCell = tableViewModel[indexPath.row]
            willMoveToDetailView(selectedCell)

    }
    
    func willMoveToDetailView(_ selectedCell: TableViewModel) {
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        let selectedCell = selectedCell
        detailViewController.journalTitle = selectedCell.title
        detailViewController.journalSubtitle = selectedCell.subtitle
        detailViewController.journalDescription = selectedCell.article
    }
    
}

