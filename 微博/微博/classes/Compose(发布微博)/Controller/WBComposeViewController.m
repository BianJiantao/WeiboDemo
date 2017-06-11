//
//  WBComposeViewController.m
//  微博
//
//  Created by BJT on 17/5/25.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

#import "WBComposeViewController.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBEmotionTextView.h"
#import "WBComposeToolBar.h"
#import "WBComposePhotosView.h"
#import "WBEmotionKeyboard.h"
#import "WBEmotion.h"
#import "WBHttpTool.h"

@interface WBComposeViewController () <WBComposeToolBarDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 *  文字输入控件
 */
@property (nonatomic,weak) WBEmotionTextView *textView;
/**
 *  键盘顶部工具条
 */
@property (nonatomic,weak) WBComposeToolBar *toolbar;
/**
 *  展示选中的图片
 */
@property (nonatomic,weak) WBComposePhotosView *photosView;

/**
 *  表情键盘
 */
@property (nonatomic,strong) WBEmotionKeyboard *emotionKeyboard;

/**
 *  是否正在切换键盘
 */
@property (nonatomic,assign,getter=isSwitchingKeyboard) BOOL switchingKeyboard;

@end

@implementation WBComposeViewController

#pragma mark - 懒加载
- (WBEmotionKeyboard *)emotionKeyboard
{
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [[WBEmotionKeyboard alloc] init];
        _emotionKeyboard.width = self.view.width;
        _emotionKeyboard.height = 253;
//        _emotionKeyboard.backgroundColor = kRandomColor;
    }
    return _emotionKeyboard;
}

#pragma mark - 系统方法
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText; // 按钮文字颜色改变有效
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.textView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
    
    [self setupPhotosView];
}

-(void)dealloc
{
    [WBNotificationCenter removeObserver:self];
}

