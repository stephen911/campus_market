import 'package:campus_market/components/constants.dart';
import 'package:campus_market/screens/sign_in/sign_in.dart';
import 'package:campus_market/sign_up/components/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10), // 4%
                Text("Register Account", style: headingStyle),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Complete your details with us for best features",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                SignUpForm(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [AlreadyHaveAccount()],
                ),
                SizedBox(height: 15),
                Text(
                  'By continuing... you confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 10),

                Text("View Terms and Condition here")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: Text(
            "Sign in",
            style: TextStyle(fontSize: 16, color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
