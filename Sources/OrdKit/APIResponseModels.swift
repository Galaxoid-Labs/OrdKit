//
//  APIResponseModels.swift
//
//
//  Created by Jacob Davis on 1/28/24.
//

import Foundation

public extension OrdKit.API {
    
    struct Block: Codable, Identifiable {
        
        public var id: UInt32 { height }
        
        public let hash: String
        public let target: String
        public let bestHeight: UInt32
        public let height: UInt32
        public let inscriptions: [String]
    }
    
    typealias BlockCount = UInt32
    typealias BlockHash = String
    typealias BlockHeight = UInt32
    typealias BlockTime = Date
    
    struct Inscription: Codable, Identifiable {
        
        public var id: String { return inscriptionId }
        
        public let address: String?
        public let charms: [Inscription.Charm]
        public let children: [String]
        public let contentLength: UInt64?
        public let contentType: String?
        public let genesisFee: UInt64
        public let genesisHeight: UInt32
        public let inscriptionId: String
        public let inscriptionNumber: Int32
        public let next: String?
        public let outputValue: UInt64?
        public let parent: String?
        public let previous: String?
        //public let rune // TODO: Make runespace type
        public let sat: UInt64?
        public let satpoint: String // TODO: Make satpoint type?
        public let timestamp: Date
        
        public enum Charm: String, Codable {
            case coin, cursed, epic, legendary, lost, nineball, rare, reinscription, unbound, uncommon, vindicated
            public var emoji: String {
                switch self {
                    case .coin: return "🪙"
                    case .cursed: return "👹"
                    case .epic: return "🪻"
                    case .legendary: return "🌝"
                    case .lost: return "🤔"
                    case .nineball: return "9️⃣"
                    case .rare: return "🧿"
                    case .reinscription: return "♻️"
                    case .unbound: return "🔓"
                    case .uncommon: return "🌱"
                    case .vindicated: return "❤️‍🔥"
                }
            }
        }
        
        var contentUrl: URL? {
            return OrdKit.baseURL?.appending(path: "content/\(inscriptionId)")
        }
        
        var previewUrl: URL? {
            return OrdKit.baseURL?.appending(path: "preview/\(inscriptionId)")
        }
        
    }
    
    struct Inscriptions: Codable {
        
        public let inscriptions: [String]
        public let more: Bool
        public let pageIndex: Int
        
    }
    
    struct Sat: Codable, Identifiable {
        
        public var id: UInt64 { return number }

        public let number: UInt64
        public let decimal: String
        public let degree: String
        public let name: String
        public let block: UInt32
        public let cycle: UInt32
        public let epoch: UInt32
        public let period: UInt32
        public let offset: UInt64
        public let rarity: String
        public let percentile: String
        public let satpoint: String?
        public let timestamp: Date
        public let inscriptions: [String]
        
    }
    
    struct Output: Codable {
        
        public let value: UInt64
        public let scriptPubkey: String
        public let address: String?
        public let transaction: String
        public let satRanges: [[UInt64]]?
        public let inscriptions: [String]
        // public let runes: // TODO: Runes??
        
    }
    
}

public extension OrdKit.API.Recursive {
    
    struct Children: Codable {
        
        public let ids: [String]
        public let more: Bool
        public let page: Int
        
    }
    
    struct Metadata {
        public let hex: String
        public let decoded: [String: Any]?
    }
    
    struct Sat: Codable {
        
        public let ids: [String]
        public let more: Bool
        public let page: Int
        
    }
    
    struct InscriptionIdAtSatIndex: Codable {
        public let id: String
    }
    
}
