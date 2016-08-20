//
//  QiitaTemplate.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

public class QiitaTemplate: QiitaModel {
    public let body: String
    public let id: Int
    public let name: String
    public let expandedBody: String
    public let expandedTags: [QiitaTag]
    public let expandedTitle: String
    public let tags: [QiitaTag]
    public let title: String
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let body = dictionary["body"] as? String,
            let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let expandedBody = dictionary["expanded_body"] as? String,
            let rawExpandedTags = dictionary["expanded_tags"] as? [[String : NSObject]],
            let expandedTitle = dictionary["expanded_title"] as? String,
            let rawTags = dictionary["tags"] as? [[String : NSObject]],
            let title = dictionary["title"] as? String
        else {
            return nil
        }
        self.body = body
        self.id = id
        self.name = name
        self.expandedBody = expandedBody
        let expandedTags: [QiitaTag] = rawExpandedTags.flatMap { QiitaTag(dictionary: $0) }
        self.expandedTags = expandedTags
        self.expandedTitle = expandedTitle
        let tags: [QiitaTag] = rawTags.flatMap { QiitaTag(dictionary: $0) }
        self.tags = tags
        self.title = title
    }
}