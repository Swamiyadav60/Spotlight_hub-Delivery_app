import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotlight_hub/screens/chatroom.dart';
import 'package:spotlight_hub/screens/helpscreen.dart';
import 'package:spotlight_hub/screens/menuscreen.dart';
import 'package:spotlight_hub/screens/signin_screen.dart';

class Phonepe2 extends StatefulWidget {
  const Phonepe2({super.key});

  @override
  State<Phonepe2> createState() => _Phonepe2State();
}

class _Phonepe2State extends State<Phonepe2> {
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        // Background image covering app bar and promo section
                        Container(
                          height: 300,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/delivery-boy-ride-scooter-service-260nw-573596857.jpg",
                              ), // replace with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              title: const Text(
                                'Spotlight hub',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              actions: [
                                IconButton(
                                  icon: const Icon(Icons.help_outline),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Helpscreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 24),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 140,
                                      right: 260,
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Helpscreen(),
                                          ),
                                        );
                                      },

                                      child: Text(
                                        'Check Offer ➔',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      height: 40,
                      width: 500,
                      child: Text(
                        'Delivery Boy Detail ➔',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.all(15),
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
                                color: Colors.black.withValues(alpha: 0.9),
                                blurRadius: 20,
                                offset: const Offset(20, 10),
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
                              Padding(
                                padding: EdgeInsets.only(bottom: 70),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 50,
                                  child: Icon(
                                    Icons.person_2,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 40),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 500,
                          child: Text(
                            'Menu List ➔',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuScreen(),
                              ),
                            );
                          },
                          child: Icon(Icons.fastfood_sharp),
                        ),
                      SizedBox(height: 8,),
                      SizedBox(height: 16),
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
                ),SizedBox(height: 10),
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
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
