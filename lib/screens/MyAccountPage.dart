// ignore_for_file: file_names

import 'package:Panasonic_offline/cubits/DarkMode/DarkModeCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:Panasonic_offline/components/helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.refresh});

  final Function refresh;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoading = false;
  bool isChecked = false;

  void performAction() {
    widget.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: const Text("My Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Photo
              Column(
                children: [
                  const SizedBox(height: 60),

                  // Photo
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage("assets/images/profile-user.png"),
                        backgroundColor: Colors.grey,
                      ),
                      Positioned(
                        bottom: 3,
                        right: 5,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Theme.of(context).primaryColor),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            iconSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Username
                  Text(
                    'zeyad',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  const SizedBox(height: 6),

                  // Email
                  Text(
                    'ali',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  const SizedBox(height: 50),
                ],
              ),

              Column(
                children: [
                  // Settings
                  GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      title: Text("Settings", style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge!.color)),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Theme.of(context).primaryColor),
                        child: const Icon(Icons.settings_outlined, color: Colors.white),
                      ),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Icons.arrow_forward_ios, color: Theme.of(context).textTheme.bodyLarge!.color),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Language
                  GestureDetector(
                    onTap: () {},
                    child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Theme.of(context).primaryColor),
                          child: const Icon(Icons.language_outlined, color: Colors.white),
                        ),
                        title: Text("Language", style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge!.color)),
                        trailing: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.arrow_forward_ios, color: Theme.of(context).textTheme.bodyLarge!.color),
                        )),
                  ),
                  const SizedBox(height: 10),

                  // Dark Theme
                  GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Theme.of(context).primaryColor),
                        child: const Icon(Icons.color_lens_outlined, color: Colors.white),
                      ),
                      title: Text("Dark Theme", style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge!.color)),
                      trailing: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                        child: CustomCheckbox(
                          activeColor: Theme.of(context).checkboxTheme.overlayColor!.resolve({})!,
                          initialValue: BlocProvider.of<DarkModeCubit>(context).isDark,
                          onChanged: (value) async {
                            setState(() {
                              isLoading = true;
                            });
                            await BlocProvider.of<DarkModeCubit>(context).convert();
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
