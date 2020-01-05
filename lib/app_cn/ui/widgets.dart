import 'package:flutter/material.dart';

class NumberResultText extends StatelessWidget {
  final String title;
  final double titleSize;
  final String subTitle;
  final double subTitleSize;
  final Color titleColor;
  final Color subTitleColor;

  const NumberResultText({
    @required this.title,
    this.titleSize = 30,
    this.subTitle,
    this.subTitleSize,
    this.titleColor,
    this.subTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    if (subTitle != null)
      return Column(
        children: <Widget>[
          NumberText(
            text: title,
            textSize: titleSize,
            textColor: titleColor,
            isBold: true,
          ),
          SizedBox(height: 10),
          NumberText(
            text: subTitle,
            textSize: subTitleSize,
            textColor: subTitleColor,
          ),
        ],
      );

    return NumberText(
      text: title,
      textSize: titleSize,
      textColor: titleColor,
    );
  }
}

class NumberText extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;
  final bool isBold;

  const NumberText({
    @required this.text,
    @required this.textSize,
    @required this.textColor,
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
  final Color bgColor;
  final String text;
  final VoidCallback onTap;

  const NumbersButton({Key key, this.bgColor, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        color: bgColor,
        onPressed: onTap,
      ),
    );
  }
}
