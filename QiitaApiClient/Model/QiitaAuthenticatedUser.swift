//
//  QiitaAuthenticatedUser.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public class QiitaAuthenticatedUser: QiitaUser {
    public let imageMonthlyUploadLimit: Int
    public let imageMonthlyUploadRemaining: Int
    public let teamOnly: Bool
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let imageMonthlyUploadLimit = dictionary["image_monthly_upload_limit"] as? Int,
            let imageMonthlyUploadRemaining = dictionary["image_monthly_upload_remaining"] as? Int,
            let teamOnly = dictionary["team_only"] as? Bool
            else {
                return nil
        }
        
        self.imageMonthlyUploadLimit = imageMonthlyUploadLimit
        self.imageMonthlyUploadRemaining = imageMonthlyUploadRemaining
        self.teamOnly = teamOnly
        
        super.init(dictionary: dictionary)
    }
}