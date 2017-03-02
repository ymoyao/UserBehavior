//
//  UserBehaviorSwift-Bridging-Header.h
//  UserBehaviorSwift
//
//  Created by MasterFly on 2017/3/2.
//  Copyright © 2017年 MasterFly. All rights reserved.
//

#ifndef UserBehaviorSwift_Bridging_Header_h
#define UserBehaviorSwift_Bridging_Header_h

// 这个库不在 headSearch里面设置就找不到。单独加上
#import "Aspects.h"

//友盟不设置就能找到，应该是framework的缘故
#import <UMMobClick/MobClick.h>

#import <UMMobClick/MobClickSocialAnalytics.h>

#endif /* UserBehaviorSwift_Bridging_Header_h */
