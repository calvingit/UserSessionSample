//
// Created by zen on 08/08/15.
// Copyright (c) 2015 dimazen. All rights reserved.
//

import Foundation

class UserSessionController {

    // MARK: - Init
    let userDefaults: UserDefaults
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    // MARK: - UserSession
    private(set) var userSession: UserSession? {
        didSet {
            oldValue?.close()
            _ = userSession?.open()

            userSessionIdentifier = userSession?.identifier
        }
    }

    // MARK: - Open / Close

    private let apiClient = AuthorizationAPIClient()

    func openSession(username: String, password: String, completion: @escaping (UserSession?, NSError?) -> Void) {
        let requestCompletion: (UserSessionPrototype?, NSError?) -> Void = { prototype, error in
            if let prototype = prototype {
                self.userSession = UserSession(prototype: prototype)
                completion(self.userSession, nil)
            } else {
                completion(nil, error) // preferrable to map error to the UserSessionControllet's level
            }
        }

        return apiClient.loginWithUsername(username: username, password: password, completion: requestCompletion)
    }

    func closeSession() {
        userSession = nil
    }

    // MARK: - Restoration

    private static let userSessionKey = "your.app.bundle.id.userSession"
    private var userSessionIdentifier: String? {
        get {
            return userDefaults.object(forKey: UserSessionController.userSessionKey) as? String
        }
        set {
            userDefaults.set(newValue, forKey: UserSessionController.userSessionKey)
            userDefaults.synchronize()
        }
    }

    func restoreUserSession() -> UserSession? {
        assert(userSession == nil, "It is illegal restore session while ")

        if let identifier = userSessionIdentifier, let session = UserSession(restorationIdentifier: identifier) {
            self.userSession = session
            return session
        }

        return nil
    }

    var canRestoreUserSession: Bool {
        return userSessionIdentifier != nil
    }
}