#pragma mark - 初始化方法
-(void)setupPhotosView
{
    WBComposePhotosView *photosView = [[WBComposePhotosView alloc] init];
    photosView.x = 0;
    photosView.y = 100;
    photosView.width = self.textView.width - 2 * photosView.x;
    photosView.height = 200;
//    photosView.backgroundColor = kRandomColor;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}
- (void)setupToolbar
{
    WBComposeToolBar *toolbar = [[WBComposeToolBar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
}

/**
 *  set up navigation bar
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style: UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style: UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    //    self.navigationItem.rightBarButtonItem.enabled = NO; // 文字颜色改变无效
    
    UILabel *titleView = [[UILabel alloc] init];
    titleView.width = 200;
    titleView.height = 44;
    titleView.y = 20;
    titleView.textAlignment = NSTextAlignmentCenter;
    //    titleView.backgroundColor = [UIColor redColor];
    titleView.numberOfLines = 0;
    NSString *prefix = @"发微博";
    NSString *name = [WBAccountTool account].name;
    if (name) {
        
        NSString *text = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString * attrText = [[NSMutableAttributedString alloc] initWithString:text];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        
        [attrText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[text rangeOfString:prefix]];
        [attrText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[text rangeOfString:name]];
        titleView.attributedText = attrText;
        self.navigationItem.titleView = titleView;
        
    }else{
        self.title = prefix;
    }
    
    //    WBLog(@"%@",NSStringFromCGRect(titleView.frame));
    

}
/**
 *  set up text intput view
 */
- (void)setupTextView
{
    WBEmotionTextView *textView = [[WBEmotionTextView alloc] init];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.frame = self.view.bounds;
    textView.placeHolderText = @"分享新鲜事儿...";
    textView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textView];
    self.textView = textView;
    
    [WBNotificationCenter addObserver:self selector:@selector(textContentDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [WBNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 监听表情选中的通知
    [WBNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:WBEmotionDidSelectNotification object:nil];
    
    // 监听表情键盘删除按钮点击的通知
    [WBNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:WBEmotionDidDeleteNotification object:nil];
    
    
//    WBLog(@"%@",NSStringFromCGRect(textView.frame));
}


#pragma mark -通知方法
/**
 *  表情键盘删除按钮点击
 */
-(void)emotionDidDelete
{
    [self.textView deleteBackward];
}

/**
 *  表情被选中
 */
-(void)emotionDidSelect:(NSNotification *)noti
{
//    WBLog(@"---%@",noti);
    WBEmotion *emotion = noti.userInfo[WBEmotionDidSelectKey];
    
    [self.textView insertEmotion:emotion];
    
    [self  textContentDidChange];
    
//    WBLog(@"%@",self.textView.text);
//    WBLog(@"%@",self.textView.attributedText.string);
    
}


-(void)keyboardWillChangeFrame:(NSNotification *)noti
{
    // 正在切换键盘, 直接返回
    if(self.isSwitchingKeyboard ) return;
    
//    WBLog(@"%@",noti);
    /*
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 568}, {320, 253}},
     UIKeyboardCenterEndUserInfoKey = NSPoint: {160, 441.5},
     UIKeyboardB },
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 315}, {320, 253}},
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {160, 694.5},
     UIKeyboardAnimationCurveUserInfoKey = 7,
     UIKeyboardIsLocalUserInfoKey = 1
     */
    NSDictionary *infoDict = noti.userInfo;
    double duration =  [infoDict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect = [infoDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = rect.origin.y - self.toolbar.height;
    }];
    
}

/**
 *  textView 文本内容改变
 */
- (void)textContentDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - 监听方法
/**
 *  导航栏取消按钮点击
 */
-(void)cancel
{
    [self.view endEditing:YES]; 
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发微博 compose status
 */
-(void)send
{
    
    if (self.photosView.photos.count) {
        [self composeStatusWithIamge];
    }else{
        [self composeStatusWithoutIamge];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    [MBProgressHUD showMessage:@"发送中"];
    
}

/**
 *  发布带配图的微博
 */
- (void)composeStatusWithIamge
{
    WBAccount *account = [WBAccountTool account];
    NSString *urlStr = @"https://upload.api.weibo.com/2/statuses/upload.json";
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    /*
     access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
     status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     pic	true	binary	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
     */
    paras[@"access_token"] = account.access_token;
    paras[@"status"]  = self.textView.fullText;
    
    UIImage *image = [self.photosView.photos firstObject];
    
    [WBHttpTool POST:urlStr parameters:paras image:image success:^(id responseObject) {
        
        //        [MBProgressHUD hideHUD];
        [ MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(NSError *error) {
        
        //        [MBProgressHUD hideHUD];
        [ MBProgressHUD showError:@"发送失败"];
        WBLog(@"compose status failure,%@",error);
        
    }];
}

/**
 *  发布不带配图的微博
 */
- (void)composeStatusWithoutIamge
{
    WBAccount *account = [WBAccountTool account];
    NSString *urlStr = @"https://api.weibo.com/2/statuses/update.json";
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    /*
     access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
     status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     */
    paras[@"access_token"] = account.access_token;
    paras[@"status"]  = self.textView.fullText;
    
    [WBHttpTool POST:urlStr parameters:paras success:^(id responseObject) {
        
        //        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功"];
        
        
    } failure:^(NSError *error) {
        
        //        [MBProgressHUD hideHUD];
        [ MBProgressHUD showError:@"发送失败"];
        WBLog(@"compose status failure,%@",error);
        
    }];
}

/**
 *  hide keyboard when begin dragging
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - toolBar delegate
-(void)composeToolbar:(WBComposeToolBar *)toolbar DidClickBtnType:(WBComposeToolBarBtnType)buttonType
{
    switch (buttonType) {
        case WBComposeToolBarBtnTypeCamera:
            [self openCamera];
            break;
        case WBComposeToolBarBtnTypePicture:
            [self openAlbum];
            break;
        case WBComposeToolBarBtnTypeMention:
            
            break;
        case WBComposeToolBarBtnTypeTrend:
            
            break;
        case WBComposeToolBarBtnTypeEmotion:
            [self switchKeyboard];
            break;
            
    }
}

#pragma mark - UIImagePickerController delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    /* info
     UIImagePickerControllerOriginalImage = <UIImage: 0x7fb2aac31290> size {3000, 2002} orientation 0 scale 1.000000,
     UIImagePickerControllerMediaType = public.image,
     UIImagePickerControllerReferenceURL = assets-library://asset/asset.JPG?id=D6D1521A-A483-47E4-B943-05241A72E544&ext=JPG
     */
//    WBLog(@"%@",info);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.photosView addPhoto:info[UIImagePickerControllerOriginalImage]];
    
    
}
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    
//}


#pragma mark - 其他方法
/**
 *  切换键盘
 */
- (void)switchKeyboard
{
//    WBLog(@"%@",self.textView.inputView);
    self.switchingKeyboard = YES; // 旧键盘退出时, 工具条不动
    if (self.textView.inputView == nil) { // 切换到表情键盘
        
        // 切换键盘
        self.textView.inputView =  self.emotionKeyboard;
        // 改变表情按钮图片 显示键盘图片
        self.toolbar.showKeyboardButton = YES;
        
    }else{ // 切换到文字键盘
        
        self.textView.inputView = nil;
        // 改变表情按钮图片 显示表情图片
        self.toolbar.showKeyboardButton = NO;
        
    }
    
    [self.view endEditing:YES];
    
    self.switchingKeyboard = NO; // 新键盘弹出时, 工具条跟着调整位置
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.textView becomeFirstResponder];
        
    });
}


#warning TODO 待增强,自定义图片选择控制器,选多张图片
-(void)openCamera
{
    [self openImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
}
-(void)openAlbum
{
    [self openImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
}

- (void)openImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = sourceType;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}



@end
