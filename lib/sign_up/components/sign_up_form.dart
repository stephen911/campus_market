import 'package:campus_market/screens/sign_in/sign_in.dart';
import 'package:campus_market/sign_up/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/constants.dart';
import '../../components/custom_surfix_icon.dart';
import '../../components/default_button.dart';
import '../../components/form_error.dart';
import '../../components/shared_preferences.dart';
import '../../model/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // String? email;
  // String? password;
  // String? conform_password;
  // String? contact;
  bool isObscured = false;
  bool isObscured1 = false;

  final _auth = FirebaseAuth.instance;

  String? errorMessage;
  User? user;
  bool isLoading = false;

  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    TextFormField buildConformPassFormField() {
      return TextFormField(
        obscureText: isObscured1,
        controller: confirmPassController,
        onSaved: (val) {
          confirmPassController.text = val!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            // return 'Please enter password';
            addError(error: kPassNullError);
            return "";
          } else if (confirmPassController.text != passwordController.text) {
            // return 'Passwords doesn\'t match';
            addError(error: kMatchPassError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "password",
          hintText: 'Confirm Password',
          prefixIcon: const Icon(
            Icons.vpn_key,
            size: 20,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscured1 = !isObscured1;
              });
            },
            child: Icon(
              isObscured ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
            ),
          ),
        ),
      );
      // TextFormField(
      //   controller: confirmPassController,
      //   obscureText: true,
      //   onSaved: (newValue) => confirmPassController.text = newValue!,
      //   onChanged: (value) {
      //     if (value.isNotEmpty) {
      //       removeError(error: kPassNullError);
      //     } else if (value.isNotEmpty &&
      //         passwordController.text == confirmPassController.text) {
      //       removeError(error: kMatchPassError);
      //     }
      //     confirmPassController.text = value;
      //   },
      //   validator: (value) {
      //     if (value!.isEmpty) {
      //       addError(error: kPassNullError);
      //       return "";
      //     } else if ((passwordController.text != value)) {
      //       addError(error: kMatchPassError);
      //       return "";
      //     }
      //     return null;
      //   },
      //   decoration: InputDecoration(
      //     labelText: "Confirm Password",
      //     hintText: "Re-enter your password",
      //     floatingLabelBehavior: FloatingLabelBehavior.always,
      //     suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      //   ),
      // );
    }

    TextFormField buildPasswordFormField() {
      return TextFormField(
        obscureText: isObscured,
        controller: passwordController,
        onSaved: (val) {
          passwordController.text = val!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            // return 'Please enter password';
            addError(error: kPassNullError);
            return "";
          }

          RegExp regex = new RegExp(r'^.{6,}$');
          if (value.isEmpty) {
            addError(error: kPassNullError);
            return "";
            // return ("Password is required");
          }
          if (!regex.hasMatch(value)) {
            // return ("Enter Valid Password(Min. 6 Character)");
            addError(error: kShortPassError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter your password',
          labelText: "Password",
          prefixIcon: const Icon(
            Icons.vpn_key,
            size: 20,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscured = !isObscured;
              });
            },
            child: Icon(
              isObscured ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
            ),
          ),
        ),
      );
      // TextFormField(
      //   controller: passwordController,
      //   obscureText: true,
      //   onSaved: (newValue) => passwordController.text = newValue!,
      //   onChanged: (value) {
      //     if (value.isNotEmpty) {
      //       removeError(error: kPassNullError);
      //     } else if (value.length >= 6) {
      //       removeError(error: kShortPassError);
      //     }
      //     passwordController.text = value;
      //   },
      //   validator: (value) {
      //     if (value!.isEmpty) {
      //       addError(error: kPassNullError);
      //       return "";
      //     } else if (value.length < 5) {
      //       addError(error: kShortPassError);
      //       return "";
      //     }
      //     return null;
      //   },
      //   decoration: InputDecoration(
      //     labelText: "Password",
      //     hintText: "Enter your password",
      //     floatingLabelBehavior: FloatingLabelBehavior.always,
      //     suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      //   ),
      // );
    }

    TextFormField buildEmailFormField() {
      return TextFormField(
        controller: emailController,
        onSaved: (val) {
          emailController.text = val!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          }

          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            // return ("Please Enter a valid email");
            addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "Enter Email",
          hintText: 'Email',
          // suffix: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
          prefixIcon: Icon(
            Icons.email,
            size: 20,
          ),
        ),
      );
      //
    }

    TextFormField buildContactField() {
      return TextFormField(
        keyboardType: TextInputType.number,
        controller: phoneController,
        onSaved: (val) {
          phoneController.text = val!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            // return 'Please enter phone number';
            addError(error: kPhoneNumberNullError);
            return "";
          }
          final max_length = 10;
          if (value.length > max_length) {
            // return "please phone number cannot be more than 10";
            addError(error: kLongPhone);
            return "";
          } else if (value.length < 10) {
            addError(error: kShortPhone);
            return "";
          }

          return null;
        },
        decoration: const InputDecoration(
          labelText: "Enter phone number",
          hintText: "Phone number",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(
            Icons.phone,
            size: 20,
          ),
        ),
      );
    }

    TextFormField buildNameField() {
      return TextFormField(
        controller: nameController,
        onSaved: (val) {
          nameController.text = val!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            // return 'Please enter surname';
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter Full Name',
          labelText: "Full Name",
          prefixIcon: Icon(
            Icons.person,
            size: 20,
          ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 20),
          buildContactField(),
          SizedBox(height: 20),
          buildNameField(),
          SizedBox(height: 20),
          buildPasswordFormField(),
          SizedBox(height: 20),
          buildConformPassFormField(),
          SizedBox(height: 20),
          FormError(errors: errors),
          SizedBox(height: 20),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                signUp(emailController.text, passwordController.text);
              }
            },
          ),
        ],
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text.toLowerCase().trim();
    userModel.phone = phoneController.text;
    userModel.isCreated = true;
    userModel.profile = '';

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }

  void signUp(String email, String password) async {
    try {
      setState(() {
        isLoading = true;
      });
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                // addStringToSF('isLoggedin', 'true'),
                postDetailsToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
          errorMessage = "Network request failed";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
    }
  }
}
