//
//  DetailViewController.swift
//  bikeTable
//
//  Created by Yvonne on 2019/12/20.
//  Copyright © 2019 Yvonne. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var station: UILabel!
    
    @IBOutlet weak var availabel: UILabel!
    
 
    @IBOutlet weak var availabelReturn: UILabel!
    
    let bike :BikeNew
    let bikestation: bike
    
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
    
    
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
