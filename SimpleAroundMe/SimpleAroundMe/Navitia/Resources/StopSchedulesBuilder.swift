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

    func build() -> [StopSchedule] {
        let url:String = "https://api.navitia.io/v1/coverage/fr-idf/coords/2.377310%3B48.847002/stop_schedules?"
        
        let requestURL: NSURL = NSURL(string: url)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        urlRequest.addValue("9e304161-bb97-4210-b13d-c71eaf58961c", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    
                    let json:[String:AnyObject] = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String:AnyObject]

                    if let jsonStopSchedules:[[String: AnyObject]] = json["stop_schedules"] as? [[String: AnyObject]] {
                        
                        for stopSchedule in jsonStopSchedules {
                            
                            if let stopPoint = stopSchedule["stop_point"] as? [String: AnyObject] {
                                
                                if let name = stopPoint["name"] as? String {
                                    self.stopSchedules.append(StopSchedule(stopPoint: StopPoint(name)))
                                    for innerStopSchedule in self.stopSchedules {
                                        print(name, innerStopSchedule.stopPoint.name)
                                    }
                                }
                                
                            }
                        }
                        
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
            else {
                print(statusCode)
            }
        }
        
        task.resume()

        print("END")
        for stopSchedule in stopSchedules {
            print(stopSchedule.stopPoint.name)
        }
        return stopSchedules
    }
}
