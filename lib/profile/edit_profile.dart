import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Color kprimary = const Color(0xFF363f93);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? profileFile;
  dynamic _pickImageError;
  DateTime dob = DateTime.now();
  String name = '';
  String email = '';
  String phone = '';
  String oldPassword = "";
  final _passwordformKey = GlobalKey<FormState>();
  bool chosenDp = false;
  bool hideOldPassword = true;
  bool hideNewPassword = true;
  bool changePassword = false;

//fetch image from device
  Future getLocalImage() async {
    try {
      final pickedFile = File(
        await _imagePicker.pickImage(source: ImageSource.gallery).then(
              (pickedFile) => pickedFile!.path,
            ),
      );
      setState(() {
        profileFile = pickedFile;
        Fluttertoast.showToast(msg: 'Image picked successfully');
      });
    } catch (e) {
      setState(() {
        _pickImageError = e.toString();
        Fluttertoast.showToast(msg: "profile update failed");
      });
    }
    // try {
  }

//save image url to firestore
  Future<void> uploadProfileImage(File _image, String uid) async {
    String imageURL = await uploadFile(_image);
    DocumentReference profilePicsRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    profilePicsRef.update(
      {
        "profile": imageURL,
      },
    );
  }

//upload image to cloud storage then get url
  Future<String> uploadFile(File _image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images/${path.basename(_image.path)}}');
    try {
      UploadTask uploadTask = ref.putFile(_image);
      await uploadTask.whenComplete(() => print('File Uploaded'));
    } on FirebaseException catch (e) {
      print(e.code);
    }
    String? returnURL;
    await ref.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
      // NickNameAvatar.updateURl = fileURL;
    });
    return returnURL!;
  }

//Update new name on cloud
  Future<void> updateName(String name, String uid) async {
    // String imageURL = await uploadFile(_image);
    DocumentReference nameRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    nameRef.update(
      {
        "name": name,
      },
    );
  }

//update email
  Future<void> updateMyEmail(String emailaddress, String uid) async {
    // String imageURL = await uploadFile(_image);

    showDefaultDialogue(
        description: "Change email to $emailaddress",
        onTap: () async {
          Fluttertoast.showToast(msg: "Changing email address ...");
          await _auth
              .signInWithEmailAndPassword(
                  email: _auth.currentUser!.email!,
                  password: oldPasswordController.text.trim())
              .then((value) {
            _auth.currentUser!.updateEmail(emailaddress).then((value) => {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update(
                    {
                      "email": emailaddress,
                    },
                  ),
                  oldPasswordController.text = "",
                  Navigator.pop(context),
                  setState(() {}),
                  Fluttertoast.showToast(msg: "Email updated successfully")
                });
          }).onError((error, stackTrace) {
            Fluttertoast.showToast(msg: error.toString());
          });
        });
  }

  //update password
  Future<void> updateMyPassword(String password) async {
    // String imageURL = await uploadFile(_image);

    showDefaultDialogue(
        description: "Set new password",
        onTap: () async {
          Fluttertoast.showToast(msg: "Changing password ...");
          await _auth
              .signInWithEmailAndPassword(
                  email: _auth.currentUser!.email!,
                  password: oldPasswordController.text.trim())
              .then((value) {
            _auth.currentUser!.updatePassword(password).then((value) => {
                  oldPasswordController.text = "",
                  Navigator.pop(context),
                  setState(() {}),
                  Fluttertoast.showToast(msg: "password updated successfully")
                });
          }).onError((error, stackTrace) {
            Fluttertoast.showToast(msg: error.toString());
          });
        });
  }

//phone
  Future<void> updatePhone(String phone, String uid) async {
    // String imageURL = await uploadFile(_image);
    DocumentReference phoneRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    phoneRef.update(
      {
        "phone": phone,
      },
    );
  }

