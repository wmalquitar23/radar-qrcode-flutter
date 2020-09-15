import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar_qrcode_flutter/core/utils/color_util.dart';
import 'package:radar_qrcode_flutter/core/utils/toasts/toast_util.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/success/success_bloc.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key key}) : super(key: key);
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  void _onLoad() async {
    BlocProvider.of<SuccessBloc>(context).add(
      GetUserType(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: BlocConsumer<SuccessBloc, SuccessState>(
          listener: (context, state) {
            if (state is GoToRouteState) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Future.delayed(Duration(seconds: 2));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    state.route, (Route<dynamic> route) => false);
              });
            }
            if (state is VerificationFailure) {
              ToastUtil.showToast(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is SuccessInitial) {
              _onLoad();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/undraw/check.png'),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Success!',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: 26,
                        color: ColorUtil.primaryColor,
                      ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Your mobile number is successfully verified.',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
