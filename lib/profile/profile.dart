import 'package:campus_market/model/user_model.dart';
import 'package:campus_market/profile/edit_profile.dart';
import 'package:campus_market/screens/sign_in/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Color kprimary = const Color(0xFF363f93);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data;
                  return Column(
                    children: [
                      Container(
                        height: size.height * 0.26,
                        width: double.infinity,
                        color: Colors.deepOrangeAccent,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                               
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: snapshot.data!['profile'] != null
                                      ? (loggedInUser.profile!.isEmpty)
                                          ? Image.asset(
                                              "assets/profile.png",
                                              height: 110,
                                              width: 110,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              loggedInUser.profile.toString(),
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                      : Container()),
                            ),
                            
                            Text(
                              snapshot.data!['name'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Text(
                              snapshot.data!['email'],
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: ListView(
                            children: [
                              profileTile(
                                  icon: Icons.person,
                                  title: 'Edit profile',
                                  color: Colors.blue,
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditProfile()));
                                  }),
                              profileTile(
                                  icon: Icons.settings,
                                  title: 'Settings',
                                  color: Colors.red),
                              profileTile(
                                  icon: Icons.help_center,
                                  title: 'Help Center',
                                  color: Colors.green),
                              profileTile(
                                  icon: Icons.person_add,
                                  title: 'Invite a friend',
                                  color: Colors.orange),
                              profileTile(
                                  icon: Icons.exit_to_app,
                                  title: 'Log Out',
                                  color: Colors.black,
                                  onTap: () {
                                    logout(context);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: kprimary),
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget profileTile(
      {required IconData icon,
      required String title,
      required Color color,
      VoidCallback? onTap}) {
    return Card(
      // elevation: 1,
      child: ListTile(
        hoverColor: Colors.blueAccent,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        shape: const Border(
          bottom: BorderSide(
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                )),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 17),
        ),
        onTap: onTap ?? () {},
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addStringToSF('isLoggedin', 'false');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
