//
//  YAYIMemo.h
//  YAYIMemo
//
//  Created by hxp on 17/8/14.
//  Copyright © 2017年 achego. All rights reserved.
//

#ifndef YAYIMemo_h
#define YAYIMemo_h


#define RunEnvironment 1
#if RunEnvironment
#define API @"https://appdt3.yayi365.cn/v1"   // 正式环境
#define BucketName @"hzgl-bl-prod"
#define BucketNameAvatar @"ya-avatar"
#else
#define API   @"https://appdt3-test.yayi365.cn/v1"
#define BucketName @"hzgl-bl"
#define BucketNameAvatar @"yayi-avatar"
#endif

#pragma mark   ================= OSS ===============

#define OSS_GetSTS   @"/oss/getSTS"

#pragma mark   ==============登录=====================
/** 用户登录
 *  @param  POST 请求方式
 *  @param  mobile 手机号码,(必)
 *  @param  password  密码,(必)
 */

#define Login_url        @"/user/login"
/** 用户注册
 *  @param  POST 请求方式
 *  @param  mobile 手机号码,(必)
 *  @param  password  密码,(必)
 */
#define registerUser_url @"/user/registerUser"

/** 退出登录
 *  @param  POST 请求方式
 */
#define logout_url   @"/user/logout"

/**  忘记密码
 *   @param  mobile 手机号码,(必)
 *   @param  password  密码,(必)
 */
#define forgetPwd_url   @"/user/forgetPwd"


#pragma mark ============== 病历 =====================
/** 病历列表
 *  @param  GET 请求方式
 */
#define case_list_url    @"/case/list"    

/** 添加病历
 *  @param  POST 请求方式
 *  @param  userid   用户id,(必)
 *  @param  info   病历信息(文字或图片地址或语音文件地址),(必)
 *  @param  type   类型 0图片，1文字，2语音 ,(必)
 */
#define case_insert_url  @"/case/insert"

/** 删除病历
 *  @param  POST 请求方式
 *  @param  caseid   病历id,(必)
 */
#define case_delete_url  @"/case/delete"

/** 修改病历内容
 *  @param  POST 请求方式
 *  @param  caseid   病历id,(必)
 *  @param  info     病历信息 (必)
 */
#define case_update_url  @"/case/update"

/** 删除病历标签
 *  @param  POST 请求方式
 *  @param  caseid   病历id,(必)
 *  @param  tagid    标签id (必)
 */
#define deleteCaseTag_url @"/case/deleteCaseTag"

/** 增加病历标签
 *  @param  POST 请求方式
 *  @param  caseid   病历id,(必)
 *  @param  tagid    标签id--可以多个用逗号隔开(如1,2,3) (必)
 */
#define add_caseTag_url   @"/case/addCaseTag"

/** 修改病历病人
 *  @param  POST 请求方式
 *  @param  caseid   病历id,(必)
 *  @param  patientid  病人id (必)
 */
#define add_casePatient_url @"/case/updateCasePatient"

/** 病历通用标签
 *  @param  GET 请求方式
 */
#define listCommonTag_url  @"/case/listCommonTag"

/** 添加病历通用标签
 *  @param  POST 请求方式
 *  @param  tagname  标签名称
 */
#define addCommonTag_url  @"/case/addCommonTag"

/** 修改病历通用标签
 *  @param  POST 请求方式
 *  @param  tagname  标签名称
 *  @param  tagid 标签id
 */
#define updateTag_url @"/case/updateCaseTag"

/** 删除病历通用标签
 *  @param  POST 请求方式
 *  @param  tagid 标签id
 */
#define deleteCommonTag_url @"/case/deleteCommonTag"

/** 病历牙位图
 *  @param  GET 请求方式
 *  @param  caseid 病历id
 *  @param  type 类别 0乳牙，1恒牙   为空时两个全部显示
 */
#define queryToothMap_url @"/case/queryToothMap"

/** 病历牙位图增加修改
 *  @param  POST 请求方式
 *  @param  caseid 病历id
 *  @param  type 类别 0乳牙，1恒牙   为空时两个全部显示
 *  @param  tooth 牙位信息
 */
#define updateToothMap_url @"/case/updateToothMap"





#pragma mark ============== 患者 =====================


/** 添加患者
 *  @param  POST 请求方式
 *  @param  name 患者姓名
 *  @param  mobile 患者手机号码
 *  @param  gender 患者性别，-1女，1男，0未知
 *  @param  tag_name 标签名称，如果有多个标签用“,”分开。例如：正畸，补牙
 *  @param  tagid 标签id（如果是选择标签，则必填），如果有多个，用“，”分开，例如：1,2
 *  @param  age 年龄
 *  @param  avatar：头像
 */
#define patient_insert_url @"/patient/insert"

/** 添加患者  标签查询
 *  @param  GET 请求方式
 *  @param  name 患者姓名
 *
 */
#define add_patients_selectBaseTag @"/patient/selectBaseTag"

