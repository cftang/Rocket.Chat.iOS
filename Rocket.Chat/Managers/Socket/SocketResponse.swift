//
//  SocketResponse.swift
//  Rocket.Chat
//
//  Created by Rafael K. Streit on 7/22/16.
//  Copyright © 2016 Rocket.Chat. All rights reserved.
//

import Foundation
import SwiftyJSON
import Starscream


public struct SocketResponse {
    var socket: WebSocket?
    var result: JSON {
        didSet {
            self.collection = result["collection"].string
            
            if let eventName = result["eventName"].string{
                self.event = ResponseEvent(eventName)
            }

            if let msg = result["msg"].string {
                self.msg = ResponseMessage(msg)
            }
        }
    }

    // JSON Data
    var msg: ResponseMessage?
    var collection: String?
    var event: ResponseEvent?
    
    
    // MARK: Initializer

    init?(_ result: JSON, socket: WebSocket?) {
        self.result = result
        self.socket = socket
    }
    
    
    // MARK: Checks
    
    func isError() -> Bool {
        if msg == .Error || msg == .Failed {
            return true
        }
        
        if result["error"] != nil {
            return true
        }
        
        return false
    }
}