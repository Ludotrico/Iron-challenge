//
//  Cache.swift
//  Terra
//
//  Created by Ludovico Veniani on 2/1/22.
//

import Foundation
import Cache


enum ExpiryTimeType: TimeInterval {
    case high = 43_200 //60*60*12  12 hours
    case med = 300 //60*5 5 min
    case low = 60 //60 1 min
}

protocol CacheablePreparation {
    func prepareForCache()
}

typealias Cacheable = Codable & Hashable & CacheablePreparation



class CacheManager {
    struct Config {
        static let memoryConfig = MemoryConfig(expiry: .never, countLimit: 0, totalCostLimit: 0)
        static let diskConfig = DiskConfig(name: "Disk", expiry: .never, maxSize: CacheManager.Maximum.diskSize, directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("TerraCache"))
    }
    
    struct Maximum {
        static let diskSize: UInt = 10_000_000
    }
    
    enum Key: Int {
        case liftLogs

        var str: String {
            switch self {
            case .liftLogs:
                return "liftLogs"
            }
        }
    }
    
    
    static private let storage = try? DiskStorage<String, Data>(config: CacheManager.Config.diskConfig, transformer: TransformerFactory.forCodable(ofType: Data.self))
    
    
    static public func insertObject<T: Cacheable>(_ object: T?=nil, objects: [T]?=nil, for key: Key, expiryTimeType: ExpiryTimeType?, completion: ((Bool) -> Void)?=nil) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            object?.prepareForCache()
            objects?.prepareForCache()
            
            
            var data: Data!
            if let object = object {
                data = try? JSONEncoder().encode(object)
            } else {
                data = try? JSONEncoder().encode(objects!)
            }
            
            
            var expiry: Expiry = .never
            if let expiryTimeType = expiryTimeType {
                expiry = .seconds(expiryTimeType.rawValue)
            }
            
            var success = true
            do {
                try Self.storage?.setObject(data, forKey: key.str, expiry: expiry)
            } catch  {
                success = false
                print(error as? StorageError)
            }
            completion?(success)
            
        }
    }
    
    
    static public func getObject<T: Cacheable>(key: Key, queue: DispatchQueue = .main, completion: @escaping (T?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if let data = try Self.storage?.object(forKey: key.str) {
                    queue.async {
                        completion(try? JSONDecoder().decode(T.self, from: data))
                    }
                } else {
                    queue.async {
                        completion(nil)
                    }
                }
            } catch {
                print("DEBUG: \(error as? StorageError)")
                queue.async {
                    completion(nil)
                }
            }
        }
    }
    
    static public func getObjects<T: Cacheable>(key: Key, queue: DispatchQueue = .main,  completion: @escaping ([T]?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if let data = try Self.storage?.object(forKey: key.str) {
                    queue.async {
                        completion(try? JSONDecoder().decode([T].self, from: data))
                    }
                } else {
                    queue.async {
                        completion(nil)
                    }
                }
            } catch {
                print("DEBUG: \(error as? StorageError)")
                queue.async {
                    completion(nil)
                }
            }
        }
    }
    
    
    static public func removeObject(key: Key) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try Self.storage?.removeObject(forKey: key.str)
            } catch {
                print("DEBUG: \(error as? StorageError)")
            }
        }
    }
    
    
}





extension CacheManager {
    static func areEqual<I: Equatable>(_ thing1: I, _ thing2: I) -> Bool {
        return thing1 == thing2
    }
}

extension Array: CacheablePreparation {
    func prepareForCache() {
        self.forEach {($0 as? CacheablePreparation)?.prepareForCache() }
    }
}
