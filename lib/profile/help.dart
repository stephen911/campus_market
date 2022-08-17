import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  List myFAQList = [
    {
      "title": "How do i buy a product?",
      "answers":
          " An order is simple and easy to place. This can be simply be selecting the particular product and then clicking on the add to cart or buy now button. However adding to cart doesn't mean the product has been ordered. kindly click on buy now button to that appears on the cart. "
    },
    {
      "title": "How many days will the product be delivered?",
      "answers":
          "Usually within 5 minutes, you must check your notification page or order screen to check your processing of the order. We are happy to have you checking on us and for that matter, we will check on you too all the time. a call will be made by a rider to deliver the product immediately after the order has been made successfully"
    },
    {
      "title": "Why do i need to create an account?",
      "answers":
          "Users can only buy a product if they have account. This is a requirement to provide extra features and also get your details for regular check up and delivery of the product. Gathered details are kept safe and secured from all other  users of the system. creating account is just one step away. We assured that you will be able to create a new account without any difficulty"
    },
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset(
                "assets/help.jpg",
                fit: BoxFit.fill,
                height: height * 0.45,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "hello!, How can we help you?",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 20),
            for (int i = 0; i < myFAQList.length; i++)
              Expansion(
                  title: myFAQList[i]["title"],
                  answers: myFAQList[i]["answers"]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    // TODO:implement the email us: put email address
                    launch(
                        'mailto:adanielagyei@gmail.com?subject=help center support');
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 80,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 66, 10, 163),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "email us",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // TODO:implement the call us: enter valid number
                    launch('tel:+233545934396');
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 80,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 66, 10, 163),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "call support",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Expansion({required String title, required String answers}) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.grey[200],
      leading: Icon(Icons.question_mark),
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            answers,
            style: TextStyle(
              wordSpacing: 0.8,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
