//
//  Utilites.swift
//  Sports App
//
//  Created by Nada on 24/05/2023.
//

import Foundation
import Reachability

class CheckInternetConnection{
    static var reachabilityInstance: Reachability?
    static func isInternetAvailable() -> Bool {
        let reachability = try? reachabilityInstance ?? Reachability()
            return reachability?.connection != .unavailable
    }
}
