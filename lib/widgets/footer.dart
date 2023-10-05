import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EBFooter extends StatelessWidget {
  final String _companyPath = 'assets/svgs/ebayan/company.svg';
  final String _logoPath = 'assets/svgs/ebayan/logo-color.svg';

  const EBFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const double footerHeight = 50.0;
    const double paddingX = 50.0;
    const double paddingY = 15.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingX, vertical: paddingY),
      child: SizedBox(
        height: footerHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SvgPicture.asset(_companyPath),
                EBTypography.small(text: 'Copyright © ${DateTime.now().year}', muted: true),
              ],
            ),
            Column(
              children: [
                SvgPicture.asset(_logoPath),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
