// ignore_for_file: file_names

import 'package:Panasonic_offline/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:Panasonic_offline/constants.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

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
    await Hive.openBox<bool>(KIsDarkBox);
    Provider.of<ProviderVariables>(context, listen: false).dark = Hive.box<bool>(KIsDarkBox).get(KIsDarkBox, defaultValue: false)!;
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
      backgroundColor: KPrimayColor,
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
