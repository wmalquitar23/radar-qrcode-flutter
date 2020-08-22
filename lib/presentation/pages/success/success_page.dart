import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
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
