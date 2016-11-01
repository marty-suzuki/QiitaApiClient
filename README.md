# QiitaApiClient

[![CI Status](http://img.shields.io/travis/szk-atmosphere/QiitaApiClient.svg?style=flat)](https://travis-ci.org/szk-atmosphere/QiitaApiClient)
[![Version](https://img.shields.io/cocoapods/v/QiitaApiClient.svg?style=flat)](http://cocoapods.org/pods/QiitaApiClient)
[![License](https://img.shields.io/cocoapods/l/QiitaApiClient.svg?style=flat)](http://cocoapods.org/pods/QiitaApiClient)
[![Platform](https://img.shields.io/cocoapods/p/QiitaApiClient.svg?style=flat)](http://cocoapods.org/pods/QiitaApiClient)

API client for [Qiita](http://qiita.com/).

![](./Images/sample.gif)

## Features

- Show AuthorizeViewController automatically if you not authorized.
- Request with Associated Values
- Support Swift3

## Usage

```swift
//Search items sample
let method: QiitaHttpMethod = .get(.items(page: 1, perPage: 100, query: [.word("MisterFusion")]))
QiitaApiClient.default.request(method) { (response: QiitaResponse<[QiitaItem]>) in
    switch response.result {
    case .success(let models):
        print(response.totalCount)
        models.forEach { print($0.title) }
    case .failure(let error):
        print(error)
    }
}

//Fetch authenticated user sample
let method: QiitaHttpMethod = .get(.authenticatedUserItems(page: 1, perPage: 100))
QiitaApiClient.default.request(method) { (response: QiitaResponse<QiitaAuthenticatedUser>) in
    switch response.result {
    case .success(let model):
        print(model.name)
    case .failure(let error):
        print(error)
    }
}
```

## Configration

If you have created new [Qiita application](https://qiita.com/settings/applications/new), you can get `Client ID` and `Client Secret`.

You have to add `client_id`, `client_secret`, `redirect_url`, `scope` in your [Info.plist](./QiitaApiClientSample/QiitaApiClientSample/Info.plist) like this.

![](./Images/plist.png)

```
<key>QiitaApplicaiontInfo</key>
<dict>
	<key>client_secret</key>
	<string>xxxxxxxxxxxxxxYourClientSecretxxxxxxxxxxxxx</string>
	<key>redirect_url</key>
	<string>https://sample.com</string>
	<key>client_id</key>
	<string>xxxxxxxxxxxxxxxxYourClientIdxxxxxxxxxxxxxxx</string>
	<key>scope</key>
	<array>
		<string>read_qiita</string>
		<string>read_qiita_team</string>
		<string>write_qiita</string>
		<string>write_qiita_team</string>
	</array>
</dict>
```

## Installation

QiitaApiClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "QiitaApiClient"

```
## API

It is based on [Qiita API v2 Docs](http://qiita.com/api/v2/docs).

| Original Path                               | Method | Associated Values                                                                                                   | Response               |
|:--------------------------------------------|:-------|:--------------------------------------------------------------------------------------------------------------------|:-----------------------|
| /api/v2/oauth/authorize                     | get    | qauthAuthorize(clientId: String, scope: String, state: String?)                                                     | --                     |
| /api/v2/items/:item_id/likes                | get    | itemsItemIdLikes(itemId: Int)                                                                                       | [QiitaLike]            |
| /api/v2/access_tokens                       | post   | accessTokens(clientId: String, clientSecret: String, code: String)                                                  | QiitaAccessToken       |
| /api/v2/access_tokens/:access_token         | delete | accessTokens(accessToken: String)                                                                                   | --                     |
| /api/v2/comments/:comment_id                | delete | commentsCommentId(commentId: String)                                                                                | --                     |
| /api/v2/comments/:comment_id                | get    | commentsCommentId(commentId: String)                                                                                | QiitaComment           |
| /api/v2/comments/:comment_id                | patch  | commentsCommentId(commentId: String, body: String)                                                                  | QiitaComment           |
| /api/v2/comments/:comment_id/thank          | delete | commentsCommentIdThank(commentId: String)                                                                           | QiitaComment           |
| /api/v2/comments/:comment_id/thank          | put    | commentsCommentIdThank(commentId: String)                                                                           | QiitaComment           |
| /api/v2/items/:item_id/comments             | get    | itemsItemIdComments(itemId: String)                                                                                 | [QiitaComment]         |
| /api/v2/items/:item_id/comments             | post   | itemsItemIdComments(itemId: String, body: String)                                                                   | QiitaComment           |
| /api/v2/items/:item_id/taggings             | post   | itemsItemIdTaggings(itemId: String, name: String, versions: [String])                                               | QiitaTagging           |
| /api/v2/items/:item_id/taggings/:tagging_id | delete | itemsItemIdTaggingsTaggingId(itemId: String, taggingId: Int)                                                        | --                     |
| /api/v2/tags                                | get    | tags(page: Int, perPage: Int, sort: Sort)                                                                           | [QiitaTag]             |
| /api/v2/tags/:tag_id                        | get    | tagsTagId(tagId: Int)                                                                                               | QiitaTag               |
| /api/v2/users/:user_id/following_tags       | get    | usersUserIdFollowingTags(userId: String, page: Int, perPage: Int)                                                   | QiitaTag               |
| /api/v2/tags/:tag_id/following              | delete | tagsTagIdFollowing(tagId: Int)                                                                                      | --                     |
| /api/v2/tags/:tag_id/following              | get    | tagsTagIdFollowing(tagId: Int)                                                                                      | QiitaTag               |
| /api/v2/tags/:tag_id/following              | put    | tagsTagIdFollowing(tagId: Int)                                                                                      | --                     |
| /api/v2/teams                               | get    | teams                                                                                                               | [QiitaTeam]            |
| /api/v2/templates                           | get    | templates(page: Int, perPage: Int)                                                                                  | [QiitaTemplate]        |
| /api/v2/templates/:template_id              | delete | templatesTemplateId(templateId: Int)                                                                                | --                     |
| /api/v2/templates/:template_id              | get    | templatesTemplateId(templateId: Int)                                                                                | QiitaTemplate          |
| /api/v2/templates                           | post   | templates(body: String, name: String, tags: [QiitaTagging], title: String)                                          | QiitaTemplate          |
| /api/v2/templates/:template_id              | patch  | templatesTemplateId(templateId: Int, body: String, name: String, tags: [QiitaTagging], title: String)               | QiitaTemplate          |
| /api/v2/projects                            | get    | projects(page: Int, perPage: Int)                                                                                   | [QiitaProject]         |
| /api/v2/projects                            | post   | projects(archived: Bool, body: String, name: String, tags: [QiitaTagging])                                          | QiitaProject           |
| /api/v2/projects/:project_id                | delete | projectsProjectId(progectId: Int)                                                                                   | --                     |
| /api/v2/projects/:project_id                | get    | projectsProjectId(progectId: Int)                                                                                   | QiitaProject           |
| /api/v2/projects/:project_id                | patch  | projectsProjectId(progectId: Int, archived: Bool, body: String, name: String, tags: [QiitaTagging])                 | QiitaProject           |
| /api/v2/items/:item_id/stockers             | get    | itemsItemIdStockers(itemId: String, page: Int, perPage: Int)                                                        | [QiitaUser]            |
| /api/v2/users                               | get    | users(page: Int, perPage: Int)                                                                                      | [QiitaUser]            |
| /api/v2/users/:user_id                      | get    | usersUserId(userId: String)                                                                                         | QiitaUser              |
| /api/v2/users/:user_id/followees            | get    | usersUserIdFollowees(userId: String, page: Int, perPage: Int)                                                       | [QiitaUser]            |
| /api/v2/users/:user_id/followers            | get    | usersUserIdFollowers(uesrId: String, page: Int, perPage: Int)                                                       | [QiitaUser]            |
| /api/v2/users/:user_id/following            | delete | usersUserIdFollowing(userId: String)                                                                                | --                     |
| /api/v2/users/:user_id/following            | get    | usersUserIdFollowing(userId: String)                                                                                | QiitaUser              |
| /api/v2/users/:user_id/following            | put    | usersUserIdFollowing(userId: String)                                                                                | --                     |
| /api/v2/expanded_templates                  | post   | expandedTemplates(body: String, tags: [QiitaTagging], title: String)                                                | QiitaExpandedTemplate  |
| /api/v2/authenticated_user/items            | get    | authenticatedUserItems(page: Int, perPage: Int)                                                                     | [QiitaItem]            |
| /api/v2/items                               | get    | items(page: Int, perPage: Int, query: [SearchQuery])                                                                | [QiitaItem]            |
| /api/v2/items                               | post   | items(body: String, coediting: Bool, gist: Bool, `private`: Bool, tags: [QiitaTagging], title: String, tweet: Bool) | QiitaItem              |
| /api/v2/items/:item_id                      | delete | itemsItemId(itemId: String)                                                                                         | QiitaItem              |
| /api/v2/items/:item_id                      | get    | itemsItemId(itemId: String)                                                                                         | QiitaItem              |
| /api/v2/items/:item_id                      | patch  | itemsItemId(itemId: String, body: String, coediting: Bool, `private`: Bool, tags: [QiitaTagging], title: String)    | QiitaItem              |
| /api/v2/items/:item_id/like                 | delete | itemsItemIdLike(itemId: String)                                                                                     | --                     |
| /api/v2/items/:item_id/like                 | put    | itemsItemIdLike(itemId: String)                                                                                     | --                     |
| /api/v2/items/:item_id/stock                | delete | itemsItemIdStock(itemId: String)                                                                                    | --                     |
| /api/v2/items/:item_id/stock                | get    | itemsItemIdStock(itemId: String)                                                                                    | --                     |
| /api/v2/items/:item_id/like                 | get    | itemsItemIdLike(itemId: String)                                                                                     | --                     |
| /api/v2/items/:item_id/stock                | put    | itemsItemIdStock(itemId: String)                                                                                    | --                     |
| /api/v2/tags/:tag_id/items                  | get    | tagsTagIdItems(tagId: Int, page: Int, perPage: Int)                                                                 | [QiitaItem]            |
| /api/v2/users/:user_id/items                | get    | usersUserIdItems(userId: String, page: Int, perPage: Int)                                                           | [QiitaItem]            |
| /api/v2/users/:user_id/stocks               | get    | usersUserIdStocks(userId: String, page: Int, perPage: Int)                                                          | [QiitaItem]            |
| /api/v2/authenticated_user                  | get    | authenticatedUser                                                                                                   | QiitaAuthenticatedUser |

## Requirements

- Xcode 8.1 or greater
- iOS 8.0 or greater
- WebKit
- [MisterFusion](https://github.com/marty-suzuki/MisterFusion)

## Author

marty-suzuki, s1180183@gmail.com

## License

QiitaApiClient is available under the MIT license. See the LICENSE file for more info.
