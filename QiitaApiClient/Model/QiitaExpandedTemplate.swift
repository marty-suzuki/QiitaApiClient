//
//  QiitaExpandedTemplate.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

public class QiitaExpandedTemplate: QiitaModel {
    public let expandedBody: String
    public let expandedTags: [QiitaTagging]
    public let expandedTitle: String
    
    public required init?(dictionary: [String : NSObject]) {
        guard
            let expandedBody = dictionary["expanded_body"] as? String,
            let rawExpandedTags = dictionary["expanded_tags"] as? [[String : NSObject]],
            let expandedTitle = dictionary["expanded_title"] as? String
        else {
            return nil
        }
        self.expandedBody = expandedBody
        let expandedTags: [QiitaTagging] = rawExpandedTags.flatMap { QiitaTagging(dictionary: $0) }
        self.expandedTags = expandedTags
        self.expandedTitle = expandedTitle
    }
}