//
//  KeyChainStore.swift
//  PicSplash
//
//  Created by Sergio Lechini on 06.09.2021.
//

import Foundation
import Security

/// Протокол для работы с KeyChainManager
protocol KeyChainStore {
    /// Записать API key
    /// - Parameters:
    ///   - key: API key
    ///   - endpoint: адрес API
    func setApiKey(_ key: String, for endpoint: String)
    /// Получить API key
    /// - Parameter endpoint: адрес API
    func getApiKey(for endpoint: String) -> String?
    /// Удалить API key
    /// - Parameter endpoint: адрес API
    func deleteApiKey(for endpoint: String)
    /// Проверить авторизован ли
    /// - Parameter endPoint: адрес API
    func isAuthorized(for endPoint: String) -> Bool
}

final class KeyChainManager { }

extension KeyChainManager: KeyChainStore {
    func setApiKey(_ key: String, for endpoint: String) {
        guard let secValueData = key.data(using: .utf8) else { return }
        
        let keytChainItemQuery = [
            kSecValueData: secValueData,
            kSecAttrServer: endpoint,
            kSecClass: kSecClassInternetPassword
        ] as CFDictionary
        
        SecItemAdd(keytChainItemQuery, nil)
    }
    
    func getApiKey(for endpoint: String) -> String? {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: endpoint,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        
        SecItemCopyMatching(query, &result)
        
        guard let resultDict = result as? NSDictionary, let apiKeyData = resultDict[kSecValueData] as? Data, let apiKey = String(data: apiKeyData, encoding: .utf8) else { return nil }
        
        return apiKey
    }
        
    func deleteApiKey(for endpoint: String) {
        let query = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrServer: endpoint,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    func isAuthorized(for endPoint: String) -> Bool {
        return getApiKey(for: endPoint) == nil ? false : true
    }
}
