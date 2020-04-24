//
//  Moneda.swift
//  WebService
//
//  Created by Miguel Angel Jimenez Melendez on 4/21/20.
//  Copyright © 2020 Miguel Angel Jimenez Melendez. All rights reserved.
//

import Foundation

class Moneda{
    var description: String?
    var rate: String?
    var code: String?
    
    init(description: String?, rate: String?, code: String?){
        self.description = description
        self.rate = rate
        self.code = code
    }
}
