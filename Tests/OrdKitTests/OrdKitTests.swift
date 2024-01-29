import XCTest
@testable import OrdKit

final class OrdKitTests: XCTestCase {
    
    override class func setUp() {
        OrdKit.set(baseURL: "") // Your ord server url here
    }
    
    func testBlock() async throws {
        do {
            let result = try await OrdKit.API.getBlock(height: 820000)
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testBlockCount() async throws {
        do {
            let result = try await OrdKit.API.getBlockCount()
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInscriptionNumber() async throws {
        do {
            let result = try await OrdKit.API.getInscription(id: nil, number: 1)
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInscriptionId() async throws {
        do {
            let result = try await OrdKit.API.getInscription(id: "025107e06ac442f014c09a73cd97372f69619edd00dbeacca0aac55c75efe3ffi0", number: nil)
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInscriptions() async throws {
        do {
            let result = try await OrdKit.API.getInscriptions()
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInscriptionsByBlock() async throws {
        do {
            let result = try await OrdKit.API.getInscriptions(block: 820000)
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSat() async throws {
        do {
            let result = try await OrdKit.API.getSat(number: 727624168684699)
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOutput() async throws {
        do {
            let result = try await OrdKit.API.getOutput(outpoint: "bc4c30829a9564c0d58e6287195622b53ced54a25711d1b86be7cd3a70ef61ed:0")
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testBlockHashRecursive() async throws {
        do {
            let result = try await OrdKit.API.Recursive.getBlockHash()
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testBlockHashWithHeightRecursive() async throws {
        do {
            let result = try await OrdKit.API.Recursive.getBlockHash(height: 820000)
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testBlockHeightRecursive() async throws {
        do {
            let result = try await OrdKit.API.Recursive.getBlockHeight()
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testBlockTimeRecursive() async throws {
        do {
            let result = try await OrdKit.API.Recursive.getBlockTime()
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testChildrenRecursive() async throws {
        do {
            let result = try await OrdKit.API.Recursive.getChildren(id: "025107e06ac442f014c09a73cd97372f69619edd00dbeacca0aac55c75efe3ffi0")
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testMetadataRecursive() async throws {
        do {
            let result = try await OrdKit.API.Recursive.getMetadata(id: "35b66389b44535861c44b2b18ed602997ee11db9a30d384ae89630c9fc6f011fi3")
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSatRecursive() async throws {
        do {
            let result = try await OrdKit.API.Recursive.getSat(number: 1023795949035695)
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInscriptionIdAtSatIndexRecursive() async throws {
        do {
            let result = try await OrdKit.API.Recursive.getInscriptionIdAtSatIndex(number: 1023795949035695, index: -1)
            XCTAssertNotNil(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
