//
//  QiitaTemplate.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

open class QiitaTemplate: QiitaModel {
    open let body: String
    open let id: Int
    open let name: String
    open let expandedBody: String
    open let expandedTags: [QiitaTag]
    open let expandedTitle: String
    open let tags: [QiitaTag]
    open let title: String
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let body = dictionary["body"] as? String,
            let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let expandedBody = dictionary["expanded_body"] as? String,
            let rawExpandedTags = dictionary["expanded_tags"] as? [[AnyHashable : Any]],
            let expandedTitle = dictionary["expanded_title"] as? String,
            let rawTags = dictionary["tags"] as? [[AnyHashable : Any]],
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
