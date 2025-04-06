// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:voter_reg/utils/extensions/flush_bar_extension.dart';

// import '../../../bloc/login/login_bloc.dart';
// import '../../../configs/components/round_button.dart';
// import '../../../configs/routes/routes_name.dart';
// import '../../../network_module/response/status.dart';

// class LoginButton extends StatefulWidget {
//   final LoginBloc loginBloc;
//   const LoginButton({super.key, required this.loginBloc});

//   @override
//   State<LoginButton> createState() => _LoginButtonState();
// }

// class _LoginButtonState extends State<LoginButton> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LoginBloc, LoginState>(
//       listenWhen: (current, previous) =>
//           current.loginApi.status != previous.loginApi.status,
//       listener: (context, state) {
//         if (state.loginApi.status == Status.error) {
//           context.flushBarErrorMessage(
//               message: state.loginApi.message.toString());
//         }

//         if (state.loginApi.status == Status.completed) {
//           Navigator.pushNamedAndRemoveUntil(
//               context, RoutesName.login, (route) => false);
//         }
//       },
//       builder: (context, state) {
//         return StreamBuilder<bool>(
//             stream: widget.loginBloc.validateLoginDetails(context),
//             builder: (context, snapshot) {
//               return RoundButton(
//                   title: 'Login',
//                   loading:
//                       state.loginApi.status == Status.loading ? true : false,
//                   onPress: snapshot.hasData
//                       ? () => context.read<LoginBloc>().add(LoginApi())
//                       : null);
//             });
//       },
//     );
//   }
// }
