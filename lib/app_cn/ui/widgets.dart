import 'package:flutter/material.dart';

class NumberResultText extends StatelessWidget {
  final String title;
  final double? titleSize;
  final String? subTitle;
  final double? subTitleSize;
  final Color? titleColor;
  final Color? subTitleColor;

  const NumberResultText({
    Key? key,
    required this.title,
    this.titleSize = 30,
    this.subTitle,
    this.subTitleSize,
    this.titleColor,
    this.subTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    if (subTitle != null) {
      return Column(
        children: <Widget>[
          NumberText(
            text: title,
            textSize: titleSize ?? 0.0,
            textColor: titleColor ?? Colors.black,
            isBold: true,
          ),
          const SizedBox(height: 10),
          NumberText(
            text: subTitle ?? '',
            textSize: subTitleSize ?? 0.0,
            textColor: subTitleColor ?? Colors.blueGrey,
          ),
        ],
      );
    }

    return NumberText(
      text: title,
      textSize: titleSize ?? 0.0,
      textColor: titleColor ?? Colors.black,
    );
  }
}

class NumberText extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;
  final bool isBold;

  const NumberText({
    Key? key,
    required this.text,
    required this.textSize,
    required this.textColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

class NumbersButton extends StatelessWidget {
  final Color? bgColor;
  final String? text;
  final VoidCallback? onTap;

  const NumbersButton({Key? key, this.bgColor, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        child: Text(
          text ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(primary: bgColor),
        onPressed: onTap,
      ),
    );
  }
}
