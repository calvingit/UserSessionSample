//
// Created by zen on 08/08/15.
// Copyright (c) 2015 dimazen. All rights reserved.
//

import Foundation

class UserSessionPathBuilder {

    private let identifier: String
    init(userSession: UserSession) {
        identifier = userSession.identifier
    }

    private func pathForDirectory(directory: FileManager.SearchPathDirectory) -> URL {
        let directory = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first!
        return URL(string: directory)!.appendingPathComponent("user_session")
    }

    // ~/Documents/user_session/identifier/
    func documentDirectory() -> String {
        return pathForDirectory(directory: .documentDirectory).appendingPathComponent(identifier).absoluteString
    }

    // ~/Library/Caches/user_session/identifier/
    func cachesDirectory() -> String {
        return pathForDirectory(directory: .cachesDirectory).appendingPathComponent(identifier).relativeString
    }
}
