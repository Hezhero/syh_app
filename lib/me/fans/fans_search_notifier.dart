/**
 *  Copyright (C) 2018-2026
 *  All rights reserved, Designed By syh.hzhero.cn
 */
import 'package:flutter/cupertino.dart';

//
class FansSearchNotifier extends ValueNotifier<String> {
  FansSearchNotifier(value) : super(value);
}

FansSearchNotifier fansSearchNotifier = new FansSearchNotifier('');
