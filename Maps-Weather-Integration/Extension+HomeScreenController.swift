//
//  Extension+HomeScreenController.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 01/04/21.
//

import Foundation
import UIKit

extension HomeScreenController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK:- TableView Delegates and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nameCell, for: indexPath) as! NameCell
        cell.cityName.text = myPlaces[indexPath.row].city
        cell.cellVIew.layer.cornerRadius = cell.cellVIew.frame.width / 10
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city = storyboard?.instantiateViewController(identifier: Constants.identifierCity) as! CityScreenController
        city.cities = myPlaces[indexPath.row].city
        navigationController?.pushViewController(city, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //Swipe action to delete the rows in the tableview
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var swipe = UISwipeActionsConfiguration()
        
            let delete = UIContextualAction(style: UIContextualAction.Style.normal, title: "delete") { (UIContextualAction, view, completion) in
                let a = self.myPlaces.remove(at: indexPath.row).city
                if let data = self.databaseConnection{
                    do{
                        try data.run("DELETE FROM maz where city='\(a)'")
                        print("deleted successfully")
                        
                    }catch{
                        
                        print("error occured in deleting file")
                    }
                }
                tableView.reloadData()
                completion(true)
            }
            delete.image = UIImage(systemName: "trash")
            delete.backgroundColor = .systemRed
            
           swipe = UISwipeActionsConfiguration(actions: [delete])
       
        
        return swipe
    }
    
   
}
