//
//  Bike.swift
//  bikeTable
//
//  Created by Yvonne on 2019/12/18.
//  Copyright © 2019 Yvonne. All rights reserved.
//

import Foundation

struct bike :Codable {
    var  StationName : StationName
    var  StationAddress : StationAddress
}
struct StationName :Codable {
    var Zh_tw : String
}
struct StationAddress:Codable {
    var Zh_tw : String
}

//struct bike :Codable {
//  let  StationName : StationName
//  let  StationAddress : StationAddress
//
//struct StationName :Codable {
//   let Zh_tw : String
//}
//struct StationAddress:Codable {
//   let Zh_tw : String
//}
//}
