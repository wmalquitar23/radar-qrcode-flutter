import 'package:flutter/material.dart';
import 'package:radar_qrcode_flutter/core/utils/routes/routes_list.dart';
import 'package:radar_qrcode_flutter/presentation/bloc/success/success_bloc.dart';

import '../../../dependency_instantiator.dart';

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void didChangeDependencies() {
    sl<SuccessBloc>().load(onboard);
    super.didChangeDependencies();
  }

  void onboard() async {
    Navigator.pushNamed(context, INDIVIDUAL_HOME_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
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
                    color: Theme.of(context).primaryColor,
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
        ),
      ),
    );
  }
}
