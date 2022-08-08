import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Color kprimary = const Color(0xFF363f93);

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            height: size.height * 0.36,
            width: double.infinity,
            color: kprimary,
            child: Column(
              children: [
                SizedBox(height: 25,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.white)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: AssetImage(
                        "assets/profile.png",
                      ),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Asante Daniel",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  "adanielagyei@gmail.com",
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
                      onTap: () {}),
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
                      onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
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
            color: Colors.black26,
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
}
