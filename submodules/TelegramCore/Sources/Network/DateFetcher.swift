import SwiftSignalKit
import Foundation

public enum DateFetcher {
    static public func fetchDate() -> Signal<Int32, NoError> {
        let url = URL(string: "http://worldtimeapi.org/api/timezone/Europe/Moscow")!
        
        return Signal { subscriber in
            let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data, let time = try? JSONDecoder().decode(Response.self, from: data).unixtime {
                    subscriber.putNext(time)
                }
            }
            dataTask.resume()
            
            return ActionDisposable { }
        }
    }
    
    struct Response: Decodable {
        let unixtime: Int32
    }
}


