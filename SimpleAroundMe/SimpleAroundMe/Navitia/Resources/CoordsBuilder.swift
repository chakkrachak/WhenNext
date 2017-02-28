//
// Created by Chakkra CHAK on 23/02/2017.
// Copyright (c) 2017 Chakkra CHAK. All rights reserved.
//

import Foundation

class CoordsBuilder {
    var coverage:String
    var token:String
    var coord:Coord? = nil
    var coords:Coords? = nil

    init(token:String, coverage: String) {
        self.token = token
        self.coverage = coverage
    }

    func withCoord(_ coord: Coord) -> CoordsBuilder {
        self.coord = coord
        return self
    }

    func build(callback: @escaping (Coords) -> (Void)) {
        let url:String = "https://api.navitia.io/v1/coverage/\(self.coverage)/coords/\(self.coord!.lat);\(self.coord!.lon)"
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
                    self.coords = self.parseJsonResponse(json)

                } catch {
                    print("Error with Json: \(error)")
                }
            }
            else {
                print(statusCode)
            }
            if (self.coords != nil) {
                DispatchQueue.main.async {
                    callback(self.coords!)
                }
            }
        }
        
        task.resume()
    }
    
    func parseJsonResponse(_ coordsJsonResponse:[String:AnyObject]) -> Coords? {
        let address = coordsJsonResponse["address"] as! [String: AnyObject]
        
        var resultCoords:Coords? = nil
        resultCoords = Coords(address: Address(label: address["label"] as! String!))
        
        return resultCoords
    }
}
