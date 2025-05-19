import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class StateIcons extends StatelessWidget {
  const StateIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffED85A6),
                Color(0xffBD5555),
              ],
            ),
            borderRadius: BorderRadius.circular(72),
          ),
          child: SvgPicture.asset(
            'assets/icons/skip.svg',
            height: 35,
          ),
        ),
        Spacer(),
        Container(
          alignment: Alignment.center,
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFDF51C),
                Color(0xffADBD55),
              ],
            ),
            borderRadius: BorderRadius.circular(72),
          ),
          child: SvgPicture.asset(
            'assets/icons/keep.svg',
            height: 35,
          ),
        ),
        Spacer(),
        Container(
          alignment: Alignment.center,
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff85ED9F),
                Color(0xff66C5A0),
              ],
            ),
            borderRadius: BorderRadius.circular(72),
          ),
          child: SvgPicture.asset(
            'assets/icons/request.svg',
            height: 35,
          ),
        ),
      ],
    );
  }
}
