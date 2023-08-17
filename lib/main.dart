import 'package:bkashdsocalculator/Pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance
      .idTokenChanges()
      .listen((User? user) {
    if (user == null) {
      runApp(MaterialApp(home: loginScreen(),debugShowCheckedModeBanner: false,));
    } else {
      runApp(MyApp());
    }
  });
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Raihan Hossain'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> _agentList = FirebaseFirestore.instance.collection('Road-390').snapshots();
  CollectionReference isComplete = FirebaseFirestore.instance.collection('Road-390');
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(child: Text("Profile"),onTap: () {

              },),
              PopupMenuItem(child: Text("Logout"),onTap: () {
                FirebaseAuth.instance.signOut();
              },),
            ];
          },child: CircleAvatar(
            backgroundImage: NetworkImage("https://scontent.fdac138-1.fna.fbcdn.net/v/t39.30808-6/315600015_1742983552739480_1620697353844158411_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=ydk2lKbw0M0AX8wlY8u&_nc_oc=AQnq8JrA5NVxcGicAaHPRgCew81kOIvAxgLpeRijZtW1F4YIvTwtvNar_cobVLmxMVE&_nc_ht=scontent.fdac138-1.fna&oh=00_AfCNq_AK5MakBBzXHIwwv5T9o8_k7n_livm0Ee5O_X3zHQ&oe=6465903F"),
          ),),

        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _agentList,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Card(
                color:data['complete']?Colors.green:data['due']!=0||data['due']!=0?Colors.redAccent:Colors.amberAccent,
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  dense: true,
                  title: Text(data['Name']),
                  hoverColor: Colors.blue,
                  subtitle: Row(children: [
                    Text("Cash : ${data['cash']}"),
                    Container(width: 10,),
                    Text("Lefting : ${data['load']}"),
                    Container(width: 10,),
                    Text("pending : ${data['pending']}"),
                    Container(width: 10,),
                    Text("due : ${data['due']}"),
                  ],),
                  leading: Checkbox(value: data['complete'], onChanged: (value) {
                    isComplete
                        .doc(data['Name'])
                        .update({'complete': !data['complete'],'due':0,'pending': 0})
                        .then((value) => print("User Updated"))
                        .catchError((error) => print("Failed to update user: $error"));
                  },),
                  enabled: true,
                  trailing: PopupMenuButton(itemBuilder: (context) {
                    return [
                      PopupMenuItem(child: Text("Reset"),onTap: () {
                        isComplete
                            .doc(data['Name'])
                            .update({'complete': false,'due':0, 'load':0, 'pending': 0, 'cash':0})
                            .then((value) => print("User Updated"))
                            .catchError((error) => print("Failed to update user: $error"));
                      },),
                      PopupMenuItem(child: Text("Edit"),onTap: () {

                      },),
                      PopupMenuItem(child: Text("Delete"),onTap: () {

                      },),
                    ];
                  },),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: AnimatedFloatingActionButton(
    //Fab list
    fabButtons: <Widget>[
      Container(
        child: FloatingActionButton(
          onPressed: null,
          heroTag: "btn1",
          tooltip: 'Add New Agent',
          child: Icon(Icons.add),
        ),
      ), Container(
        child: FloatingActionButton(
          onPressed: null,
          heroTag: "btn2",
          tooltip: 'Agent Payment',
          child: Icon(Icons.add),
        ),
      )
    ],
    colorStartAnimation: Colors.blue,
    colorEndAnimation: Colors.red,
    animatedIconData: AnimatedIcons.add_event //To principal button
    ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
