//
// Created by zen on 08/08/15.
// Copyright (c) 2015 dimazen. All rights reserved.
//

import Foundation

class AuthorizationAPIClient {

    func loginWithUsername(username: String, password: String, completion: @escaping (UserSessionPrototype?, NSError?) -> Void) {
        DispatchQueue.main.async() {
            let userId = String(format: "%08x", NSUUID().uuidString.hash)
            let json: [String: Any] = [
                "result": [
                    "user": [
                        "id": userId,
                        "email": "\(userId)_foo@bar.com",
                        "name": "Foo Bar"
                    ]
                ]
            ]

            completion(UserSessionPrototype(response: json as [String : AnyObject]), nil)
        }
    }
}
