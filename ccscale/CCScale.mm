#import "header/PSListController.h"
#import "header/PSSpecifier.h"
#import "header/PSViewController.h"
#import "header/PSTableCell.h"
#import <UIKit/UIKit.h>

#define exampleTweakPreferencePath @"/User/Library/Preferences/com.rabih96.ccscaleprefs.plist"

@interface CCScaleListController: PSListController {
}
@end

@implementation CCScaleListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"CCScale" target:self] retain];
	}
	return _specifiers;
}

- (id)navigationItem {
	UINavigationItem *item = [super navigationItem];
	UIButton *buttonTwitter = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonTwitter setImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/CCScale.bundle/heart.png"] forState:UIControlStateNormal];
	buttonTwitter.frame = CGRectMake(5,0,35,35);
	UIBarButtonItem *heart = [[[UIBarButtonItem alloc] initWithCustomView:buttonTwitter] autorelease];
	[buttonTwitter addTarget:self action:@selector(shareTapped) forControlEvents:UIControlEventTouchUpInside];
	item.rightBarButtonItem = heart;
	return item;
}

- (void)respring
{
	system("killall backboardd");
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
	NSDictionary *exampleTweakSettings = [NSDictionary dictionaryWithContentsOfFile:exampleTweakPreferencePath];
	if (!exampleTweakSettings [specifier.properties[@"key"]]) {
		return specifier.properties[@"default"];
	}
	return exampleTweakSettings [specifier.properties[@"key"]];
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
	[defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:exampleTweakPreferencePath]];
	[defaults setObject:value forKey:specifier.properties[@"key"]];
	[defaults writeToFile:exampleTweakPreferencePath atomically:YES];
	NSDictionary *exampleTweakSettings = [NSDictionary dictionaryWithContentsOfFile:exampleTweakPreferencePath];
	CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
	if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
}

- (void)followMe:(id)specifier {
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/rabih96"]];
	}

	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=rabih96"]];
	}

	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetings:///user?screen_name=rabih96"]];
	}

	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=rabih96"]];
	}

	else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://mobile.twitter.com/rabih96"]];
	}
}

- (void)shareTapped {
	NSString *text = @"Scale your ControlCenter using #CCScale by @rabih96.";

	if ([UIActivityViewController alloc]) {
		UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[text] applicationActivities:nil];
		[(UINavigationController *)[super navigationController] presentViewController:activityViewController animated:YES completion:NULL];
	}else {
		//too lazy for this
	}
}

@end

// vim:ft=objc
