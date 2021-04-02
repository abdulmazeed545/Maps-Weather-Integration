//
//  ViewController.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 31/03/21.
//

import UIKit
import MapKit
import SQLite

class ViewController: UIViewController, UISearchBarDelegate{
    
    //Creating a variable to connect the database
    var databaseConnection:Connection!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling the function to create data base
        createDataBase()
    }
    //MARK:- Creating a user database
    func createDataBase()
    {
        //Creating a file path for the documents directory
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do{
            databaseConnection = try Connection("\(filePath)mazeed.sqlite3")
        }catch{
            print("Oops connection error:\(error.localizedDescription)")
        }
       
        do{
            //Creating a table
            try databaseConnection.run("create table IF NOT EXISTS maz (ID Integer primary key AUTOINCREMENT, city text)  ")
            
        }catch{
            
        }
       
    }
    
    @IBAction func homeAction(_ sender: UIButton) {
        
        //Creating an instance to the home view controller
        let home = storyboard?.instantiateViewController(identifier: Constants.identifierHome) as! HomeScreenController
        home.databaseConnection = databaseConnection
        navigationController?.pushViewController(home, animated: true)
    }
    
    @IBAction func help(_ sender: UIButton) {
        let help = storyboard?.instantiateViewController(identifier: "help") as! HelpController
        navigationController?.pushViewController(help, animated: true)
    }
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        
        //Creating an instance to the search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.automaticallyShowsScopeBar = true
        present(searchController, animated: true, completion: nil)
    }
    
    @IBAction func bookMarks(_ sender: UIBarButtonItem) {
        
       
        //Creating an alert to the bookmarks button
        let alert = UIAlertController(title: "Alert", message: Constants.alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            
            //Storing the places data into the user defaults
            self.inserData()
            //Clearing the textfield data
            self.searchField.text = nil
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK:- Inserting data into table
    func inserData(){
        
        do{
            //Inserting the values into the data base table
            try databaseConnection.run("INSERT into maz (city) VALUES (?)", searchField.text!)
        }catch{
            print("oops error occured in insertion")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Activity Indicator
        let myActIndicator = UIActivityIndicatorView()
        myActIndicator.style = .medium
        myActIndicator.center = self.view.center
        myActIndicator.hidesWhenStopped = true
        myActIndicator.startAnimating()
        
        self.view.addSubview(myActIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            myActIndicator.stopAnimating()
                       
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                self.searchField.text = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
            
        }
    }
    
}

