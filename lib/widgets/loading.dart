import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalLoading extends StatelessWidget {
 final bool light;

const GlobalLoading({Key? key, required this.light}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //loadingLabel(),
        loadingCard(light),
        loadingCard(light),
        loadingCard(light),
        loadingCard(light),
        loadingCard(light),
      ],
    );
  }

  Widget loadingCard(bool light) {
    return Card(
      elevation: 3,
      child: Container(
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: light ? Colors.grey[100] : Colors.grey[700] ,
          highlightColor: light ? Colors.grey[300] :  Colors.grey[800],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                width: double.infinity,
                height: 130,
              ),
              // Container(
              //   width: double.infinity,
              //   height: 30,
              //   color: Colors.white,
              // ),
              SizedBox(
                height: 5,
              ),
              Container(
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                width: 300,
                height: 20,
                //color: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    width: 280,
                    height: 20,
                    //color: Colors.white,
                  ),
                  Container(
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    width: 15,
                    height: 20,
                    //color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.blue[300],
        highlightColor: Colors.blue[600],
        child: Column(
          children: <Widget>[
            Container(
              width: 200,
              height: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
