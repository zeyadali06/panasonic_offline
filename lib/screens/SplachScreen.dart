// ignore_for_file: file_names

import 'package:Panasonic_offline/cubits/DarkMode/DarkModeCubit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Panasonic_offline/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    prepareData(context);
  }

  Future<void> prepareData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    await BlocProvider.of<DarkModeCubit>(context).initMode();
    Navigator.pushReplacementNamed(context, 'HomeNavigationBar');
  }

  @override
  void dispose() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimayColor,
      body: Center(
        child: AnimatedTextKit(
          isRepeatingAnimation: false,
          pause: const Duration(milliseconds: 0),
          animatedTexts: [
            TypewriterAnimatedText(
              'Panasonic',
              cursor: '',
              curve: Curves.elasticOut,
              speed: const Duration(milliseconds: 250),
              textStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
