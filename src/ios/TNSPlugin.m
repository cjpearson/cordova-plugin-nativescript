//
//  TNSPlugin.m
//
//  Created by Connor Pearson on 5/14/15.
//
//

#import "TNSPlugin.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <NativeScript/NativeScript.h>


@interface TNSPlugin ()

@property (strong, nonatomic) TNSRuntime* runtime;

@end

@implementation TNSPlugin

- (void)pluginInitialize
{
    self.runtime = [[TNSRuntime alloc] initWithApplicationPath:[[NSBundle mainBundle] bundlePath]];
}

- (void)evaluateNativeScript:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
            NSString* script = command.arguments[0];
            
            JSContextGetGlobalObject(self.runtime.globalContext);
            
            JSValueRef errorRef = NULL;
            
            JSStringRef scriptRef = JSStringCreateWithUTF8CString(script.UTF8String);
            JSObjectRef globalObjectRef = JSContextGetGlobalObject(self.runtime.globalContext);
            
            JSValueRef scriptResultRef = JSEvaluateScript(self.runtime.globalContext, scriptRef, globalObjectRef, NULL, 0, &errorRef);
            JSStringRelease(scriptRef);
            
            CDVPluginResult* result;
            
            if (errorRef) {
                NSLog(@"NativeScript Error: %@", toString(self.runtime.globalContext, errorRef));
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:toString(self.runtime.globalContext, errorRef)];
            }
            else {
                NSLog(@"NativeScript Result: %@", toString(self.runtime.globalContext, scriptResultRef));
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:toString(self.runtime.globalContext, scriptResultRef)];
            }
            
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        });
    }];
}

static NSString *toString(JSContextRef context, JSValueRef value) {
    JSStringRef errorMessageRef = JSValueToStringCopy(context, value, NULL);
    size_t errorSize = JSStringGetMaximumUTF8CStringSize(errorMessageRef);
    char errorMessage[errorSize];
    JSStringGetUTF8CString(errorMessageRef, errorMessage, errorSize);
    JSStringRelease(errorMessageRef);
    return [NSString stringWithUTF8String:errorMessage];
}

@end
