//
//  ViewController.swift
//  SimpleAroundMe
//
//  Created by Chakkra CHAK on 23/02/2017.
//  Copyright © 2017 Chakkra CHAK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let cellIdentifier = "PoiCellIdentifier"
    var stopSchedules:[StopSchedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopSchedules = StopSchedulesBuilder(token: "", coverage: "fr-idf").withCoords("2.377310;48.847002").build()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopSchedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        
        let stopSchedule:StopSchedule = stopSchedules[indexPath.row]
        
        cell.textLabel?.text = stopSchedule.stopPoint.name
        
        return cell
    }
}

