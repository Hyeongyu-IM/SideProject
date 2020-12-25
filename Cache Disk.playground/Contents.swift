import UIKit

final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    private let keyTracker = KeyTracker()

        init(dateProvider: @escaping () -> Date = Date.init,
             entryLifetime: TimeInterval = 12 * 60 * 60,
             maximumEntryCount: Int = 50) {
            self.dateProvider = dateProvider
            self.entryLifetime = entryLifetime
            wrapped.countLimit = maximumEntryCount
            wrapped.delegate = keyTracker
        }

    func insert(_ entry: Entry) {
        keyTracker.keys.insert(entry.key)
        wrapped.setObject(entry, forKey: WrappedKey(entry.key))
    }
//         저장된 캐시값이 있는지 탐색합니다 (옵셔널 )
//         여기서의 object메서드가 어디에 있는지 궁금했는데 이것은 NSCache의 기본 메서드로 KeyType을 받아 ObjectType?을 리턴합니다 따라서 파라미터로 전달된 키가 wrapped안에 있다면 저장된 ObjectType(저장된 캐시)가 리턴됩니다.
        // 값을 제거
        func removeValue(forKey key: Key) {
            wrapped.removeObject(forKey: WrappedKey(key))
        }
    
    // NSObjct클래스의 키값입니다.
    final class WrappedKey: NSObject {
        let key: Key
        init(_ key: Key) { self.key = key }
        override var hash: Int { return key.hashValue }
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
    // Value로 들어오는 오브젝트는 AnyObject Type으로 들어오는 타입이 밸류의 타입이 됩니다.
    final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date

        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
    
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys = Set<Key>()
        func cache(_ cache: NSCache<AnyObject, AnyObject>,
                   willEvictObject object: Any) {
            guard let entry = object as? Entry else {
                return
            }
            keys.remove(entry.key)
        }
    }
    
    func entry(forKey key: Key) -> Entry? {
            guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
                return nil
            }
            guard dateProvider() < entry.expirationDate else {
                removeValue(forKey: key)
                return nil
            }
            return entry
        }
}


extension Cache: Codable where Key: Codable, Value: Codable {
    convenience init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach(insert)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(entry))
    }
}

extension Cache where Key: Codable, Value: Codable {
    func saveToDisk(
        withName name: String,
        using fileManager: FileManager = .default
    ) throws {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )

        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
}

