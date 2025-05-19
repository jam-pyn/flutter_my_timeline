import 'package:flutter/material.dart';
import 'package:flutter_my_timeline/provider/post_provider.dart'; // import Provider ที่ใช้เพิ่มโพสต์
import 'package:provider/provider.dart'; // สำหรับใช้งาน Provider

class NewPostPages extends StatelessWidget {
  final formkey = GlobalKey<FormState>(); // ใช้สำหรับควบคุมการ validate ของฟอร์ม
  final postMessgeController = TextEditingController(); // ใช้รับค่าข้อความที่พิมพ์ใน TextField

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('สร้างโพสต์ใหม่')), // แถบบนของหน้า
      body: Form(
        key: formkey, // ผูก Form นี้กับ formkey เพื่อใช้ validate
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10), // ขอบรอบ TextFormField
              child: TextFormField(
                controller: postMessgeController, // ควบคุมค่าที่ผู้ใช้กรอก
                autofocus: true, // เมื่อเปิดหน้ามาให้โฟกัสช่องกรอกข้อความ
                maxLines: 3, // ให้พิมพ์ได้หลายบรรทัด
                validator: (String? text) {
                  // ฟังก์ชันตรวจสอบข้อความที่กรอก
                  if (text == null || text.isEmpty) {
                    return 'กรุณากรอกว่ากำลังทำอะไรอยู่'; // ถ้าเว้นว่าง
                  }
                  if (text.length < 5) {
                    return 'สถานะต้องมีความยาวไม่ต่ำกว่า 5 ตัวอักษร'; // ถ้าสั้นเกินไป
                  }
                  return null; // ไม่มี error
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'คุณกำลังทำอะไรอยู่', // ข้อความแนะนำในช่องกรอก
                ),
              ),
            ),
            Expanded(child: SizedBox()), // ดันปุ่มลงไปล่างสุดของหน้าจอ
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.maxFinite, // ให้ปุ่มกว้างเต็มหน้าจอ
                child: ElevatedButton(
                  onPressed: () {
                    // เมื่อต้องการโพสต์
                    if (formkey.currentState?.validate() == true) {
                      // ตรวจสอบว่าผ่าน validator
                      var message = postMessgeController.text; // ดึงข้อความจากช่องกรอก
                      print(message); // แสดงข้อความใน console (สำหรับ debug)

                      // เข้าถึง PostProvider เพื่อเพิ่มโพสต์ใหม่
                      var postProvider = Provider.of<PostProvider>(
                        context,
                        listen: false, // ไม่ต้อง rebuild UI เมื่อข้อมูลเปลี่ยน
                      );
                      postProvider.addNewPost(message); // เพิ่มโพสต์
                      Navigator.pop(context); // ปิดหน้านี้ กลับไปหน้าหลัก
                    }
                  },
                  child: Text('Post'), // ข้อความบนปุ่ม
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
