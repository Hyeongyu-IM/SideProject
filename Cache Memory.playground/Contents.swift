import UIKit

// Memory Cache
final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    
    init(dateProvider: @escaping () -> Date = Date.init,
        entryLifetime: TimeInterval = 12 * 60 * 60) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
    }
    
        // 캐시에(임시) 값을 세팅합니다
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

        // 저장된 캐시값이 있는지 탐색합니다 (옵셔널 )
        // 여기서의 object메서드가 어디에 있는지 궁금했는데 이것은 NSCache의 기본 메서드로 KeyType을 받아 ObjectType?을 리턴합니다 따라서 파라미터로 전달된 키가 wrapped안에 있다면 저장된 ObjectType(저장된 캐시)가 리턴됩니다.
        func value(forKey key: Key) -> Value? {
            guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
                 return nil
             }
            guard dateProvider() < entry.expirationDate else {
                 removeValue(forKey: key)
                 return nil
             }
              return entry.value
         }
    
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
        let value: Value
        let expirationDate: Date

        init(value: Value, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}

// 캐시에 subscript를 추가해줍니다. 쉽게찾을수 있습니다.
extension Cache {
    subscript(key: Key) -> Value? {
        // get은 value메서드를 이용해서 key값을 탐색하고 밸류를 리턴해줍니다.
        get { return value(forKey: key) }
        set {
            // set은 해당 키
            guard let value = newValue else {
                // 만약 해당 키의 자리에 nil이 할당되면 해당 캐시를 삭제합니다.
                removeValue(forKey: key)
                return
            }
            // 만약 해당 키의 자리에 새로운 값이 있다면 새로운 값을 넣어줍니다.
            insert(value, forKey: key)
        }
    }
}
//let date: Date = Date.init()
//let a: TimeInterval = 12 * 60 * 60
//
//let c = date.addingTimeInterval(a)
//print("a입니다 \(a) date입니다 \(date)")
//print(c)
