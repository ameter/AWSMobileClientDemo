//
//  MobileClientManager.swift
//  Authenticated
//
//  Created by Ameter, Chris on 6/10/22.
//

import AWSMobileClientXCF

class MobileClientManager: ObservableObject {
    
    func getTokens() {
        AWSMobileClient.default().getTokens { (tokens, error) in
            if error != nil {
                print("getTokens error: \(error?.localizedDescription ?? "nil")")
            } else {
                print("got tokens...")
                dump(tokens)
            }
        }
    }
    
    func start() {
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                switch(userState){
                case .signedIn:
                    print("initialize: signed in")
                case .signedOut:
                    print("initialize: signed out")
                case .signedOutUserPoolsTokenInvalid:
                    print("initialize: signedOutUserPoolsTokenInvalid")
                    // report error
                    // marker 2
                case .signedOutFederatedTokensInvalid:
                    print("initialize: signedOutFederatedTokensInvalid")
                    // report error
                default:
                    // report error
                    // do failsafe logout
                    print("initialize: hit default case")
                }
            } else if let error = error {
                // report error
                // do failsafe logout
                print("initialize: error: \(error.localizedDescription)")
            }
        }
        
        AWSMobileClient.default().addUserStateListener(self) { (userState, info) in
            switch (userState) {
            case .signedOut:
                //present sign in UI
                print("UserStateListener: signed out")
            case .signedOutUserPoolsTokenInvalid:
                //present sign in UI
                //report error
                // marker 1
                print("UserStateListener: signedOutUserPoolsTokenInvalid")
            case .signedOutFederatedTokensInvalid:
                //present sign in UI
                //report error
                print("UserStateListener: signedOutFederatedTokensInvalid")
            default:
                break
            }
        }
    }
    
    func signIn(username: String, password: String) {
        AWSMobileClient.default().signIn(username: username, password: password) { (result, error) in
            if let awsError = error as? AWSMobileClientError {
                switch awsError {
                case .notAuthorized(message: let message):
                    // show error popup
                    print("signin not authorized: \(message)")
                default:
                    if let message = error?.localizedDescription {
                        // show error popup
                        print("signin error: \(message)")
                    }
                }
            } else {
                dump(result)
            }
        }
    }
}
