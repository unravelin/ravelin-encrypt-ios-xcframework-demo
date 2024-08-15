//
//  ViewController.m
//  RavelinEncryptDemoPodsObjC

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <RavelinEncrypt/RavelinEncrypt.h>

@interface ViewController ()
@property (strong, nonatomic) RVNEncryption *ravelinEncrypt;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self useEncrypt];
}

- (void)useEncrypt {
    // Make RavelinEncrypt instance with rsa key
    self.ravelinEncrypt = [RVNEncryption sharedInstance];
    self.ravelinEncrypt.rsaKey = @"----|---------";
    
    // Encrypt customer card details, ready for sending for payment
    NSError *error;
    NSDictionary *encryptionPayload = [self.ravelinEncrypt encrypt:@"41111111111111" month:@"10" year:@"27" nameOnCard:@"Mr John Doe" error:&error];
    if(!error) {
        NSLog(@"Ravelin Encryption payload: %@", encryptionPayload);
    } else {
        NSLog(@"Ravelin encryption error %@", error.localizedDescription);
    }
}

@end
