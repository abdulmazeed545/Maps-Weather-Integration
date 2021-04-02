//
//  HomeScreenController.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 31/03/21.
//

import UIKit
import SQLite

class HomeScreenController: UIViewController{

    
    var databaseConnection:Connection!
    //Creating a variable to the struct array
    var myPlaces:[Places] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        let name = UINib(nibName: "NameCell", bundle: nil)
        tableView.register(name, forCellReuseIdentifier: Constants.nameCell)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
      
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Fetching data from database
    func fetchData(){
        
        do{
            let maz = try databaseConnection.run("SELECT * FROM maz")
            var result:Places!
            for row in maz{
                
                result = Places(city: row[1]! as! String)
                //Appending the values to the struct array
                myPlaces.append(result)
                
            }
            
        }catch{
            print("error in fetching the data")
        }
       
    }
   
}
