import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  bool _isFollowing = false;
  int _followerCount = 15710;
  int _likesCount = 874;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Center(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(Icons.person_rounded, size: 50, color: Colors.white),
                ),
                SizedBox(height: 30),
                Text(
                  'Daniyar J',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '$_followerCount',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: [
                          Text(
                            '$_likesCount',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Likes ❤️',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggleFollow,
                      icon: Icon(_isFollowing ? Icons.check : Icons.person_add,
                          color: Colors.blueAccent,
                      ),
                      label: Text(_isFollowing ? 'Following' : 'Follow',
                          style: TextStyle(color: Colors.blueAccent,),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: _incrementLike,
                      icon: Icon(Icons.favorite,
                          color: Colors.blueAccent,),
                      label: Text(
                        'Like',
                        style: TextStyle(color: Colors.blueAccent),
                        ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _reset,
                  child: Text(
                    'Reset',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
      if (_isFollowing) {
        _followerCount++;
      } else {
        _followerCount--;
      }
    });
  }

  void _incrementLike() {
    setState(() {
      _likesCount++;
    });
  }

  void _reset() {
    setState(() {
      _isFollowing = false;
      _followerCount = 15710;
      _likesCount = 874;
    });
  }
}


