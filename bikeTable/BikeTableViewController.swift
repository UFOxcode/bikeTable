//
//  BikeTableViewController.swift
//  bikeTable
//
//  Created by Yvonne on 2019/12/18.
//  Copyright © 2019 Yvonne. All rights reserved.
//

import UIKit
import CryptoKit

class BikeTableViewController: UITableViewController {
    
    var bikes = [bike]()
    var bikes2 = [BikeNew]()
    
    func getTimeString() -> String {
              let dateFormater = DateFormatter()
              dateFormater.dateFormat = "EEE, dd MMM yyyy HH:mm:ww zzz"
              dateFormater.locale = Locale(identifier: "en_US")
              dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
              let time = dateFormater.string(from: Date())
              return time
          }

    override func viewDidLoad() {
        super.viewDidLoad()
   let appId = "dd707dfb0f05472997489c0d81030f81"
   let appKey = "cnbiZ8toucJrjJNkoRARPvXJFzc"
   let xdate = getTimeString()
   let signDate = "x-date: \(xdate)"
   let key = SymmetricKey(data: Data(appKey.utf8))
   let hmac = HMAC<SHA256>.authenticationCode(for: Data(signDate.utf8), using: key)
   let base64HmacString = Data(hmac).base64EncodedString()
   let authorization = """
   hmac username="\(appId)", algorithm="hmac-sha256", headers="x-date", signature="\(base64HmacString)"
   """
   let url = URL(string: "https://ptx.transportdata.tw/MOTC/v2/Bike/Station/PingtungCounty?$top=30&$format=JSON")!
        
//        let url2 = URL(string: "https://ptx.transportdata.tw/MOTC/v2/Bike/Availability/PingtungCounty?$top=30&$format=JSON")!
 
   var request = URLRequest(url: url)
   request.setValue(xdate, forHTTPHeaderField: "x-date")
   request.setValue(authorization, forHTTPHeaderField: "Authorization")
   let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print ("here")
   //        let decoder = JSONDecoder()
       if let data = data {
           do{
               let bikes = try JSONDecoder().decode([bike].self, from: data)
                   self.bikes = bikes
                   DispatchQueue.main.async {
                    print (bikes)
                     // 測試
                       print(bikes.count)                 
                       print(bikes[0])
                    self.tableView.reloadData()
                   }
           }catch{
               print (error)
           }
       }
           }
        task.resume()
//        self.tableView.reloadData()
 //second api
        
        let url2 = URL(string: "https://ptx.transportdata.tw/MOTC/v2/Bike/Availability/PingtungCounty?$top=30&$format=JSON")!
          var request2 = URLRequest(url: url2)
          request2.setValue(xdate, forHTTPHeaderField: "x-date")
          request2.setValue(authorization, forHTTPHeaderField: "Authorization")
         let task2 = URLSession.shared.dataTask(with: request2) { (data, response, error) in
                   print ("here2")
          //        let decoder = JSONDecoder()
              if let data2 = data {
                  do{
                      let bikes2 = try JSONDecoder().decode([BikeNew].self, from: data2)
                          self.bikes2 = bikes2
                          DispatchQueue.main.async {
                           print (bikes2)
                            // 測試
                              print(bikes2.count)
                              print(bikes2[0])
                           self.tableView.reloadData()
                          }
                  }catch{
                      print (error)
                  }
              }
                  }
               task2.resume()
               self.tableView.reloadData()
        
        
        
        
        
        
        
      
    }

     
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bikes.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bikecell", for: indexPath)
        let bbkie = bikes[indexPath.row]
        
        print ("ok")
        cell.textLabel?.text = bbkie.StationName.Zh_tw
        print(bbkie.self.StationName.Zh_tw.description)
        cell.detailTextLabel?.text = bbkie.StationAddress.Zh_tw
        print (bbkie.StationName.Zh_tw.description)
        // Configure the cell...

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> DetailViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            let bike = bikes2[row]
            let bikestation = bikes[row]
            
//            return DetailViewController (coder: coder, bike: bike)
            return DetailViewController(coder: coder, bike: bike, bikestation: bikestation)
        }else{
        return nil
    }
    
    
    }
    
}
