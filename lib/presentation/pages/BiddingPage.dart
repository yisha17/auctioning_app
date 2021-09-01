import 'package:flutter/material.dart';

class BiddingPage extends StatefulWidget {
  @override
  BiddingPageState createState() {
    return BiddingPageState();
  }
}

class BiddingPageState extends State<BiddingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                child: Image.network(
                  'https://images.unsplash.com/photo-1611182911609-040cad8c05a4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1029&q=80',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              Positioned(
                left: 0,
                top: MediaQuery.of(context).size.height * 0.2,
                child: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {},
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 0,
                top: MediaQuery.of(context).size.height * 0.2,
                child: IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {},
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Color(0xfff06292),
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  'Photograph Equipment',
                  style: TextStyle(color: Color(0xFF42A5F5), fontSize: 34),
                ),
                Divider(
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Initial Price: 24000Birr',
                      style: TextStyle(fontSize: 27, color: Color(0xFF42A5F5)),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
