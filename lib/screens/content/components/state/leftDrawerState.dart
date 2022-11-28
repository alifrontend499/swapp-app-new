// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// page consts
import 'package:app/screens/content/const/textConsts.dart';

// left drawer state
final selectedUserStatusProvider = StateProvider<String>((ref) => STATUS_WORK);