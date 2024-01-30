import Foundation

public struct OrdKit {
    
    public static var baseURL: URL?
    private static let session = URLSession.shared
    
    public static func set(baseURL with: String) {
        baseURL = URL(string: with)
    }
    
    public struct API {
        
        public static func getBlock(height: UInt32) async throws -> API.Block {
            return try await fetch(path: "block/\(height)")
        }
        
        public static func getBlockCount() async throws -> API.BlockCount {
            return try await fetch(path: "blockcount")
        }
        
        public static func getInscription(id: String?, number: Int32? = nil) async throws -> API.Inscription {
            
            if let id {
                return try await fetch(path: "inscription/\(id)")
            } else if let number {
                return try await fetch(path: "inscription/\(number)")
            }
            
            throw OrdKitError.invalidParameters
        }
        
        public static func getSat(number: UInt64) async throws -> API.Sat {
            return try await fetch(path: "sat/\(number)")
        }
        
        public static func getInscriptions(page: Int = 0, block: UInt32? = nil) async throws -> API.Inscriptions {
            if let block {
                return try await fetch(path: "inscriptions/block/\(block)/\(page)")
            }
            return try await fetch(path: "inscriptions/\(page)")
        }
        
        public static func getOutput(outpoint: String) async throws -> API.Output {
            return try await fetch(path: "output/\(outpoint)")
        }
        
        // MARK: Recursive
        public struct Recursive {
            
            public static func getBlockHash(height: UInt32? = nil) async throws -> API.BlockHash {
                return try await fetch(path: "r/blockhash")
            }
            
            public static func getBlockHeight() async throws -> API.BlockHeight {
                return try await fetch(path: "r/blockheight")
            }
            
            public static func getBlockTime() async throws -> API.BlockTime {
                return try await fetch(path: "r/blocktime")
            }
            
            public static func getChildren(id: String, page: Int = 0) async throws -> API.Recursive.Children {
                return try await fetch(path: "r/children/\(id)/\(page)")
            }
            
            public static func getMetadata(id: String) async throws -> API.Recursive.Metadata {
                do {
                    var decoded: [String: Any]?
                    let hex: String = try await fetch(path: "r/metadata/\(id)")
                    if let cbor = try? CBOR.decode(hex.bytesFromHex) {
                        switch cbor {
                            case .map(let dict):
                                decoded = try? CBOR.convertCBORMapToDictionary(dict)
                            default: break
                        }
                    }
                    return Metadata(hex: hex, decoded: decoded)
                } catch {
                    throw OrdKitError.cannotDecodeResponse
                }
            }
            
            public static func getSat(number: UInt64, page: Int = 0) async throws -> API.Recursive.Sat {
                return try await fetch(path: "r/sat/\(number)/\(page)")
            }
            
            public static func getInscriptionIdAtSatIndex(number: UInt64, index: Int) async throws -> API.Recursive.InscriptionIdAtSatIndex {
                return try await fetch(path: "r/sat/\(number)/at/\(index)")
            }
        }
    }
    
    private static func fetch<T: Decodable>(path: String) async throws -> T {
        guard let url = baseURL else { throw OrdKitError.invalidBaseURL }
        var req = URLRequest(url: url.appending(path: path))
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let (data, _) = try await OrdKit.session.data(for: req)
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
            throw error
        }
    }
    
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
    public enum OrdKitError: LocalizedError {
        
        case invalidBaseURL
        case invalidParameters
        case cannotDecodeResponse
        
        public var errorDescription: String? {
            switch self {
                case .invalidBaseURL:
                    return "Invalid baseURL. Set by calling OrdKit.set(baseURL: <json enabled ord server url>)"
                case .cannotDecodeResponse:
                    return "There was an issue decoding response"
                case .invalidParameters:
                    return "One or more paramenters not valid"
            }
        }
        
    }
    
}
