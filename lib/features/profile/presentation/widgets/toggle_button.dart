import 'package:flutter/cupertino.dart';


class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: CupertinoSwitch(
        value: isEnabled,
        onChanged: (value) {
          setState(() {
            isEnabled = value;
          });
        },
        activeColor: Color(0xff53B175),
        trackColor: Color(0xffD9D9D9),
      ),
    );
  }
}
