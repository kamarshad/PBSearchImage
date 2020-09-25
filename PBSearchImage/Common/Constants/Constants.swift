//
//  Constants.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

struct Constants {
    static let defaultKeyword = "Apple"
    // As per the documentation keyword length may not exceed 100 characters.
    static let maxAllowedKeywordLength = 100
    static let emptyString = ""
    static let lineTermination = "\n"
}

struct Storyboard {
    static let home = "Main"
}

/*
 Considering the timeline i have kept it here
 otherwise ideal practice is to keep it in enviornment configuration file access it accordingly
 */

enum APIConstant {
    static let apiKey = "" //Your api key should be palced here
}

// Considering the timeline using the messages here. better approach is to read the message from localised string file

enum UIStringConstants {
    static let noNetworkConnection = "No active internet connection found. Kindly check you are connected to internet"
    static let badURL = "Bad URL fomat found"
    static let emptyResponse = "Empty resppnse is received from server"
    static let invalidResponseFormat = "Invalid response format is received from server"
    static let invalidRequestFormat = "Invalid request format"
    static let serverError = "Something went wrong"
    static let responseMappingError = "Error occurred during the model mapping"
    static let generalMessage = "Something went wrong. Please try after sometime"
    static let invalidStatus = "Invalid response status is received"
    static let apiKeyMissing = "API key is missing. Make sure a valid api key is added in APIConstant.\nFollow READ ME for more details"
    static let generalAlertTitle = "Alert"
    static let errorAlertTitle = "Error"
    static let ok = "Ok"
    static let cancel = "Cancel"
}

enum ModelConstants {
    static let comma = ","
    
    // Display max three tags for each received image. If you want to display less or more than to any number just change the constant value.
    // But server should also have that same number tags otherwise the default received tags will be displayed.
    static let allowedMaxTag = 3
}
