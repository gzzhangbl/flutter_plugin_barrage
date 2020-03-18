#import "BarragePlugin.h"
#if __has_include(<barrage/barrage-Swift.h>)
#import <barrage/barrage-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "barrage-Swift.h"
#endif

@implementation BarragePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBarragePlugin registerWithRegistrar:registrar];
}
@end
