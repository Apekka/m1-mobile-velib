//
//  StationManager.swift
//  velib
//
//  Created by Clément SAUVAGE on 22/11/2017.
//  Copyright © 2017 Clément SAUVAGE. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

struct VelibResponse: Mappable  {
    
    var stations: [Station]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        stations <- map["records"]
    }
}

class StationManager: NSObject {

    // Méthode statique qui va parser mes datas
    
    static func fromUrl(dataSource: String,
                        responseHandler: @escaping ([Station]?)->()) {
        
        Alamofire.request(dataSource).responseObject { (res: DataResponse<VelibResponse>) in
            
            dump(res.value?.stations)
            responseHandler(res.value?.stations);
            
            
            
            
        }
        
        
    }
    
    
}
