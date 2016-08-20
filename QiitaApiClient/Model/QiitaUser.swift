//
//  QiitaUser.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

public class QiitaUser: QiitaModel {
    public let description: String?
    public let facebookId: String?
    public let followeesCount: Int
    public let followersCount: Int
    public let githubLoginName: String?
    public let id: String
    public let itemsCount: Int
    public let linkedinId: String?
    public let location: String?
    public let name: String?
    public let organization: String?
    public let permanentId: Int
    public let profileImageUrl: NSURL
    public let twitterScreenName: String?
    public let websiteUrl: NSURL?
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let followeesCount = dictionary["followees_count"] as? Int,
            let followersCount = dictionary["followers_count"] as? Int,
            let id = dictionary["id"] as? String,
            let itemsCount = dictionary["items_count"] as? Int,
            let permanentId = dictionary["permanent_id"] as? Int,
            let rawProfileImageUrl = dictionary["profile_image_url"] as? String,
            let profileImageUrl = NSURL(string: rawProfileImageUrl)
        else {
            return nil
        }
        
        self.description = dictionary["description"] as? String
        self.facebookId = dictionary["facebook_id"] as? String
        self.followeesCount = followeesCount
        self.followersCount = followersCount
        self.githubLoginName = dictionary["github_login_name"] as? String
        self.id = id
        self.itemsCount = itemsCount
        self.linkedinId = dictionary["linkedin_id"] as? String
        self.location = dictionary["location"] as? String
        self.name = dictionary["name"] as? String
        self.organization = dictionary["organization"] as? String
        self.permanentId = permanentId
        self.profileImageUrl = profileImageUrl
        self.twitterScreenName = dictionary["twitter_screen_name"] as? String
        if let rawWebsiteUrl = dictionary["website_url"] as? String {
            self.websiteUrl = NSURL(string: rawProfileImageUrl)
        } else {
            self.websiteUrl = nil
        }
    }
}
