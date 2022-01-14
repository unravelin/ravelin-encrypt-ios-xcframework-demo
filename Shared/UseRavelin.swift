import RavelinCore
import RavelinEncrypt

struct UseRavelin {
    var core : Ravelin
    var encrypt: RVNEncryption

    init(apiKey: String, rsaKey: String) {
        core = Ravelin.createInstance(apiKey, enableRetry: false)
        encrypt = RVNEncryption.sharedInstance()
        encrypt.rsaKey = rsaKey
    }
    
    func useCore() {
        // Setup customer info and track their login
        core.customerId = "customer0123"
        core.orderId = "web-001"

        core.trackLogin("loginPage")

        // Track customer moving to a new page
        core.trackPage("checkout")

        // Send a device fingerprint with a completion block (if required)
        core.trackFingerprint { (data, response, error) -> Void in
            if let error = error {
                // Handle error
                print("Ravelin error \(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse {
                print("trackFingerprint: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 200 {
                    print("success")
                    print("deviceId: ", self.core.deviceId)
                }
            }
        }

        // Track a customer logout
        core.trackLogout("logoutPage")
    }
    
    func useEncrypt() {
        // Encrypt customer card details, ready for sending for payment
        var error:NSError? = nil
        let encryptionPayload = encrypt.encrypt("41111111111111", month: "10", year: "23", nameOnCard: "Mr John Doe", error: &error)
        if let error = error {
            print("Ravelin encryption error \(error.localizedDescription)")
        } else {
            print("Ravelin Encryption payload: \(encryptionPayload as AnyObject)")
            // Send to server
        }
    }
}
