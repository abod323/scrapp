import 'package:flutter/material.dart';
import 'package:sacrapapp/app/util/app_constant.dart';



class CustomButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final Widget? image;
  final VoidCallback onPressed;
  final bool isLoding;
  final double width;


  const CustomButton({
    required this.color,

    required this.textColor,
    required this.text,
    required this.onPressed,
    this.image,
    this.isLoding = false,
    this.width= double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:  BoxConstraints(
        minWidth:width,
      ),
      child: image != null
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: onPressed,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: kPaddingL),
                    child: image,
                  ),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            )
          : TextButton(
              style: TextButton.styleFrom(
                backgroundColor: color,
                padding: const EdgeInsets.all(kPaddingM),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: onPressed,
              child: isLoding
                  ? Container(
                      height: 30,
                      width: 30,
                    child: const CircularProgressIndicator(
                        
                        valueColor: AlwaysStoppedAnimation<Color>(kWhite),
                      ),
                  )
                  : Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
