import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Panasonic_offline/constants.dart';
import 'package:Panasonic_offline/models/ProductModel.dart';

class TFForAddProduct extends StatefulWidget {
  const TFForAddProduct({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.multiLine = false,
    this.enabled = true,
    this.suffixText,
    this.inputFormatters,
  });

  final String hintText;
  final String? suffixText;
  final void Function(String data)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool multiLine;
  final TextEditingController? controller;
  final bool enabled;

  @override
  State<TFForAddProduct> createState() => _TFForAddProductState();
}

class _TFForAddProductState extends State<TFForAddProduct> {
  bool? foucs;
  Color color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (foucsed) {
        foucs = foucsed;
        if (foucsed) {
          color = Theme.of(context).buttonTheme.colorScheme!.scrim;
        } else {
          color = Colors.grey;
        }
        setState(() {});
      },
      child: TextField(
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.multiLine ? TextInputType.multiline : null,
        enabled: widget.enabled,
        maxLines: widget.multiLine ? null : 1,
        cursorColor: color,
        onChanged: widget.onChanged,
        controller: widget.controller,
        style: const TextStyle(fontSize: 18),
        minLines: widget.multiLine ? 5 : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: kRadius),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color, width: 2), borderRadius: kRadius),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: color),
          suffixText: widget.suffixText,
          suffixStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  const CustomCheckbox({Key? key, required this.initialValue, required this.onChanged, required this.activeColor}) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      activeColor: widget.activeColor,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
        widget.onChanged(isChecked);
      },
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({super.key, required this.hintText, required this.onChanged, required this.onSaved, required this.label, this.prefixIcon, this.obscureText = false, this.inputFormatters});

  final String hintText;
  final String label;
  final void Function(String data)? onChanged;
  final void Function(String? data)? onSaved;
  List<TextInputFormatter>? inputFormatters;

  final IconData? prefixIcon;
  bool obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final controller = TextEditingController();
  bool? foucs;
  Color color = Colors.grey;
  final errorColor = Colors.red;
  final noErrorFoucsColor = kPrimayColor;
  final noErrornoFoucsColor = Colors.grey;
  IconData icon = Icons.remove_red_eye_outlined;
  bool? show;

  @override
  void initState() {
    super.initState();
    show = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (foucsed) {
        foucs = foucsed;
        if (foucsed && color != errorColor) {
          setState(() {
            color = noErrorFoucsColor;
          });
        } else if (foucsed == false && color != errorColor) {
          setState(() {
            color = noErrornoFoucsColor;
          });
        }
      },
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            setState(() {
              color = errorColor;
            });
            return 'Field is required';
          } else if (foucs == true) {
            setState(() {
              color = noErrorFoucsColor;
            });
          } else {
            setState(() {
              color = noErrornoFoucsColor;
            });
          }
          return null;
        },
        onSaved: widget.onSaved,
        cursorOpacityAnimates: true,
        cursorColor: color,
        obscureText: show!,
        onChanged: widget.onChanged,
        controller: controller,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: kRadius),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color, width: 2), borderRadius: kRadius),
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: color) : null,
          label: Text(widget.label, style: TextStyle(color: color)),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: color),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(icon, color: color),
                  onPressed: () {
                    show = !show!;
                    if (show!) {
                      icon = Icons.remove_red_eye_outlined;
                    } else {
                      icon = Icons.remove_red_eye;
                    }
                    setState(() {});
                  })
              : IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: Icon(Icons.clear, color: color),
                ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomDropdownButton extends StatefulWidget {
  CustomDropdownButton({super.key, required this.thingsToDisplay, required this.initialText, this.enabled = true, required this.onSelected});
  String? initialText;
  final List<String> thingsToDisplay;
  final bool enabled;
  void Function(String? value) onSelected;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      menuHeight: MediaQuery.of(context).size.height - 40,
      menuStyle: const MenuStyle(alignment: Alignment.topLeft),
      enabled: widget.enabled,
      initialSelection: widget.initialText,
      dropdownMenuEntries: widget.thingsToDisplay
          .map<DropdownMenuEntry<String>>(
            (value) => DropdownMenuEntry(
              value: value,
              label: value,
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 17)),
                side: MaterialStateProperty.all(const BorderSide(width: .25)),
              ),
            ),
          )
          .toList(),
      width: widthOfCustoms(context),
      textStyle: const TextStyle(fontSize: 18),
      onSelected: (value) {
        setState(() {
          widget.onSelected(value);
        });
      },
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: kRadius),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChooseAndShowCompatibleDevices extends StatefulWidget {
  ChooseAndShowCompatibleDevices({super.key, required this.allCompatibleDevices, required this.product});

  Set<String> allCompatibleDevices;
  ProductModel product;

  @override
  State<ChooseAndShowCompatibleDevices> createState() => _ChooseAndShowCompatibleDevicesState();
}

class _ChooseAndShowCompatibleDevicesState extends State<ChooseAndShowCompatibleDevices> {
  @override
  Widget build(BuildContext context) {
    widget.product.compatibility ??= {};
    return Column(
      children: [
        CustomDropdownButton(
          initialText: widget.allCompatibleDevices.first,
          thingsToDisplay: widget.allCompatibleDevices.toList(),
          onSelected: (value) {
            widget.product.compatibility!.add(value);
            setState(() {});
          },
        ),
        const SizedBox(height: 5),
        Builder(builder: (context) {
          return Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(borderRadius: kRadius, border: Border.all(color: Colors.grey)),
            child: widget.product.compatibility!.isNotEmpty
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Column(
                      children: widget.product.compatibility!.map((e) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Theme.of(context).buttonTheme.colorScheme!.outline), borderRadius: kRadius),
                          child: ListTile(
                            shape: RoundedRectangleBorder(side: BorderSide(width: 0, color: Theme.of(context).buttonTheme.colorScheme!.outline), borderRadius: kRadius),
                            title: Text(e, style: const TextStyle(fontSize: 22)),
                            tileColor: Theme.of(context).buttonTheme.colorScheme!.background,
                            trailing: IconButton(
                              onPressed: () {
                                widget.product.compatibility!.remove(e);
                                setState(() {});
                              },
                              icon: Icon(Icons.clear, color: Theme.of(context).textTheme.bodyLarge!.color),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : Center(child: Text('No devices selected', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: 22))),
          );
        }),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.widget, required this.color, required this.borderColor, this.state});

  final void Function() onTap;
  final Widget widget;
  final Color color;
  final Color borderColor;
  final bool? state;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(side: BorderSide(color: borderColor, width: 2), borderRadius: kRadius),
      onPressed: onTap,
      color: color,
      height: 50,
      minWidth: double.infinity,
      child: state == null
          ? widget
          : Row(
              children: [
                const Spacer(flex: 1),
                widget,
                const Spacer(flex: 1),
                state! ? const Text('used') : const Text('    '),
              ],
            ),
    );
  }
}

class GDForSignInMethods extends StatelessWidget {
  const GDForSignInMethods({super.key, required this.asset, required this.onTap, required this.text, required this.color});

  final Function() onTap;
  final String asset;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(borderRadius: kRadius, color: color),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(asset, width: 30, height: 30),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class LabelWithRedStar extends StatelessWidget {
  const LabelWithRedStar({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const Text('*', style: TextStyle(color: Colors.red)),
      ],
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 17, color: Colors.white)),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 2),
    ),
  );
}

Text textOfCustomButton({required text}) {
  return Text(text, style: const TextStyle(color: Colors.white, fontSize: 20));
}
