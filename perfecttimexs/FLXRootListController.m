#include "FLXRootListController.h"
#import <spawn.h>

@implementation FLXRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)respring {
	if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.yourepo.kingmehu.perfecttimexs.list"]){
					UIAlertController *alerView = [UIAlertController alertControllerWithTitle:@"警告(Warning)!"
					message:@"请从官方源下载(please download this tweak from):https://kingmehu.yourepo.com"
					preferredStyle:UIAlertControllerStyleAlert];

					UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消(cancel)"
					style:UIAlertActionStyleCancel
					handler:nil];
					[alerView addAction:cancelAction];
					[self presentViewController:alerView animated:YES completion:nil];
	} else{
		pid_t pid;
		int status;
		const char* args[] = {"killall", "-9", "SpringBoard", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
		waitpid(pid, &status, WEXITED);
	}
}

-(void)donation {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/kingmehu"] options:@{} completionHandler:nil];
}

-(void)donationAliPay {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"alipayqr://platformapi/startapp?saId=10000007&qrcode=https%3a%2f%2fqr.alipay.com%2fa6x08223f5fjprptz4ksh94"] options:@{} completionHandler:nil];
}
@end
