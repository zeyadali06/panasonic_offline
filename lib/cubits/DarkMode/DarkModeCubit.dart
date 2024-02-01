// ignore_for_file: file_names

import 'package:Panasonic_offline/constants.dart';
import 'package:Panasonic_offline/cubits/DarkMode/DarkModeStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class DarkModeCubit extends Cubit<Mode> {
  bool isDark = false;

  DarkModeCubit() : super(Mode());

  Future<void> initMode() async {
    await Hive.openBox<bool>(kIsDarkBox);
    isDark = Hive.box<bool>(kIsDarkBox).get(kIsDarkBox, defaultValue: false)!;
    isDark ? emit(DarkMode()) : emit(WhiteMode());
  }

  Future<void> convert() async {
    isDark = !isDark;
    await Hive.box<bool>(kIsDarkBox).put(kIsDarkBox, isDark);
    isDark ? emit(DarkMode()) : emit(WhiteMode());
  }
}
