//
//  BikeListController.swift
//  velib
//
//  Created by Clément SAUVAGE on 30/10/2017.
//  Copyright © 2017 Clément SAUVAGE. All rights reserved.
//

import UIKit

class BikeListController: UITableViewController {
    
    var stationArray: [Station] = []
    var currentStation: Station?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parisUrl = "https://opendata.paris.fr/api/records/1.0/search/?dataset=stations-velib-disponibilites-en-temps-reel&facet=banking&facet=bonus&facet=status&facet=contract_name"
        
        StationManager.fromUrl(dataSource: parisUrl){
            stations in
            
            if let stations = stations {
                self.stationArray = stations
                self.tableView.reloadData()
            }
            
        }
        
        let cellNib = UINib.init(nibName: "StationCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "StationCell")
        
        let station = Station.init(name: "SupDeWeb",
                                   address: "10-12 rue Lyautey, 75016 PARIS")
        
        self.stationArray.append(station)
        self.title = "Liste des stations"
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.stationArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as? StationCell
        
        if let cell = cell {
            let station = self.stationArray[indexPath.row]
            
            cell.addressLabel.text = station.addressString
            cell.nameLabel.text = station.nameString
            
            cell.availableLabel.text = "\(station.availableBikes) / \(station.availableSpot)"
            
            if station.isOpened {
                cell.statusLabel.text = "Ouvert"
                cell.statusLabel.textColor = UIColor.green
            } else {
                cell.statusLabel.text = "Fermé"
                cell.statusLabel.textColor = UIColor.red
            }
            
            return cell
            
        } else {
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.currentStation = self.stationArray[indexPath.row]
        
        self.performSegue(withIdentifier: "detailStationSegue", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailsController = segue.destination as? DetailsController
        
        if let destination = detailsController {
            destination.station = currentStation
        }
        
    }

}
