//
//  CBORInputStream.swift
//
//
//  File created by Jacob Davis on 1/29/24.
//  CBOR Implementation copied from https://github.com/valpackett/SwiftCBOR
//
//  LICENSE: This is free and unencumbered software released into the public domain.
//  For more information, please refer to the UNLICENSE file or unlicense.org
//

public protocol CBORInputStream {
    mutating func popByte() throws -> UInt8
    mutating func popBytes(_ n: Int) throws -> ArraySlice<UInt8>
}

// https://openradar.appspot.com/23255436
struct ArraySliceUInt8 {
    var slice : ArraySlice<UInt8>
}

struct ArrayUInt8 {
    var array : ArraySlice<UInt8>
}

extension ArraySliceUInt8: CBORInputStream {
    mutating func popByte() throws -> UInt8 {
        if slice.count < 1 { throw CBORError.unfinishedSequence }
        return slice.removeFirst()
    }

    mutating func popBytes(_ n: Int) throws -> ArraySlice<UInt8> {
        if slice.count < n { throw CBORError.unfinishedSequence }
        let result = slice.prefix(n)
        slice = slice.dropFirst(n)
        return result
    }
}

extension ArrayUInt8: CBORInputStream {
    mutating func popByte() throws -> UInt8 {
        guard array.count > 0 else { throw CBORError.unfinishedSequence }
        return array.removeFirst()
    }

    mutating func popBytes(_ n: Int) throws -> ArraySlice<UInt8> {
        guard array.count >= n else { throw CBORError.unfinishedSequence }
        let res = array.prefix(n)
        array = array.dropFirst(n)
        return res
    }
}
