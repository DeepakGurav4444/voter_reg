import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/obsecure_field/blocs/obsecure_field_bloc.dart';

class InputField extends StatelessWidget {
  final Widget? prefix;
  final bool? enabled;
  final int? maxLines;
  final bool? obscureText;
  final Function(String)? onChanged;
  final Function? selectDate;
  final AsyncSnapshot<dynamic>? errSnapshot;
  final TextCapitalization? textCapitalization;
  final TextEditingController? textEditingController;
  final String? labelText;
  final String? hintText;
  final TextInputFormatter? filteringTextInputFormatter;
  final LengthLimitingTextInputFormatter? lengthLimitingTextInputFormatter;
  final TextInputType? textInputType;
  final FocusNode? focusNode;

  const InputField({
    super.key,
    this.prefix,
    this.enabled,
    this.maxLines,
    this.obscureText,
    this.onChanged,
    this.errSnapshot,
    this.textCapitalization,
    this.textEditingController,
    this.labelText,
    this.filteringTextInputFormatter,
    this.lengthLimitingTextInputFormatter,
    this.textInputType,
    this.hintText,
    this.focusNode,
    this.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<TextInputFormatter> inputFormatters = [];
    if (filteringTextInputFormatter != null) {
      inputFormatters.add(filteringTextInputFormatter!);
    }
    if (lengthLimitingTextInputFormatter != null) {
      inputFormatters.add(lengthLimitingTextInputFormatter!);
    }

    return (obscureText ?? false)
        ? BlocProvider(
            create: (_) => ObsecureFieldBloc(),
            child: BlocBuilder<ObsecureFieldBloc, ObsecureFieldState>(
                builder: (context, state) {
              return TextFormField(
                controller: textEditingController,
                obscureText: !(state.isFieldVisible) ? true : false,
                inputFormatters: inputFormatters,
                // textCapitalization: textCapitalization!,
                onChanged: onChanged,
                enabled: enabled ?? true,
                keyboardType: textInputType,
                decoration: InputDecoration(
                  suffix: obscureText ?? false
                      ? Padding(
                          padding: EdgeInsets.only(right: size.width * 0.05),
                          child: GestureDetector(
                            onTap: () => context
                                .read<ObsecureFieldBloc>()
                                .add(ToggleFieldVisibility()),
                            child: Icon(
                              state.isFieldVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: errSnapshot!.hasData
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        )
                      : SizedBox(),
                  errorMaxLines: 3,
                  errorText: !errSnapshot!.hasError
                      ? null
                      : errSnapshot!.error.toString(),
                  labelText: labelText,
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontSize: size.width * 0.042, color: Colors.black),
                ),
              );
            }),
          )
        : TextFormField(
            controller: textEditingController,
            inputFormatters: inputFormatters,
            // textCapitalization: textCapitalization!,
            onChanged: onChanged,
            enabled: enabled ?? true,
            keyboardType: textInputType,
            decoration: InputDecoration(
              errorMaxLines: 3,
              errorText:
                  !errSnapshot!.hasError ? null : errSnapshot!.error.toString(),
              suffix: selectDate != null
                  ? GestureDetector(
                      onTap: () => selectDate!(),
                      child: Icon(
                        Icons.date_range,
                        color:
                            errSnapshot!.hasData ? Colors.blue : Colors.black,
                      ),
                    )
                  : SizedBox(),
              labelText: labelText,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: size.width * 0.042, color: Colors.black),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10),
              // ),
            ),
          );
  }
}
