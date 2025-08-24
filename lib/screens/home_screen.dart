import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotlight_hub/screens/chatroom.dart';
import 'package:spotlight_hub/screens/notification_screen.dart';
import 'package:spotlight_hub/screens/order_page.dart';
import 'package:spotlight_hub/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<HomeScreen> {
  bool isLoading = false;
  Map<String, dynamic>? userCredentialMap;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await firestore
        .collection('users')
        .where("Name", isEqualTo: _search.text)
        .get()
        .then((value) {
          setState(() {
            isLoading = false;
            userCredentialMap = value.docs[0].data();
          });
          print(userCredentialMap);
        });
  }

  logout() async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        title: Text("Spotlight Hub"),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          ElevatedButton(
            child: Icon(Icons.logout),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(
                  
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Center(
                                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-0.1),
                  child: Container(
                    width: 380,
                    height: 250,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(10, 10),
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E1E2C), Color(0xFF23232F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 16),
                       Padding(padding: EdgeInsets.only(bottom:  70) ,
                       child:  CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                        child: Icon(Icons.person_2, color: Colors.white),
                       ),),
                        const SizedBox(width: 8),
                        Expanded(
                          
                          child: Padding(padding: EdgeInsets.only(bottom: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nani",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.lightBlue,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "+91 9765195965",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                        255,
                                        230,
                                        222,
                                        222,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "5",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.redAccent,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Moinabad",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))
                        ),
                      ]
                    ),
                  ),
                                ),
                              ),
                ),SizedBox(height: 16),
                SizedBox(
                  height: size.height / 14,
                  width: size.width / 1.2,
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search_off_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: onSearch, child: Text("Search")),
                SizedBox(height: 20),
                userCredentialMap == null
                    ? Container()
                    : ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                            auth.currentUser?.displayName ?? "Unknown",
                            userCredentialMap?['Name'] ?? "Unknown",
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChatRoom(
                                userCredentialMap: userCredentialMap ??{},
                                chatRoomId: roomId,
                              ),
                            ),
                          );
                        },
                        leading: Icon(Icons.account_box, color: Colors.black),
                        title: Text(
                          userCredentialMap?['Name'] ?? ["Error"],
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        subtitle: Text(
                          userCredentialMap?['Email'] ?? "No Email",
                        ),
                        trailing: Icon(Icons.chat, color: Colors.black),
                      ),

                SizedBox(height: 100),
                FloatingActionButton(
                  child: Text("Order"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Orderpage()),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
