//
//  QiitaApiClient.swift
//  QiitaApiClient
//
//  Created by Taiki Suzuki on 2016/08/17.
//
//

import UIKit

public class QiitaApiClient: NSObject {

}

public struct QiitaAuthorizeScope: OptionSetType {
    public static let ReadQiita     : QiitaAuthorizeScope = .init(rawValue: 1 << 0) //- Qiitaからアクセストークンに紐付いたユーザに関連したデータを読み出す
    public static let ReadQiitaTeam : QiitaAuthorizeScope = .init(rawValue: 1 << 1) //- Qiita:Teamからデータを読み出す
    public static let WriteQiita    : QiitaAuthorizeScope = .init(rawValue: 1 << 2) //- Qiitaにデータを書き込む
    public static let WriteQiitaTeam: QiitaAuthorizeScope = .init(rawValue: 1 << 3) //- Qiita:Teamにデータを書き込む
    public static let All: QiitaAuthorizeScope = [.ReadQiita, .ReadQiitaTeam, .WriteQiita, .WriteQiitaTeam]
    
    private static let associatedValues: [UInt : String] = [
        QiitaAuthorizeScope.ReadQiita.rawValue      : "read_qiita",
        QiitaAuthorizeScope.ReadQiitaTeam.rawValue  : "read_qiita_team",
        QiitaAuthorizeScope.WriteQiita.rawValue     : "write_qiita",
        QiitaAuthorizeScope.WriteQiitaTeam.rawValue : "write_qiita_team"
    ]
    
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public var stringValue: String {
        let filteredValues: [(UInt, String)] = QiitaAuthorizeScope.associatedValues.filter { contains(QiitaAuthorizeScope(rawValue: $0.0)) }
        let strings: [String] = filteredValues.flatMap { $0.1 }
        let stringValue: String = strings.reduce("") { $0 == "" ? $1 : $0 + "+" + $1 }
        return stringValue
    }
}
