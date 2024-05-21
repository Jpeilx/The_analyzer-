import 'package:flutter/material.dart';

class TweetBox extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String handle;
  final String timestamp;
  final String content;

  TweetBox({
    required this.profileImageUrl,
    required this.username,
    required this.handle,
    required this.timestamp,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            '@$handle',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            '$timestamp'.substring(0,19),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Text(content),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.comment, color: Colors.grey),
                Icon(Icons.repeat, color: Colors.grey),
                Icon(Icons.favorite_border, color: Colors.grey),
                Icon(Icons.share, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