/** 修改患者
 *  @param  POST 请求方式
 *  @param  name 患者姓名
 *  @param  mobile 患者手机号码
 *  @param  gender 患者性别，-1女，1男，0未知
 *  @param  tag_name 标签名称，如果有多个标签用“,”分开。例如：正畸，补牙
 *  @param  tagid 标签id（如果是选择标签，则必填），如果有多个，用“，”分开，例如：1,2
 *  @param  age 年龄
 *  @param  avatar：头像
 */
#define update_patient_url @"/patient/update"

/** 删除患者
 *  @param  POST 请求方式
 *  @param  patientid 患者id
 */
#define delete_patient_url @"/patient/delete"

/** 分页查询患者
 *  @param  GET 请求方式
 *  @param  keyValue 关键字，（非必填）
 */
#define selectPatient_patient_url @"/patient/selectPatient"

/** 患者查询时的标签查询
 *  @param  GET 请求方式
 *  @param  tagName：标签名称，（非必填)
 *
 */
#define selectPatientTag_patient_url @"/patient/selectPatientTag"

/**  患者详情
 *   @param  id     患者id
 */
#define selectDetail_url  @"/patient/selectDetail"

/**	患者详情病历列表
 *  @param patientid：患者id，必填
 *  @param tagids：标签id，非必填，如果传入多个就用“，”隔开，例如：1,2,3
 *  @param currentPage：当前页码，非必填
 */
#define selectPatient_url   @"/patient/selectPatientCaseByPage"

/**  删除患者标签
 *   @param  tagid     标签
 */
#define deletePatientTag_url  @"/patient/deletePatientTag"

/**  添加患者标签
 *   @param  tagName      标签名称,
 *   @param  patientids   患者id,多个患者用“,分开”，格式：1,2,3
 */
#define insertPatientTag_url @"/patient/insertPatientTag"

/** 修改患者标签
 *  @param tagName 标签名称
 *  @param patientids 患者id,多个患者用“,分开”，格式：1,2,3
 *  @param tagid 标签id
 */
#define updatePatientTag_url  @"/patient/updatePatientTag"

/**  添加微信号
 *   @param  POST
 *   @param  id      患者id,
 *   @param  wx      微信号
 */
#define addWx_url @"/patient/updateWx"

#pragma mark ============== 日程 =====================

/** 添加行程
 *  @param  POST        请求方式
 *  @param  userid      用户id，（必填)
 *  @param  patientid   患者id
 *  @param  worktime    时间，（必填)
 *  @param  items       事项
 *  @param  repetition  0永不；1每天；2每周；3每年
 */
#define  addCalendarInfo_url @"/calendar/addCalendarInfo"

/** 修改行程
 *  @param  POST        请求方式
 *  @param  userid      用户id，（必填)
 *  @param  patientid   患者id
 *  @param  worktime    时间，（必填)
 *  @param  items       事项
 *  @param  id          行程id
 */
#define  editCalendarInfo_url   @"/calendar/editCalendarInfo"

/** 删除行程
 *  @param  POST        请求方式
 *  @param  id          行程id，（必填)
 *
 */
#define  cancelCalendarInfo_url @"/calendar/cancelCalendarInfo"

/**  查询一个月的行程
 *   @param  patientid
 *   @param  year
 *   @param  month
 *
 */
#define listCalendar_url  @"/calendar/listCalendar"

/**
 *  @param  GET  查询一天的行程
 *  @param  urrent_page  当前页码 必选
 *  @param  userid       用户id  可选
 *  @param  worktime     时间
 *  @param  patientid    患者 id
 *
 */
#define listCalendarInfo_url  @"/calendar/listCalendarInfo"

/**  关键字查询日程
 *
 *   @param  key
 *
 */
#define listCalendarInfoByKey_url  @"/calendar/listCalendarInfoByKey"

/**  事项查询
 *
 *   @param  GET
 *
 */
#define recentCalendarNum_url @"/calendar/recentCalendarNum"

#pragma mark ============== 个人中心 =====================
/** 用户信息
 *  @param  GET
 *
 */

#define user_info_url @"/user/getInfo"

/** 修改头像
 *  @param  POST
 *  @param  userid
 *  @param  avater
 *
 */

#define update_user_avater_url @"/user/updateAvatar"

/** 修改昵称
 *  @param  POST
 *  @param  name
 *
 */

#define update_user_name @"/user/updateName"

/** 修改手机号
 *  @param  POST
 *  @param  mobile
 *
 */
#define update_user_mobile @"/user/updateMobile"


/** 修改密码
 *  @param  POST
 *  @param old_pwd
 *  @param new_pwd
 */
#define update_password_url @"/user/updatePwd"


/** 获取验证码
 *  @param  GET
 *  @param  mobile
 *
 */
#define getCaptcha_url @"/user/getCaptcha"


/** 验证码校验
 *  @param  GET
 *  @param  mobile
 *
 */
#define verifyCaptcha_url @"/user/verifyCaptcha"

/** 意见反馈
 *  @param  POST
 *  @param  deviceId 设备id
 *  @param  systemType：系统类型    1-iphone  2-android
 *  @param  info：反馈内容
 */
#define addFeedback_url  @"/user/addFeedback"



#pragma  mark ================
/**
 *  添加空数据视图
 *  数据上传失败后，继续上传，直到成功为止
 *  启动图
 *  引导页
 *  app 图标
 *  
 */
#endif 
