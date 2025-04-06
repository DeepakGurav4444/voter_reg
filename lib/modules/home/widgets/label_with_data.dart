import 'package:flutter/material.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

class LabelWithData extends StatelessWidget {
  final String label;
  final String data;
  const LabelWithData({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: context.mediaQueryWidth * 0.4,
            child: Text(
               " $label",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: context.mediaQueryWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400),
            )),
        Text(
          ": ",
          style: TextStyle(
              fontSize: context.mediaQueryWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600),
        ),
        SizedBox(
            width: context.mediaQueryWidth * 0.52,
            child: Text(
              data,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: context.mediaQueryWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700),
            )),
      ],
    );
  }
}
