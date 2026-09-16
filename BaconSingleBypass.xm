#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BaconViewController : UIViewController <WKNavigationDelegate>
@property(nonatomic,strong) WKWebView *webView;
@property(nonatomic,strong) UITextField *urlField;
@property(nonatomic,strong) UITextView *resultView;
@property(nonatomic,strong) UILabel *statusLabel;
@end

@implementation BaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.06 alpha:1];

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 280, 30)];
    title.text = @"BACON SINGLE BYPASS";
    title.textColor = UIColor.whiteColor;
    title.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:title];

    UIButton *close = [UIButton buttonWithType:UIButtonTypeSystem];
    close.frame = CGRectMake(self.view.bounds.size.width - 52, 8, 40, 40);
    close.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [close setTitle:@"×" forState:UIControlStateNormal];
    [close setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    close.titleLabel.font = [UIFont systemFontOfSize:28];
    [close addTarget:self action:@selector(closeView)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];

    self.urlField = [[UITextField alloc] initWithFrame:CGRectMake(16, 60,
        self.view.bounds.size.width - 32, 44)];
    self.urlField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.urlField.placeholder = @"Dán link vào đây...";
    self.urlField.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"Dán link vào đây..."
                                         attributes:@{NSForegroundColorAttributeName:
                                                      [UIColor colorWithWhite:1 alpha:.45]}];
    self.urlField.textColor = UIColor.whiteColor;
    self.urlField.backgroundColor = [UIColor colorWithWhite:1 alpha:.10];
    self.urlField.layer.cornerRadius = 10;
    self.urlField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,0)];
    self.urlField.leftViewMode = UITextFieldViewModeAlways;
    self.urlField.keyboardType = UIKeyboardTypeURL;
    self.urlField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.urlField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.urlField];

    UIButton *run = [UIButton buttonWithType:UIButtonTypeSystem];
    run.frame = CGRectMake(16, 114, self.view.bounds.size.width - 32, 44);
    run.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    run.backgroundColor = [UIColor colorWithRed:.80 green:0 blue:1 alpha:1];
    run.layer.cornerRadius = 10;
    [run setTitle:@"CHẠY" forState:UIControlStateNormal];
    [run setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    run.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [run addTarget:self action:@selector(runBypass)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:run];

    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 166,
        self.view.bounds.size.width - 32, 24)];
    self.statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.statusLabel.text = @"Sẵn sàng";
    self.statusLabel.textColor = [UIColor colorWithWhite:1 alpha:.65];
    self.statusLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.statusLabel];

    self.resultView = [[UITextView alloc] initWithFrame:CGRectMake(16, 196,
        self.view.bounds.size.width - 32, 70)];
    self.resultView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.resultView.editable = NO;
    self.resultView.textColor = UIColor.whiteColor;
    self.resultView.backgroundColor = [UIColor colorWithWhite:1 alpha:.08];
    self.resultView.layer.cornerRadius = 10;
    self.resultView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.resultView];

    UIButton *copy = [UIButton buttonWithType:UIButtonTypeSystem];
    copy.frame = CGRectMake(16, 276, 110, 40);
    copy.backgroundColor = [UIColor colorWithWhite:1 alpha:.12];
    copy.layer.cornerRadius = 9;
    [copy setTitle:@"COPY" forState:UIControlStateNormal];
    [copy setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [copy addTarget:self action:@selector(copyResult)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:copy];

    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.webView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = CGRectMake(0, 326, self.view.bounds.size.width,
                                    MAX(0, self.view.bounds.size.height - 326));
}

- (void)runBypass {
    [self.view endEditing:YES];

    NSString *s = [self.urlField.text
        stringByTrimmingCharactersInSet:
        [NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSURL *target = [NSURL URLWithString:s];
    if (!target || !target.scheme || !target.host) {
        self.statusLabel.text = @"URL không hợp lệ.";
        return;
    }

    self.resultView.text = @"";
    self.statusLabel.text = @"Đang mở Bacon Bypass...";

    NSURL *home = [NSURL URLWithString:@"https://baconbypass.xyz/"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:home]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *s = [self.urlField.text
        stringByTrimmingCharactersInSet:
        [NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (!s.length) return;

    NSString *e = [s stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    e = [e stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];

    NSString *js = [NSString stringWithFormat:
        @"(function(){var e=document.querySelector('input[type=url],input[name=url]');"
         "if(!e)e=document.querySelector('input');"
         "if(e){e.focus();e.value='%@';"
         "e.dispatchEvent(new Event('input',{bubbles:true}));"
         "e.dispatchEvent(new Event('change',{bubbles:true}));return 'filled';}"
         "return 'not-found';})();", e];

    [webView evaluateJavaScript:js completionHandler:^(id value, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statusLabel.text =
                ([value isEqual:@"filled"])
                ? @"Đã điền URL. Hoàn thành xác minh và thao tác trên trang."
                : @"Không tìm thấy ô URL; hãy nhập trực tiếp trên trang.";
        });
    }];
}

- (void)copyResult {
    NSString *s = [self.resultView.text
        stringByTrimmingCharactersInSet:
        [NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (!s.length) {
        self.statusLabel.text = @"Chưa có kết quả.";
        return;
    }

    [UIPasteboard generalPasteboard].string = s;
    self.statusLabel.text = @"Đã copy.";
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

void BaconShowMenu(void) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = nil;

        if (@available(iOS 13.0, *)) {
            for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive &&
                    [scene isKindOfClass:[UIWindowScene class]]) {
                    for (UIWindow *w in ((UIWindowScene *)scene).windows) {
                        if (w.isKeyWindow) { window = w; break; }
                    }
                }
                if (window) break;
            }
        }

        if (!window) window = UIApplication.sharedApplication.keyWindow;
        UIViewController *top = window.rootViewController;
        while (top.presentedViewController) top = top.presentedViewController;

        BaconViewController *vc = [BaconViewController new];
        vc.modalPresentationStyle = UIModalPresentationPageSheet;
        [top presentViewController:vc animated:YES completion:nil];
    });
}
