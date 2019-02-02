//
//  PushNotificationController.swift
//  Nest
//
//  Created by Michel-Andre Chirita on 07/02/2017.
//
//

import Foundation
//import CCurl
import VaporAPNS

final class PushNotificationController {
    
    var vaporAPNS : VaporAPNS?
    
    func register() throws {
        
        let options = try! Options(topic: "benext.Nest-Demo-App", //"<your bundle identifier>",
                                   teamId: "benext", //"<your team identifier>",
                                   keyId: "", //"<your key id>",
                                   keyPath: "") //"/path/to/your/APNSAuthKey.p8")
        
        vaporAPNS = try VaporAPNS(options: options)
    }
    
    func sendTest() throws {
        
        let payload = Payload(message: "Your push message comes here")
//        let payload = Payload(title: "Title", body: "Your push message comes here")
//        let payload = Payload.contentAvailable
//        let payload = Payload()
//        payload.bodyLocKey = "GAME_PLAY_REQUEST_FORMAT"
//        payload.bodyLocArgs = [ "Jenna", "Frank" ]
        
        
        let pushMessage = ApplePushMessage(topic: "benext.Nest-Demo-App",
                                           priority: .immediately,
                                           payload: payload,
                                           sandbox: true)
        
        try? send(pushMessage)
    }
    
    func send(_ pushMessage: ApplePushMessage) throws {
        
        vaporAPNS?.send(pushMessage, to: ["488681b8e30e6722012aeb88f485c823b9be15c42e6cc8db1550a8f1abb590d7", "2d11c1a026a168cee25690f2770993f6068206b1d11d54f88910b8166b23f983"]) { result in
            print(result)
            if case let .success(messageId,deviceToken,serviceStatus) = result, case .success = serviceStatus {
                print ("Success!")
            }
        }
    }
}
