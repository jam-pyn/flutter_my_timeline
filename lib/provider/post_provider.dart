import 'package:flutter/foundation.dart'; // ใช้สำหรับ ChangeNotifier ที่ทำให้สามารถแจ้งเตือน Widget ที่ฟัง Provider นี้อยู่ได้

// สร้างคลาส PostProvider ซึ่งใช้ร่วมกับ Provider และสามารถแจ้งเตือน Widget ได้เมื่อข้อมูลเปลี่ยน
class PostProvider with ChangeNotifier {
  // สร้างตัวแปร _posts สำหรับเก็บโพสต์ เป็นแบบ private (ใช้ _ นำหน้า)
  List<String> _posts = ['next-flow', 'Hello world']; // ข้อมูลเริ่มต้น 2 โพสต์

  // Getter เพื่อให้เรียกดูโพสต์จากภายนอกได้
  List<String> get posts => _posts;

  // เมธอดสำหรับเพิ่มโพสต์ใหม่
  addNewPost(String post) {
    _posts.insert(0, post); // แทรกโพสต์ใหม่ไว้ตำแหน่งแรกของ list (ล่างสุด = โพสต์เก่าสุด)
    notifyListeners(); // แจ้งเตือน Widget ที่ใช้ PostProvider ว่าข้อมูลเปลี่ยนแล้ว เพื่อให้ Refresh UI ใหม่
  }
}
