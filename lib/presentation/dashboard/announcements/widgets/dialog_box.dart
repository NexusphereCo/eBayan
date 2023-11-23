import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:flutter/material.dart';

class DeleteAnnouncementBox extends StatelessWidget {
  final String annId;

  const DeleteAnnouncementBox({Key? key, required this.annId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 200,
        height: 160,
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          EBTypography.h4(text: 'Are  you sure you want to delete this announcement?', fontWeight: EBFontWeight.bold),
          EBTypography.small(text: 'This action cannot be undone,'),
          const SizedBox(height: Spacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              EBButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'No',
                theme: EBButtonTheme.primaryOutlined,
              ),
              const SizedBox(width: Spacing.sm),
              EBButton(onPressed: () {}, text: 'Yes', theme: EBButtonTheme.primary),
            ],
          )
        ]),
      ),
    );
  }
}
