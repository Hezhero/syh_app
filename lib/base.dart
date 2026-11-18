/**
 *  Copyright (C) 2018-2026
 *  All rights reserved, Designed By syh.hzhero.cn
 */
library base;

import 'package:flutter/foundation.dart';
/*
 * @discripe: 全局公共类管理
 */
export 'httpUrl.dart';
export 'io.dart';

mixin class BBase {
  //通用链接 打包会自动使用线上链接
  static final baseHost = kDebugMode ? 'http://192.168.1.15:8008' : 'https://demo.admin.syh.hzhero.cn';
  //调试用
  // static final baseHost = 'http://192.168.1.15:8008';
  //线上地址
  // static final baseHost = 'http://demo.admin.syh.hzhero.cn';

  static final suUrl = '${BBase.baseHost}/api';
}