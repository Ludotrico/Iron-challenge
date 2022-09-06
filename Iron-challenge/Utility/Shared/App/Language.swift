//
//  Language.swift
//  Terra
//
//  Created by Ludovico Veniani on 1/19/22.
//

import Foundation

class Language {
    static let networkError = "Oops, please reconnect and try again."
    static let noResults = "No search results found"
    static var locationRequired: String {
        "\(Constants.appName) requires location services to claim land and show relevant data. Enable location services."
    }
    static let connectWalletCaption = "Connect to your Metamask wallet to continue."
    static var claimingCaption: String {
        if Constants.inAppReview {
            return "Stay in the \(Constants.landName) for \(Constants.claimDuration) seconds to claim what is rightfully yours!\n\nOnce you have claimed this \(Constants.landName), you will be able to leave your mark for all to see."
        } else {
            return "💸 As the first explorer of this \(Constants.landName), you'll receive \(Constants.explorerRoaylty.percentage) of each sale!\n\n⚠️ If another explorer mints this \(Constants.landName) before you, they'll take your ownership. The first minter gets to upgrade, customize, and monetize this land!\n\n🚫 Avoid purchasing and selling \(Constants.landName)s outside the app to preserve your royalty and lessen fees."
        }

    }
    static var exploringCaption: String {
        if Constants.inAppReview {
            return "Stay in the \(Constants.landName) for \(Constants.claimDuration) seconds to claim what is rightfully yours!\n\nOnce you have claimed this \(Constants.landName), you will be able to leave your mark for all to see."
        } else {
            return "⚡ The first explorer to mint this \(Constants.landName) gets to upgrade, customize, and monetize it. Speed is crucial!\n\n📖 Once you have claimed this \(Constants.landName), you'll be able to view and add to it's exclusive Logbook.\n\n🚫 Avoid purchasing and selling \(Constants.landName)s outside the app to lessen fees."
        }

    }
    static var claimingBeacon: String {
        if Constants.inAppReview {
            return "Stay in the \(Constants.landName) for \(Constants.claimDuration) seconds to claim what is rightfully yours!\n\nOnce you have claimed this \(Constants.landName), you will be able to leave your mark for all to see."
        } else {
            return "\(PointsManager.quartz) Once you've claimed this Beacon, you'll be rewarded with Quartz. The harder it is to reach the Beacon the bigger the reward!\n\n⏰ A random \(Constants.landName) from each drop is selected daily to be a Beacon. They expire after 24 hours.\n\n💡 Have any cool ideas you would like to see in our app? Feel free to contact us!"
        }

    }
    static var customizationText : String {
        if Constants.inAppReview {
            return "Flaunt your country of origin, show off a cool selfie, or craft an impactful message for all to see."
        } else {
            return "Flaunt your country of origin, show off a cool selfie, or craft an impactful message for all in the metaverse to see."
        }
    }
    
    static var addToLogbook : String {
        "Whether you almost slipped off a cliff, got attacked by a homeless person, or evaded sharks in the North Pacific, this is the place to share your experiences exploring this \(Constants.landName)."
    }
    static let pendingTransactionTitle = "Pending Transaction"
    static let pendingTransactionBody = "This NFT is being transacted, please try in a few minutes."
    static let expiredDataTitle = "Expired Data"
    static let expiredDataBody = "This NFT has changed ownership. Please refresh and then try again."
    
}

