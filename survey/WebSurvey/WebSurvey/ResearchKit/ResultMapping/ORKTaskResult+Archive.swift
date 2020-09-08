//
//  ORKTaskResult+Archive.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 26.07.20.
//

import Foundation
import ResearchKit
import SWCompression
import Compression

extension ORKTaskResult {
    func archive(deleteOriginal: Bool) throws -> URL {
        var archiveEntries: [TarEntry] = []
        let mtimeDate = Date(timeIntervalSinceNow: 0.0)
        
        // Include any file results
        if outputDirectory != nil {
            let fileResults = collectFileResults(from: self)
            
            let tarEntries: [TarEntry] = fileResults.compactMap { fileResult in
                guard let url = fileResult.fileURL, let data = try? Data(contentsOf: url) else {
                    return nil
                }
                
                var info = TarEntryInfo(name: url.lastPathComponent, type: .regular)
                info.creationTime = mtimeDate
                info.permissions = Permissions(rawValue: 420)
                return TarEntry(info: info, data: data)
            }
            
            archiveEntries.append(contentsOf: tarEntries)
        }
        
        // Include serialized metadata
        var metadataInfo = TarEntryInfo(name: "results.json", type: .regular)
        metadataInfo.creationTime = mtimeDate
        metadataInfo.permissions = Permissions(rawValue: 420)
        var metadataError: Error? = nil
        do {
            let metadata = try ORKESerializer.jsonData(for: self)
            archiveEntries.append(TarEntry(info: metadataInfo, data: metadata))
        } catch {
            metadataError = error
        }
        
        // Create tarball
        let tarball = try TarContainer.create(from: archiveEntries)
        
        // Write archive to disk
        let output = getDocumentsDirectory().appendingPathComponent("WebSurvey-\(taskRunUUID.uuidString).tar")
        try tarball.write(to: output)
        
        // Clean up temporary files
        if deleteOriginal, let outputDirectory = self.outputDirectory {
            try FileManager.default.removeItem(at: outputDirectory)
        }
        
        // Throw if the metadata saving failed
        if let error = metadataError {
            throw error
        } else {
            return output
        }
    }
}

class FileHelper {
    // Returns the size of a file, in bytes, at the specified URL.
    static func fileSize(atURL url: URL) -> UInt64? {
        let attributesOfItem = try? FileManager.default.attributesOfItem(atPath: url.path)
        let sourceLength = (attributesOfItem as NSDictionary?)?.fileSize()
        
        return sourceLength
    }
}

fileprivate func collectFileResults(from collectionResult: ORKCollectionResult) -> [ORKFileResult] {
    return collectionResult.results?
        .compactMap { (result: ORKResult) -> [ORKFileResult] in
            if let childCollection = result as? ORKCollectionResult {
                return collectFileResults(from: childCollection)
            } else if let fileResult = result as? ORKFileResult {
                return [fileResult]
            } else {
                return []
            }
        }
        .flatMap { $0 } ?? []
}
