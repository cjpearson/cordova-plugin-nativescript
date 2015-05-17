//
//  TNSPlugin.h
//
//  Created by Connor Pearson on 5/14/15.
//
//

#import <Cordova/CDV.h>

@interface TNSPlugin : CDVPlugin

- (void)evaluateNativeScript:(CDVInvokedUrlCommand*)command;

@end
