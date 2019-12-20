//
//  DetailViewController.swift
//  bikeTable
//
//  Created by Yvonne on 2019/12/20.
//  Copyright © 2019 Yvonne. All rights reserved.
//

import UIKit

// add for map
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var station: UILabel!
    
    @IBOutlet weak var availabel: UILabel!
    
 
    @IBOutlet weak var availabelReturn: UILabel!
    
    @IBOutlet weak var labelAddressForMap: UILabel!
    @IBOutlet weak var mapView: MKMapView!  // add for map
    
    
    
    let bike :BikeNew
    let bikestation: bike
    
    var local = "屏東市北興街55號"
        
    init?(coder:NSCoder,bike:BikeNew,bikestation:bike) {
        self.bike = bike
        self.bikestation = bikestation
        
        super.init(coder:coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        // Do any additional setup after loading the view.
    
        availabel.text = bike.AvailableRentBikes.description
        availabelReturn.text = bike.AvailableReturnBikes.description
        station.text = bikestation.StationName.Zh_tw
        
        
        local = bikestation.StationAddress.Zh_tw
        
        // StationAddress 並不清楚，所以location前面加上屏東市 會比較準確些
        let location = "屏東市\(local)"
        labelAddressForMap.text = location
        config(location: location)
    
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func config(location: String) {
        
    let geoCoder = CLGeocoder()
        print(location)
         print(location)
         print(location)
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                // get 第一個地點標記
                let placemark = placemarks[0]
                //加上標記
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    // 設定 縮放程度 大小
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 550, longitudinalMeters: 550)
                    
                    self.mapView.setRegion(region, animated: false)
                    
                }
                
            }
    })
    }
        
//    var location = "屏東市中正路700j號"
//        geoCoder.geocodeAddressString(location, completionHandler: { placemarks,error in if let error = error{print(error.localizedDescription)
//            return
//            }})
//
//    }
    
}
