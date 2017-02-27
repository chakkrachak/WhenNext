//
// Created by Chakkra CHAK on 23/02/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

class StopSchedulesBuilder {
    var coverage:String
    var token:String
    var coords:String?
    var stopSchedules:[StopSchedule]

    init(token:String, coverage: String) {
        self.token = token
        self.coverage = coverage
        self.stopSchedules = []
    }

    func withCoords(_ coords: String) -> StopSchedulesBuilder {
        self.coords = coords
        return self
    }

    func parseJsonResponse(_ stopSchedulesJsonResponse:[String:AnyObject]) -> StopSchedule {
        let stopPoint = stopSchedulesJsonResponse["stop_point"] as! [String: AnyObject]
        let dateTimes = stopSchedulesJsonResponse["date_times"] as! [[String: AnyObject]]
        let displayInformations = stopSchedulesJsonResponse["display_informations"] as! [String: AnyObject]

        return StopSchedule(
                stopPoint: StopPoint(
                        name: stopPoint["name"] as! String,
                        label: stopPoint["label"] as! String,
                        coord: Coord(
                                lat: (stopPoint["coord"] as! [String: String])["lat"]! as String,
                                lon: (stopPoint["coord"] as! [String: String])["lon"]! as String
                        )
                ),
                dateTimes: [
                        DateTime(dateTime: dateTimes[0]["date_time"] as! String)
                ],
                displayInformations: DisplayInformations(
                        color: displayInformations["color"] as! String,
                        commercialMode: displayInformations["commercial_mode"] as! String,
                        direction: displayInformations["direction"] as! String,
                        label: displayInformations["label"] as! String,
                        textColor: displayInformations["text_color"] as! String
                )
        )
    }
    
    func build(callback: @escaping ([StopSchedule]) -> (Void)) {
        let url:String = "https://api.navitia.io/v1/coverage/\(self.coverage)/coords/\(self.coords!)/stop_schedules?"
        
        let requestURL: NSURL = NSURL(string: url)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        urlRequest.addValue(self.token, forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    let json:[String:AnyObject] = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String:AnyObject]

                    let jsonStopSchedules:[[String: AnyObject]] = json["stop_schedules"] as! [[String: AnyObject]]
                    for stopSchedule in jsonStopSchedules {
                        self.stopSchedules.append(self.parseJsonResponse(stopSchedule))
                    }
                } catch {
                    print("Error with Json: \(error)")
                }
            }
            else {
                print(statusCode)
            }
            DispatchQueue.main.async {
                callback(self.stopSchedules)
            }
        }
        
        task.resume()
    }
}
