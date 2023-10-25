import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/data/comments_data.dart';
import 'package:plant/data/posts_database.dart';
import 'package:plant/screens/home/home_screen.dart';
import 'package:plant/screens/post/write_edit_post/write_post.dart';

import '../../domain/Comments.dart';
import '../../domain/post_details.dart';
import 'comments/comments_sheet.dart';

class Post extends StatefulWidget {
  static const String id = "Post";
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  PostsDatabase _postsDatabase = PostsDatabase();
  CommentsDataFetching _commentsDataFetching = CommentsDataFetching();
  List<PostInformation> posts = [];
  List<Comments> commentList = [];
  late String _currentComment;
  late String _date;
  late String _time12;
  late String _time24;
  late int _minValue;
  bool isCommented = false;
  TextEditingController _textEditingController = TextEditingController();

  void bottomSheetComment({required int index, required String postId}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child('comments/$postId')
                    .onValue,
                builder: (context, snapshot) {
                  List<CommentsWidget> commentsWidgetList = [];
                  if (snapshot.hasData) {
                    DataSnapshot data = snapshot.data!.snapshot;

                    if (data.value != null &&
                        data.value is Map<Object?, Object?>) {
                      Map<Object?, Object?> comments =
                          data.value as Map<Object?, Object?>;
                      List<Map<Object?, Object?>> commentingList = [];
                      comments.forEach((key, value) {
                        if (value is Map<Object?, Object?>) {
                          commentingList.add(value);
                        }
                      });

                      commentingList.sort((a, b) {
                        final int valueA = (a['value'] as int?) ?? 0;
                        final int valueB = (b['value'] as int?) ?? 0;
                        return valueB.compareTo(valueA);
                      });

                      for (var commentsData in commentingList) {
                        final commentText = commentsData['commentDetails'];
                        final commentingTime = commentsData['commentingTime'];
                        final commentingDate = commentsData['commentingDate'];
                        final commentorPhoto = commentsData['commentorPhoto'];
                        final commentorName = commentsData['commentorName'];

                        final commentswidgetMaking = CommentsWidget(
                          commentorName: commentorName.toString(),
                          commentorPhoto: commentorPhoto.toString(),
                          comments: commentText.toString(),
                          commentingTime: commentingTime.toString(),
                          commentingDate: commentingDate.toString(),
                        );
                        commentsWidgetList.add(commentswidgetMaking);
                      }
                      return ListView(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 20.0,
                        ),
                        children: commentsWidgetList,
                      );
                    }
                  }
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "No comments",
                        style: TextStyle(
                          fontSize: 50,
                          color: kCartBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.messenger,
                        size: 60,
                        color: kCartBackgroundColor,
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 6,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (value) {
                          _currentComment = value;
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: () async {
                        List<dynamic> list = getDateAndTime();
                        _date = list[0];
                        _time12 = list[1];
                        _time24 = list[2];
                        _minValue = list[3];

                        String _commentId =
                            (HomeScreen.user.userName) + (_minValue.toString());
                        Comments comments = Comments(
                            postID: posts[index].postID,
                            commentDetails: _currentComment,
                            commentorID: HomeScreen.user.userName,
                            commentorPhoto: HomeScreen.user.userImage,
                            commentID: '${_commentId}',
                            commentingDate: _date,
                            commentingTime: _time12,
                            commentorName: 'Atik',
                            value: _minValue);
                        bool done = await _commentsDataFetching.addComments(
                            postId: comments.postID, comments: comments);
                        if (done) {
                          _currentComment = "";
                          _textEditingController.clear();
                        }
                        print(done);
                      },
                      icon: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getDescriptionWithImageOrNot(int index) {
    if (posts[index].plantPhoto == "n") {
      return Text(
        posts[index].plantDescription,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          posts[index].plantDescription,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Center(
          child: Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: FutureBuilder(
              future:
                  precacheImage(NetworkImage(posts[index].plantPhoto), context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: Image.network(posts[index].plantPhoto),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Future<bool> assignList() async {
    posts = await _postsDatabase.getAllPosts();
    if (posts.isEmpty) {
      return true;
    }
    return false;
  }

  List<Widget> postsWidget() {
    List<Widget> tempWidget = [];
    for (int i = 0; i < posts.length; i++) {
      tempWidget.add(Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: kCartBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    /**
                 * For profile picture
                 */
                    FutureBuilder(
                      future: precacheImage(
                          NetworkImage(posts[i].userPhoto), context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                            radius: 30.0,
                            backgroundColor: Colors.cyan,
                            backgroundImage: NetworkImage(posts[i].userPhoto),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /**
                     * For user name
                     */
                        Text(
                          posts[i].userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          posts[i].date,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                getDescriptionWithImageOrNot(i),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    bottomSheetComment(index: i, postId: posts[i].postID);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 40,
                        ),
                        Text(
                          "Comment",
                          style: TextStyle(
                            fontSize: 30,
                            color: kTextColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            color: kBackgroundColor,
            height: 25,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ));
    }
    return tempWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      margin: EdgeInsets.all(15),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, WritePost.id);
                },
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        "Add what on your mind",
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, WritePost.id);
                      },
                      child: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.black,
                        size: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FutureBuilder<bool>(
                future: assignList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return snapshot.data == true
                          ? CircularProgressIndicator()
                          : Column(
                              children: postsWidget(),
                            );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
