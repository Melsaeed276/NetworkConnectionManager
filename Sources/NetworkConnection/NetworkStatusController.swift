//
//  NetworkMonitor.swift
//  NetworkManager
//
//  Created by Mohamed Elsaeed on 22.05.2024.
//

import Foundation
import Network
import Combine


/// The delegate protocol for handling internet connection status changes.
///
/// Implement this protocol to receive updates about the internet connection status and quality.
///
/// Example usage:
/// ```swift
/// class YourViewController: UIViewController, InternetConnectionDelegate {
///
///     override func viewDidLoad() {
///         super.viewDidLoad()
///         NetworkStatusController.shared.addDelegate(self)
///     }
///
///     func internetConnectionStatusDidChange(connected: Bool) {
///         print("Connected: \(connected)")
///     }
///
///     func internetConnectionQualityDidChange(quality: NetworkStatusController.ConnectionQuality) {
///         print("Connection Quality: \(quality)")
///     }
/// }
/// ```
///
public protocol InternetConnectionDelegate: AnyObject {
    
    /// Notifies the delegate when the internet connection status changes.
    ///
    /// - Parameter connected: A boolean value indicating whether the device is connected to the internet.
    ///
    /// Example usage:
    /// ```swift
    ///
    ///class YourViewController: UIViewController, InternetConnectionDelegate {
    ///
    /// ///  ... your code
    ///
    ///     func internetConnectionStatusDidChange(connected: Bool) {
    ///         print("Connected: \(connected)")
    ///         // you can add some actions that will act when the connection is gone
    ///     }
    /// ///  ... your code
    /// }
    /// ```
    ///
    func internetConnectionStatusDidChange(connected: Bool)
    
    /// Notifies the delegate when the internet connection quality changes.
    ///
    /// - Parameter quality: An enum indicating the quality of the internet connection.
    /// # Quality enum output is one of these:
    /// - - good
    /// - - poor
    /// - - bad
    /// -   none
    ///
    /// Example usage:
    /// ```swift
    ///
    ///class YourViewController: UIViewController, InternetConnectionDelegate {
    ///
    /// ///  ... your code
    ///
    ///   func internetConnectionQualityDidChange(quality:NetworkStatusController.ConnectionQuality) {
    ///         print("Connection Quality: \(quality)")
    ///          // you can add some actions that will act when the quality is changed
    ///     }
    /// ///  ... your code
    /// }
    /// ```
    ///
    func internetConnectionQualityDidChange(quality: NetworkStatusController.ConnectionQuality)
}



/// A singleton class that monitors network status and notifies delegates about connection status and quality changes.
public class NetworkStatusController: ObservableObject {
    public static let shared = NetworkStatusController()
    
  
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published public var isEnable: Bool = true 
    
    @Published public private(set) var isConnected = false
    @Published public private(set) var isExpensive = false
    @Published public private(set) var connectionQuality = ConnectionQuality.none
    
    /// Enum representing the quality of the internet connection.
    public enum ConnectionQuality {
        case good
        case poor
        case bad
        case none
        
        public var description: String {
            switch self {
            case .good:
                return "Internet Connection Quality: Good"
            case .poor:
                return "Internet Connection Quality: Poor"
            case .bad:
                return "Internet Connection Quality: Bad"
            case .none:
                return "Internet Connection Quality: None"
            }
        }
    }
    
    private var statusChangeHandler: ((Bool, Bool) -> Void)?
    
    
    /**
     A manager class for handling internext connections.
     
     This class manages a collection of delegates using a weak reference to avoid retain cycles.
     */
    private var delegates = NSHashTable<AnyObject>.weakObjects()
    
    
    /// Adds a delegate to the InternetConnectionManager.
    ///
    /// - Parameter delegate: The delegate to be added.
    /// Example usage:
    /// ```swift
    ///
    ///class YourViewController: UIViewController, InternetConnectionDelegate {
    ///
    /// ///  ... your code
    ///
    ///    override func viewDidLoad() {
    ///         super.viewDidLoad()
    ///         NetworkStatusController.shared.addDelegate(self)
    ///          ///  ... rest of your code
    ///     }
    ///
    /// ///  ... your code
    /// }
    /// ```
    public func addDelegate(_ delegate: InternetConnectionDelegate) {
        delegates.add(delegate)
    }
    
