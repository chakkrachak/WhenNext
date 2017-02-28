//
//  ViewController.swift
//  SimpleAroundMe
//
//  Created by Chakkra CHAK on 23/02/2017.
//  Copyright © 2017 Chakkra CHAK. All rights reserved.
//

import UIKit
import CoreLocation

class StopPointViewCell: UITableViewCell {
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var stopPointNameLabel: UILabel!
    @IBOutlet weak var nextScheduleLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    func updateWith(stopSchedule:StopSchedule) {
        self.stopPointNameLabel.text = stopSchedule.stopPoint.name
        self.stopPointNameLabel.textColor = UIColor(hexString: stopSchedule.displayInformations.textColor)

        self.lineLabel.text = stopSchedule.displayInformations.label
        self.lineLabel.textColor = UIColor(hexString: stopSchedule.displayInformations.textColor)

        self.directionLabel.text = stopSchedule.displayInformations.direction
        self.directionLabel.textColor = UIColor(hexString: stopSchedule.displayInformations.textColor)

        (self.nextScheduleLabel.text!, self.unitLabel.text!) = stopSchedule.dateTimes[0].dateTime.timeIntervalSinceNow.inFutureSmartDisplay()
        self.nextScheduleLabel.textColor = UIColor(hexString: stopSchedule.displayInformations.textColor)
        self.unitLabel.textColor = UIColor(hexString: stopSchedule.displayInformations.textColor)

        self.backgroundColor = UIColor(hexString: stopSchedule.displayInformations.color)
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    let cellIdentifier = "StopPointCellIdentifier"
    var stopSchedules:[StopSchedule] = []
    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        self.populateTableWithData()
    }
    
    func populateTableWithData() {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            currentLocation = locationManager.location
            print("CHECK POSITION HERE >>>> ", currentLocation?.description ?? "DAMNED")
            locationManager.stopUpdatingLocation()
        }
        
        StopSchedulesBuilder(token: "9e304161-bb97-4210-b13d-c71eaf58961c", coverage: "fr-idf")
            .withCoords("2.377310;48.847002")
            .withDistance(1000)
            .withCount(30)
            .build(callback:
                {
                    (stopSchedules:[StopSchedule]) -> Void in
                    self.stopSchedules = stopSchedules
                    self.tableView.reloadData()
                })
    }

    @IBAction func refreshStopSchedulesAroundMe(_ sender: Any) {
        self.populateTableWithData()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! StopPointViewCell
        
        cell.updateWith(stopSchedule:stopSchedules[indexPath.row])
        
        return cell
    }


}

