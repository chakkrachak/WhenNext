//
// Created by Chakkra CHAK on 23/02/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

class StopSchedulesBuilder {
    var coverage:String
    var token:String
    var coords:String?

    init(token:String, coverage: String) {
        self.token = token
        self.coverage = coverage
    }

    func withCoords(_ coords: String) -> StopSchedulesBuilder {
        self.coords = coords
        return self
    }

    func build() -> [StopSchedule] {
        // let url:String = "https://9e304161-bb97-4210-b13d-c71eaf58961c@api.navitia.io/v1/coverage/fr-idf/coords/2.377310%3B48.847002/stop_schedules?"
        
        let requestURL: NSURL = NSURL(string: "http://www.learnswiftonline.com/Samples/subway.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String:AnyObject]
                    
                    if let stations = json["stations"] as? [[String: AnyObject]] {
                        
                        for station in stations {
                            
                            if let name = station["stationName"] as? String {
                                
                                if let year = station["buildYear"] as? String {
                                    print(name,year)
                                }
                                
                            }
                        }
                        
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        
        task.resume()
        
        return [
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 1")),
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 2")),
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 3")),
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 4")),
            StopSchedule(stopPoint: StopPoint("Arrêt des enfers 5"))
        ]
    }
}
