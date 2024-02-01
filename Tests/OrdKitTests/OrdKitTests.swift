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
    
    func testInscriptionsByIdArray() async throws {
        let ids = ["0ef5b1f14b603688a06f86a20ba67e03236ccb678085d7f44f78f0a707961b89i0","02fe22c9103ea6a3ee79f74125cf5ee9d2f1d1bc889e6c170899be2125e71707i0","16e5bd195eeed008eac42ca7337f0ba3bd80eb7d78a98fc58120812c8bc2f97di0","0ade3395462b2dfbe23a3759cd97c93b3aebe3c5b86d58acbbcd02b082745c58i0","0e7de6f25b15425c8e02a9de4dd48ab52f6250e566a9b7ba928bd228e885c2dei0","c315080f88e6e7fe5bec2d7600197a14c027db8bbabc2836675d1bf66383b429i0"]
        
        do {
            let result = try await OrdKit.API.Inscriptions.fetchInscriptions(withIds: ids)
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
