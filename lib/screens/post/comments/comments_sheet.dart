import 'package:flutter/material.dart';

import '../../../constants.dart';

class CommentsWidget extends StatelessWidget {
  String commentorPhoto;
  String comments;
  String commentingTime;
  String commentingDate;
  String commentorName;
  CommentsWidget({
    required this.commentorName,
    required this.commentorPhoto,
    required this.comments,
    required this.commentingTime,
    required this.commentingDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                child: FutureBuilder(
                  future: precacheImage(NetworkImage(commentorPhoto), context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return CircleAvatar(
                        backgroundImage: Image.network(commentorPhoto).image,
                      );
                    }
                  },
                ),
              ),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: kCartBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            commentorName,
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            comments,
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          commentingTime,
                          style: TextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          commentingDate,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
