// ignore_for_file: file_names

import 'package:Panasonic_offline/constants.dart';
import 'package:Panasonic_offline/cubits/DarkMode/DarkModeStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class DarkModeCubit extends Cubit<DarkMode> {
  bool isDark = false;

  DarkModeCubit() : super(DarkMode());

  Future<void> initMode() async {
    await Hive.openBox<bool>(KIsDarkBox);
    isDark = Hive.box<bool>(KIsDarkBox).get(KIsDarkBox, defaultValue: false)!;
    isDark ? emit(Dark()) : emit(White());
  }

  Future<void> convert() async {
    isDark = !isDark;
    await Hive.box<bool>(KIsDarkBox).put(KIsDarkBox, isDark);
    isDark ? emit(Dark()) : emit(White());
  }
}
