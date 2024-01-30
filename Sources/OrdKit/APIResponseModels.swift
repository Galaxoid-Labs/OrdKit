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
        
        public enum MediaCode: Codable, Equatable {
            case json, js, yaml, css, python
        }
        
        public enum MediaImage: Codable, Equatable {
            case apng, avif, gif, jpeg, png, webp, svg
        }
        
        public enum MediaHtml: Codable, Equatable {
            case html
        }
        
        public enum MediaAudio: Codable, Equatable {
            case flac, mpeg, wav
        }
        
        public enum MediaFont: Codable, Equatable {
            case otf, ttf, woff, woff2
        }
        
        public enum MediaModel: Codable, Equatable {
            case gltfbin, gltfjson
        }
        
        public enum MediaType: Codable, Equatable {
            case unknown, text, markdown, video, pdf
            case image(MediaImage)
            case code(MediaCode)
            case html(MediaHtml)
            case audio(MediaAudio)
            case font(MediaFont)
            case model(MediaModel)
        }
        
        public var contentUrl: URL? {
            return OrdKit.baseURL?.appending(path: "content/\(inscriptionId)")
        }
        
        public var previewUrl: URL? {
            return OrdKit.baseURL?.appending(path: "preview/\(inscriptionId)")
        }
        
        public var mediaType: MediaType {
            guard let contentType else { return MediaType.unknown }
            switch contentType {
                case "text/plain","text/plain;charset=utf-8","application/pgp-signature":
                    return MediaType.text
                case "text/markdown","text/markdown;charset=utf-8":
                    return MediaType.markdown
                case "video/mp4","video/webm":
                    return MediaType.video
                case "application/pdf":
                    return MediaType.pdf
                case "application/json":
                    return MediaType.code(.json)
                case "application/x-javascript", "text/javascript":
                    return MediaType.code(.js)
                case "application/yaml":
                    return MediaType.code(.yaml)
                case "text/css":
                    return MediaType.code(.css)
                case "application/x-python":
                    return MediaType.code(.python)
                case "model/gltf-binary":
                    return MediaType.model(.gltfbin)
                case "model/gltf+json":
                    return MediaType.model(.gltfjson)
                case "image/apng":
                    return MediaType.image(.apng)
                case "image/avif":
                    return MediaType.image(.avif)
                case "image/gif":
                    return MediaType.image(.gif)
                case "image/jpeg":
                    return MediaType.image(.jpeg)
                case "image/png":
                    return MediaType.image(.png)
                case "image/webp":
                    return MediaType.image(.webp)
                case "image/svg+xml":
                    return MediaType.image(.svg)
                case "font/otf":
                    return MediaType.font(.otf)
                case "font/ttf":
                    return MediaType.font(.ttf)
                case "font/woff":
                    return MediaType.font(.woff)
                case "font/woff2":
                    return MediaType.font(.woff2)
                case "text/html","text/html;charset=utf-8":
                    return MediaType.html(.html)
                default:
                    return MediaType.unknown
            }
        }
        
    }
    
    struct Inscriptions: Codable {
        
        public let inscriptions: [String]
        public let more: Bool
        public let pageIndex: Int
        
        public func fetchInscriptions() async throws -> [Inscription] {
            try await withThrowingTaskGroup(of: Inscription.self) { group in
                for id in self.inscriptions {
                    group.addTask {
                        return try await OrdKit.API.getInscription(id: id)
                    }
                }
                
                var dict = [String: Inscription]()
                for try await ins in group {
                    dict[ins.inscriptionId] = ins
                }
                
                var retval = [Inscription]()
                for id in self.inscriptions {
                    if let ins = dict[id] {
                        retval.append(ins)
                    }
                }

                return retval
            }
        }
        
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
