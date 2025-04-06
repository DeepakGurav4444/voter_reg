import 'package:flutter/material.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

class IconWithData extends StatelessWidget {
  final IconData iconData;
  final String data;
  const IconWithData({super.key, required this.iconData, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.mediaQueryWidth * 0.05,
          child: Icon(iconData, color: Colors.blueGrey),
        ),
        SizedBox(width: context.mediaQueryWidth * 0.05),
        SizedBox(
            width: context.mediaQueryWidth * 0.37,
            child: Text(
              data,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: context.mediaQueryWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800),
            )),
      ],
    );
  }
}
