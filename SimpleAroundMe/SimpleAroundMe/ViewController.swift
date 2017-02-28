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
    let token:String = "9e304161-bb97-4210-b13d-c71eaf58961c"
    let coverage:String = "fr-idf"

    let cellIdentifier = "StopPointCellIdentifier"
    var stopSchedules:[StopSchedule] = []
    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    var currentlyUpdatingPosition:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.startMonitoringSignificantLocationChanges()
        }
        if (locationManager.location != nil) {
            self.populateTableWithDataFromLocation(CLLocation(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude))
        }
        self.updateLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Trying to process location update")
        if (self.currentlyUpdatingPosition) {
            self.currentlyUpdatingPosition = false
            print("  Changing location")
            let currentLocation: CLLocation? = locations.last
            manager.stopUpdatingLocation()
            print("  Changed location", currentLocation?.description ?? "DAMNED")
            if (currentLocation != nil) {
                self.populateTableWithDataFromLocation(currentLocation!)
            }
        }
    }

    func updateLocation() {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse) {
            print("Update location")
            self.currentlyUpdatingPosition = true
            locationManager.startUpdatingLocation()
        }
    }

    func populateTableWithDataFromLocation(_ currentLocation:CLLocation) {
        let currentCoord = Coord(lat: currentLocation.coordinate.latitude.description, lon: currentLocation.coordinate.longitude.description)

        CoordsBuilder(token: self.token, coverage: self.coverage)
            .withCoord(currentCoord)
            .build(callback: {
                (coords:Coords) -> Void in
                    let alertController = UIAlertController(title: "Current address", message: coords.address.label, preferredStyle: UIAlertControllerStyle.alert)

                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                    {
                        (result : UIAlertAction) -> Void in
                        print("You pressed OK")
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
            })

        StopSchedulesBuilder(token: self.token, coverage: self.coverage)
                .withCoords(currentCoord)
                .withDistance(1000)
                .withCount(30)
                .build(callback: {
                    (stopSchedules:[StopSchedule]) -> Void in
                    self.stopSchedules = stopSchedules
                    self.stopSchedules.sort() {
                        $0.dateTimes[0].dateTime < $1.dateTimes[0].dateTime
                    }
                    self.tableView.reloadData()
                })
    }

    @IBAction func refreshStopSchedulesAroundMe(_ sender: Any) {
        self.updateLocation()
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

