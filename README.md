# QiitaApiClient

[![CI Status](http://img.shields.io/travis/szk-atmosphere/QiitaApiClient.svg?style=flat)](https://travis-ci.org/szk-atmosphere/QiitaApiClient)
[![Version](https://img.shields.io/cocoapods/v/QiitaApiClient.svg?style=flat)](http://cocoapods.org/pods/QiitaApiClient)
[![License](https://img.shields.io/cocoapods/l/QiitaApiClient.svg?style=flat)](http://cocoapods.org/pods/QiitaApiClient)
[![Platform](https://img.shields.io/cocoapods/p/QiitaApiClient.svg?style=flat)](http://cocoapods.org/pods/QiitaApiClient)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

QiitaApiClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "QiitaApiClient"
```
| Original Path                               | Method | Associated Values                                                     | Response               |
|:--------------------------------------------|:-------|:----------------------------------------------------------------------|:-----------------------|
| /api/v2/oauth/authorize                     | Get    | QauthAuthorize(clientId: String, scope: String, state: String?)       | --                     |
| /api/v2/items/:item_id/likes                | Get    | ItemsItemIdLikes(itemId: Int)                                         | [QiitaLike]            |
| /api/v2/access_tokens                       | Post   | AccessTokens(clientId: String, clientSecret: String, code: String)    | QiitaAccessToken       |
| /api/v2/access_tokens/:access_token         | Delete | AccessTokens(accessToken: String)                                     | --                     |
| /api/v2/comments/:comment_id                | Delete | CommentsCommentId(commentId: String)                                  | --                     |
| /api/v2/comments/:comment_id                | Get    | CommentsCommentId(commentId: String)                                  | QiitaComment           |
| /api/v2/comments/:comment_id                | Patch  | CommentsCommentId(commentId: String, body: String)                    | QiitaComment           |
| /api/v2/comments/:comment_id/thank          | Delete | CommentsCommentIdThank(commentId: String)                             | QiitaComment           |
| /api/v2/comments/:comment_id/thank          | Put    | CommentsCommentIdThank(commentId: String)                             | QiitaComment           |
| /api/v2/items/:item_id/comments             | Get    | ItemsItemIdComments(itemId: String)                                   | [QiitaComment]         |
| /api/v2/items/:item_id/comments             | Post   | ItemsItemIdComments(itemId: String, body: String)                     | QiitaComment           |
| /api/v2/items/:item_id/taggings             | Post   | ItemsItemIdTaggings(itemId: String, name: String, versions: [String]) | QiitaTagging           |
| /api/v2/items/:item_id/taggings/:tagging_id | Delete | ItemsItemIdTaggingsTaggingId(itemId: String, taggingId: Int)          | --                     |
| /api/v2/tags                                | Get    | Tags(page: Int, perPage: Int, sort: Sort)                             | [QiitaTag]             |
| /api/v2/tags/:tag_id                        | Get    | TagsTagId(tagId: Int)                                                 | QiitaTag               |
| /api/v2/users/:user_id/following_tags       | Get    | UsersUserIdFollowingTags(userId: String, page: Int, perPage: Int)     | QiitaTag               |
| /api/v2/tags/:tag_id/following              | Delete | TagsTagIdFollowing(tagId: Int)                                        | --                     |
| /api/v2/tags/:tag_id/following              | Get    | TagsTagIdFollowing(tagId: Int)                                        | QiitaTag               |
| /api/v2/tags/:tag_id/following              | Put    | TagsTagIdFollowing(tagId: Int)                                        | --                     |
| /api/v2/teams                               | Get    | Teams                                                                 | --                     |
|||||

- [ ] GET /api/v2/templates
- [ ] DELETE /api/v2/templates/:template_id
- [ ] GET /api/v2/templates/:template_id
- [ ] POST /api/v2/templates
- [ ] PATCH /api/v2/templates/:template_id
- [ ] GET /api/v2/projects
- [ ] POST /api/v2/projects
- [ ] DELETE /api/v2/projects/:project_id
- [ ] GET /api/v2/projects/:project_id
- [ ] PATCH /api/v2/projects/:project_id
- [ ] GET /api/v2/items/:item_id/stockers
- [ ] GET /api/v2/users
- [ ] GET /api/v2/users/:user_id
- [ ] GET /api/v2/users/:user_id/followees
- [ ] GET /api/v2/users/:user_id/followers
- [ ] DELETE /api/v2/users/:user_id/following
- [ ] GET /api/v2/users/:user_id/following
- [ ] PUT /api/v2/users/:user_id/following
- [ ] POST /api/v2/expanded_templates
- [ ] GET /api/v2/authenticated_user/items
- [ ] GET /api/v2/items
- [ ] POST /api/v2/items
- [ ] DELETE /api/v2/items/:item_id
- [ ] GET /api/v2/items/:item_id
- [ ] PATCH /api/v2/items/:item_id
- [ ] DELETE /api/v2/items/:item_id/like
- [ ] PUT /api/v2/items/:item_id/like
- [ ] DELETE /api/v2/items/:item_id/stock
- [ ] GET /api/v2/items/:item_id/stock
- [ ] GET /api/v2/items/:item_id/like
- [ ] PUT /api/v2/items/:item_id/stock
- [ ] GET /api/v2/tags/:tag_id/items
- [ ] GET /api/v2/users/:user_id/items
- [ ] GET /api/v2/users/:user_id/stocks

| /api/v2/authenticated_user                  | Get    | AuthenticatedUser                                                     | QiitaAuthenticatedUser |

## Author

szk-atmosphere, s1180183@gmail.com

## License

QiitaApiClient is available under the MIT license. See the LICENSE file for more info.
