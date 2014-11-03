//
//  ViewController.m
//  Reachabilitysample
//
//  Created by ビザンコムマック０７ on 2014/11/03.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController (){
    //Reachabilityの変数
    Reachability *ability;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    //ablityの初期化(メソッドreachabilityForInternetConnectionはネット接続を確認するための値を返す)
    ability = [Reachability reachabilityForInternetConnection];
    //ネットの接続状況が変わるたびにメソッドnetchangeを呼び出すように設定
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netchange:) name:kReachabilityChangedNotification object:nil];
    [super viewDidLoad];
    //現在のネットの接続情報を持つ変数を生成
    //クラスNetworkStatusは、ネットの接続情報を持つためのクラス
    //メソッドcurrentReachabilityStatusは、現在のネットの接続情報を返す
    NetworkStatus status = [ability currentReachabilityStatus];
    //statusの値がNotReacableでないかどうか(ネットと接続できる状況であるか)
    if (status != NotReachable) {
        //statusの値がReachableViaWWANであるかどうか(携帯回線で接続できるか)
        if (status == ReachableViaWWAN) {
                self.label.text = @"携帯回線で接続できる";
        }
        //statusの値がReachableViaWifiであるかどうか(Wifi回線で接続できるか)
        else if(status == ReachableViaWiFi){
            self.label.text = @"Wifiで接続できる";
        }
    }
    //ネットと接続できない場合の処理
    else{
        self.label.text = @"圏外です";
    }
    //ネットワーク監視開始
    [ability startNotifier];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ネットの接続状況が変わるたびに呼ばれるメソッド
-(void)netchange:(NSNotification*)notification{
    //ネットの接続情報を持つ変数を生成
    NetworkStatus status = [ability currentReachabilityStatus];
    //statusの値がNotReacableであるかどうか(ネットと接続できない状況であるか)
    if (status == NotReachable) {
        self.label.text = @"圏外になりました";
    }else{
        self.label.text = @"つながりました";
    }
}
@end