///// update ends here

  showDefaultDialogue({
    required VoidCallback onTap,
    String? description,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 9, vertical: 25),
            title: Container(
                color: kprimary,
                height: 50,
                child: const Center(
                    child: Text(
                  "Confirm Password",
                  style: TextStyle(color: Colors.white),
                ))),
            titlePadding: EdgeInsets.zero,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(description ?? ""),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: oldPasswordController,
                  decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide()),
                      label: Text(
                        'Enter password',
                        style: TextStyle(
                          color: kprimary,
                        ),
                      )),
                  obscureText: true,
                  onFieldSubmitted: (value) async {
                    setState(() {
                      oldPasswordController.text = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: onTap,
                      style: TextButton.styleFrom(backgroundColor: kprimary),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Save",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                      )),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference profileRef = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimary,
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<DocumentSnapshot>(
          future: profileRef.get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(''),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
                      //backgroundColor: Colors.purple,
                      height: 100,
                      width: 100,
                      child: data['profile'] != null
                          ? CachedNetworkImage(
                              imageUrl: '${data['profile']}',
                              fit: BoxFit.fill,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.asset(
                                "assets/personal.jpg",
                                height: 110,
                                width: 110,
                                fit: BoxFit.cover,
                              )),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      getLocalImage().then(
                        (value) => uploadProfileImage(
                                profileFile!, _auth.currentUser!.uid)
                            .then((value) =>
                                Fluttertoast.showToast(msg: 'Profile updated <--')),
                      );
                    },
                    child: Text(
                      'Change profile photo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kprimary,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12),
                    child: TextFormField(
                      //controller: nameController,
                      initialValue: data['name'] == null
                          ? 'Enter your name'
                          : '${data['name']}',
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()),
                          label: Text(
                            'Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kprimary),
                          )),
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      onFieldSubmitted: (value) async {
                        setState(() {
                          name = value;
                        });

                        updateName(name, _auth.currentUser!.uid).then((value) =>
                            Fluttertoast.showToast(msg: 'Name updated'));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12),
                    child: TextFormField(
                      //controller: userNameController,
                      initialValue: data['email'] == null
                          ? 'loading ...'
                          : '${data['email']}',
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()),
                          label: Text(
                            'Email address',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kprimary),
                          )),
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 16),
                      onFieldSubmitted: (value) async {
                        setState(() {
                          email = value;
                        });
                        updateMyEmail(email.trim(), _auth.currentUser!.uid);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12),
                    child: TextFormField(
                      //controller: phoneController,
                      initialValue: data['phone'] == null
                          ? 'enter phone number'
                          : '${data['phone']}',
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()),
                          label: Text(
                            'enter phone number',
                            style: TextStyle(
                                color: kprimary, fontWeight: FontWeight.bold),
                          )),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onFieldSubmitted: (value) async {
                        setState(() {
                          phone = value;
                        });
                        updatePhone(phone, _auth.currentUser!.uid).then(
                            (value) => Fluttertoast.showToast(
                                msg: 'Phone Number updated'));
                      },
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            changePassword = !changePassword;
                          });
                        },
                        child: Text(
                          'Change password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kprimary,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  changePassword
                      ? Form(
                          key: _passwordformKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: newPasswordController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide()),
                                    label: Text(
                                      'Enter new password',
                                      style: TextStyle(
                                        color: kprimary,
                                      ),
                                    )),
                                obscureText: hideNewPassword,
                                onFieldSubmitted: (value) async {
                                  setState(() {
                                    oldPasswordController.text = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: confirmPasswordController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide()),
                                    label: Text(
                                      'Confirm new password',
                                      style: TextStyle(
                                        color: kprimary,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: hideNewPassword
                                          ? const Icon(Icons.remove_red_eye)
                                          : const Icon(
                                              Icons.remove_red_eye_outlined),
                                      onPressed: () {
                                        hideNewPassword = !hideNewPassword;
                                      },
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Feilds cannot be empty";
                                  } else if (newPasswordController.text !=
                                      confirmPasswordController.text) {
                                    return "Password do not much";
                                  } else if (newPasswordController.text.length <
                                      5) {
                                    return "Password is too short";
                                  }
                                  return null;
                                },
                                obscureText: hideNewPassword,
                                onFieldSubmitted: (value) {
                                  confirmPasswordController.text = value;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: () {
                                      if (_passwordformKey.currentState!
                                          .validate()) {
                                        _passwordformKey.currentState!.save();
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: kprimary,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12)),
                                    child: const Text(
                                      "Set new password",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 40,
                  ),
                ]),
              );
            }
          },
        ),
      ),
    );
  }
}
