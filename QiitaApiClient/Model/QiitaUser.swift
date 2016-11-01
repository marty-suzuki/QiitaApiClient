//
//  QiitaUser.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/20.
//
//

import Foundation

open class QiitaUser: QiitaModel {
    open let description: String?
    open let facebookId: String?
    open let followeesCount: Int
    open let followersCount: Int
    open let githubLoginName: String?
    open let id: String
    open let itemsCount: Int
    open let linkedinId: String?
    open let location: String?
    open let name: String?
    open let organization: String?
    open let permanentId: Int
    open let profileImageUrl: URL
    open let twitterScreenName: String?
    open let websiteUrl: URL?
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let followeesCount = dictionary["followees_count"] as? Int,
            let followersCount = dictionary["followers_count"] as? Int,
            let id = dictionary["id"] as? String,
            let itemsCount = dictionary["items_count"] as? Int,
            let permanentId = dictionary["permanent_id"] as? Int,
            let rawProfileImageUrl = dictionary["profile_image_url"] as? String,
            let profileImageUrl = URL(string: rawProfileImageUrl)
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
            self.websiteUrl = URL(string: rawProfileImageUrl)
        } else {
            self.websiteUrl = nil
        }
    }
}
