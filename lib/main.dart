import 'package:flutter/material.dart'; // ใช้สำหรับ UI พื้นฐานของ Flutter
import 'package:flutter_my_timeline/pages/new_post_pages.dart'; // หน้าสำหรับเพิ่มโพสต์ใหม่
import 'package:flutter_my_timeline/provider/post_provider.dart'; // Provider สำหรับจัดการโพสต์
import 'package:provider/provider.dart'; // แพ็กเกจสำหรับ state management ด้วย Provider
import 'package:provider/single_child_widget.dart'; // ใช้เมื่อมีหลาย provider

void main() {
  runApp(MyApp()); // เริ่มแอปด้วย widget MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ใช้ MultiProvider ในกรณีมีหลาย Provider
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(
          // สร้าง Provider สำหรับ PostProvider
          create: (BuildContext context) => PostProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Nextflow Personal Post', // ชื่อแอป
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Personal Post'), // หน้าหลักของแอป
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title})
    : super(key: key); // รับ title มาจาก MyApp

  final String title; // ชื่อของหน้า

  @override
  _MyHomePageState createState() => _MyHomePageState(); // สร้าง state
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // แสดงชื่อหน้าในแถบด้านบน
        backgroundColor: Colors.deepPurple, // สีของ AppBar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), // ปุ่ม "+" สำหรับเพิ่มโพสต์
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return NewPostPages(); // เมื่อกดจะเปิดหน้าเพิ่มโพสต์ใหม่
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        // Consumer ใช้รับข้อมูลจาก PostProvider และอัปเดต UI เมื่อมีการเปลี่ยนแปลง
        builder: (BuildContext context, PostProvider provider, Widget? child) {
          return ListView.builder(
            // แสดงรายการโพสต์ทั้งหมด
            itemCount: provider.posts.length, // จำนวนโพสต์ทั้งหมด
            itemBuilder: (BuildContext context, int index) {
              var post = provider.posts[index]; // ดึงข้อความโพสต์แต่ละรายการ
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10), // ระยะห่างรอบโพสต์
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '10 min ago', // เวลาที่โพสต์ (ยังเขียนตายตัว)
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10), // ระยะห่างก่อนข้อความ
                        Text(
                          post,
                          style: TextStyle(fontSize: 18),
                        ), // ข้อความโพสต์
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ), // เส้นแบ่งรายการโพสต์
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
