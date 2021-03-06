//
// Created by Chakkra CHAK on 23/02/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

public class StopSchedulesBuilder : BaseNavitiaResourceBuilder {
    public var coord:Coord?
    public var distance:Int?
    public var count:Int?
    public var stopSchedules:[StopSchedule]

    override public init(token:String, coverage: String) {
        self.stopSchedules = []
        self.distance = 1000
        self.count = 20

        super.init(token: token, coverage: coverage)
    }

    public func withCoords(_ coords: Coord) -> StopSchedulesBuilder {
        self.coord = coords
        return self
    }
    
    public func withDistance(_ distance: Int) -> StopSchedulesBuilder {
        self.distance = distance
        return self
    }

    public func withCount(_ count: Int) -> StopSchedulesBuilder {
        self.count = count
        return self
    }

    public func build(callback: @escaping ([StopSchedule]) -> (Void)) {
        let url:String = "https://api.navitia.io/v1/coverage/\(self.coverage)/coords/\(self.coord!.lat);\(self.coord!.lon)/stop_schedules?distance=\(self.distance!)&count=\(self.count!)"
        print(url)
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
                        let currentStopSchedule:StopSchedule? = self.parseJsonResponse(stopSchedule)
                        if currentStopSchedule != nil {
                            self.stopSchedules.append(currentStopSchedule!)
                        }
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
    
    func parseJsonResponse(_ stopSchedulesJsonResponse:[String:AnyObject]) -> StopSchedule? {
        let stopPoint = stopSchedulesJsonResponse["stop_point"] as! [String: AnyObject]
        let dateTimes = stopSchedulesJsonResponse["date_times"] as! [[String: AnyObject]]
        let displayInformations = stopSchedulesJsonResponse["display_informations"] as! [String: AnyObject]
        
        var resultStopSchedule:StopSchedule? = nil
        if dateTimes.count > 0 {
            resultStopSchedule = StopSchedule(
                stopPoint: StopPoint(
                    name: stopPoint["name"] as! String,
                    label: stopPoint["label"] as! String,
                    coord: Coord(
                        lat: (stopPoint["coord"] as! [String: String])["lat"]! as String,
                        lon: (stopPoint["coord"] as! [String: String])["lon"]! as String
                    )
                ),
                dateTimes: [
                    DateTime(dateTime:(dateTimes[0]["date_time"] as! String).dateFromNativiaFormat()!)
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
        
        return resultStopSchedule
    }
}
