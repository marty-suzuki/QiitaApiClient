//
//  QiitaExpandedTemplate.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/21.
//
//

import Foundation

open class QiitaExpandedTemplate: QiitaModel {
    open let expandedBody: String
    open let expandedTags: [QiitaTagging]
    open let expandedTitle: String
    
    public required init?(dictionary: [AnyHashable : Any]) {
        guard
            let expandedBody = dictionary["expanded_body"] as? String,
            let rawExpandedTags = dictionary["expanded_tags"] as? [[AnyHashable : Any]],
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
