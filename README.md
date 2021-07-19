# How to use RavelinEncrypt

## Contents

* [Building and Installation](#building-and-installation)
* [Usage](#usage)
* [Examples](#end-to-end-example)
* [Class Reference](#ravelin-class-reference)
* [License](#license)

## Building and Installation

### Installing the Ravelin Mobile SDK via Cocoapods

Add RavelinEncrypt to your PodFile: 
```ruby
pod 'RavelinEncrypt', '1.1.0', :source => 'https://github.com/unravelin/Specs.git'
```
then, from the command line: `pod install`

### Installing the Ravelin Mobile SDK via Swift Package Manager(SPM)

Add RavelinEncrypt via Xcode, Add Package Dependency:
a package manifest is available at:
'git@github.com:unravelin/ravelin-encrypt-ios-xcframework-distribution.git'

available from version 1.1.0

<img width="487" alt="RavelinCore-SPM" src="https://user-images.githubusercontent.com/729131/121674900-8cc67700-caaa-11eb-8b07-00a3876ec133.png">

## Usage

To use the framework within your project, import RavelinEncrypt where required:

This repo provides three simple projects, showing the integration and usage of RavelinEncrypt:
* Swift using SPM
* Swift using Cocoapods
* Objective-C using Cocoapods

#### Objective-C
```objc
#import <RavelinEncrypt/RavelinEncrypt.h>
```

#### Swift
```swift
import RavelinEncrypt
```

The singleton RVNEncryption class should be access via the sharedInstance method. You must then provide your RSA key for card encryption.

#### Objective-C
```objc
// Instantiation for encryption
self.ravelinEncrypt = [RVNEncryption sharedInstance];
self.ravelinEncrypt.rsaKey = @"----|----";
```

#### Swift
```swift

// Instantiation for encryption
let ravelinEncrypt = RVNEncryption.sharedInstance()
ravelinEncrypt.rsaKey = "----|----"
```

Once initialised, you can use the sharedInstance directly to access methods and properties

#### Objective-C
```objc

// Directly
[[RVNEncryption sharedInstance]] methodName];

// Variable
RVNEncryption *ravelinEncrypt = [RVNEncryption sharedInstance];

```

#### Swift
```swift

// Directly
RVNEncryption.sharedInstance().methodName()

// Variable
let ravelinEncrypt = RVNEncryption.sharedInstance()
```

### Encrypting Cards

The SDK can be used to allow the secure sharing of card information with Ravelin whilst removing the need to handle PCI-compliant data.

When collecting the card details, we encrypt the values to send using the code method below. Validation is performed, confirming that expiry dates are valid and that the PAN is at least 13 characters. Should any validation checks fail, `nil` is returned from the method. Pass an error by ref to determine the cause of failure if any occurs.

#### Objective-C
```objc
// Card details
NSString *pan = @"41111111111111";
NSString *month = @"10";
NSString *year = @"2022";
NSString *cardHolder = @"Mr John Doe";

// Error handling
NSError *error;

// Encrypt
NSDictionary *encryptionPayload = [[RVNEncryption sharedInstance] encrypt:pan month:month year:year nameOnCard:cardHolder error:&error];

if(!error) {
    NSLog(@"Ravelin encryption payload: %@",encryptionPayload);
    // Send to your servers

} else {
    NSLog(@"Ravelin encryption error %@", error.localizedDescription);
}
```

#### Swift
```swift
var error:NSError? = nil

let encryptionPayload = RVNEncryption.sharedInstance().encrypt("41111111111111", month: "10", year: "10", nameOnCard: "Mr John Doe", error: &error)

if let error = error {
    print("Ravelin encryption error \(error.localizedDescription)")
} else {
    print("Ravelin Encryption payload: \(encryptionPayload as AnyObject)")
    // Send to your servers
}
```

## End to end example

What follows is a simple end-to-end example of using the Ravelin Framework within a View.

#### Objective-C
```objc
#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <RavelinEncrypt/RavelinEncrypt.h>
@interface ViewController ()
@property (strong, nonatomic) RVNEncryption *ravelinEncrypt;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Make RavelinEncrypt instance with rsa key
    self.ravelinEncrypt = [RVNEncryption sharedInstance];
    self.ravelinEncrypt.rsaKey = @"----|----";

    // Encrypt customer card details, ready for sending for payment
    NSError *error;
    NSDictionary *encryptionPayload = [self.ravelinEncrypt encrypt:@"41111111111111" month:@"10" year:@"20" nameOnCard:@"Mr John Doe" error:&error];
    if(!error) {
        NSLog(@"Ravelin Encryption payload: %@", encryptionPayload);
    } else {
        NSLog(@"Ravelin encryption error %@", error.localizedDescription);
    }
}
@end
```

#### Swift

```swift
import UIKit
import RavelinEncrypt

class ViewController: UIViewController {

    private var ravelinEncrypt = RVNEncryption.sharedInstance()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up ravelin encryption RSA key
        
        ravelinEncrypt.rsaKey = "----|----"
        
        // Encrypt customer card details, ready for sending for payment
        var error:NSError? = nil
        let encryptionPayload = ravelinEncrypt.encrypt("41111111111111", month: "10", year: "20", nameOnCard: "Mr John Doe", error: &error)
        if let error = error {
            print("Ravelin encryption error \(error.localizedDescription)")
        } else {
            print("Ravelin Encryption payload: \(encryptionPayload as AnyObject)")
            // Send to server
        }
    }
}
```

## RVNEncryption Class Reference

### RVNEncryption Class Methods

---

### sharedInstance

Get the instantiated RVNEncryption singleton


**Return value**

The singleton instance of the class

---

### encrypt (pan, month, year, nameOnCard, &error)

Generates encryption payload ready for sending to Ravelin

**Parameters**

| Parameter     | Type               | Description  |
| ------------- |---------------------|-------|
| pan     | String     | A string representation of the long card number |
| month     | String     | Expiry month of card (1-12) |
| year     | String     | Expiry year (2 or 4 digit) |
| nameOnCard     | String     | The customer name on the card |
| error     | Object     | Passed as reference |

**Return value**

Dictionary containing methodType, aesKeyCiphertext, cardCiphertext, algorithm, keyIndex and ravelinSDKVersion

--- 

### RVNEncryption Class Properties

---

#### rsaKey

The public RSA key from your dashboard


# License

License information can be found [here](https://github.com/unravelin/ravelin-ios/blob/1.0.2-docs/LICENSE)