    /// Removes a delegate from the InternetConnectionManager.
    ///
    /// - Parameter delegate: The delegate to be removed.
    /// Example usage:
    /// ```swift
    ///
    ///class YourViewController: UIViewController, InternetConnectionDelegate {
    ///
    /// ///  ... your code
    ///
    ///   override func viewWillDisappear(_ animated: Bool) {
    ///        super.viewWillDisappear(animated)
    ///        NetworkStatusController.shared.removeDelegate(self)
    ///          ///  ... rest of your code
    ///     }
    ///
    /// ///  ... your code
    /// }
    /// ```
    public func removeDelegate(_ delegate: InternetConnectionDelegate) {
        delegates.remove(delegate)
    }
    
    
    private init() {
        
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                let connected = path.status == .satisfied
                let expensive = path.isExpensive
                
                if connected {

                    // Check for actual internet connectivity
                    self?.checkInternetConnection(isReachable: connected) { isConnected, quality in
                        self?.isConnected = isConnected
                        self?.isExpensive = expensive
                        self?.connectionQuality = quality
                        self?.notifyDelegates(connected: isConnected, quality: quality)
                        self?.statusChangeHandler?(isConnected, expensive)
                    }
                } else {
                    self?.notifyDelegates(connected: connected, quality: .none)
                    self?.statusChangeHandler?(connected, expensive)
                }
            }
        }
        monitor.start(queue: queue)
        
    }
    
    private func checkInternetConnection(isReachable: Bool, completion: @escaping (Bool, ConnectionQuality) -> Void) {
        
        
        // Check if the network check is enabled
        if isEnable == false  {
            isConnected = true // Set isConnected to true directly
            connectionQuality = .none
            isExpensive = false
            
            completion(true, .good) // Return a successful connection if disabled
            return
        }
        
        if isReachable == false {
            completion(false, .none) // No network, definitely no internet
            return
        }
        
        // Simple ping-like check
        let url = URL(string: "https://www.apple.com")! // Replace with a reliable URL
        let request = URLRequest(url: url, timeoutInterval: 3) // 3-second timeout
        
        let startTime = Date()
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async(qos: .background) {
                if let httpResponse = response as? HTTPURLResponse,
                   200..<300 ~= httpResponse.statusCode {
                    let duration = Date().timeIntervalSince(startTime)
                    
                    print("duration: \(duration)")
                    let quality: ConnectionQuality
                    if duration < 1.2 {
                        quality = .good
                        completion(true, quality) // Successful response means internet is available
                    } else if duration < 3 {
                        quality = .poor
                        completion(true, quality) // Successful response means internet is available
                    } else if duration > 3{
                        quality = .bad
                        completion(false, quality) // response means internet is not available
                    }else {
                        quality = .none
                        completion(false, quality) // response means internet is not  available
                    }
                } else {
                    completion(false, .none)
                }
            }
        }
        task.resume()
    }
    
    /**
     Sets a handler to be called whenever the network status changes.

     This method allows you to specify a custom handler that will be invoked with the current internet connection status and whether the connection is considered expensive. The handler is called whenever the network status changes, providing a convenient way to react to network changes within your application.

     - Parameter handler: A closure that takes two Boolean parameters:
       - `isConnected`: A Boolean value indicating whether the device is connected to the internet.
       - `isExpensive`: A Boolean value indicating whether the internet connection is considered expensive (e.g., cellular data).

     - Note: The handler will be stored and called whenever the network status changes. Use this method to perform custom actions in response to network status updates.

     Here's an example of how to use this method:

     ```swift
     NetworkStatusController.shared.setStatusChangeHandler { isConnected, isExpensive in
         if isConnected {
             print("Connected to the internet")
         } else {
             print("No internet connection")
         }

         if isExpensive {
             print("The connection is expensive (e.g., cellular data)")
         }
     }
     */
    public func setStatusChangeHandler(_ handler: @escaping (Bool, Bool) -> Void) {
        self.statusChangeHandler = handler
    }
    
    
    private func notifyDelegates(connected: Bool, quality: ConnectionQuality) {
        delegates.allObjects.forEach { (object) in
            guard let delegate = object as? InternetConnectionDelegate else { return }
            delegate.internetConnectionStatusDidChange(connected: connected)
            delegate.internetConnectionQualityDidChange(quality: quality)
        }
    }
    
    deinit {
        monitor.cancel()
    }
}


/// Notification Center for the Network changes
public extension Notification.Name {
    static let networkStatusChanged = Notification.Name("networkStatusChanged")
    
    //NotificationCenter.default.post(name: .networkStatusChanged, object: nil)

    //NotificationCenter.default.addObserver(self, selector: #selector(handleNetworkStatusChanged), name: .networkStatusChanged, object: nil)
}
