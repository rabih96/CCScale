@interface SBControlCenterContainerView : UIView
@end

#define kSettingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.rabih96.ccscaleprefs.plist"]
#define PreferencesChangedNotification "com.rabih96.ccscaleprefs/changed"

static BOOL enabled;
static CGFloat scale;

%hook SBControlCenterViewController

- (void)loadView{
	%orig;

	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:kSettingsPath];

	NSNumber *enabledKey = prefs[@"enabled"];
	enabled = enabledKey ? [enabledKey boolValue] : 1;

	NSNumber *scaleKey = prefs[@"scale"];
	scale = scaleKey ? [scaleKey floatValue] : 1.0;

	if(enabled){
		[MSHookIvar<SBControlCenterContainerView *>(self, "_containerView") setTransform:CATransform3DGetAffineTransform(CATransform3DMakeScale(scale, scale, 0))];
	}
}

%end
