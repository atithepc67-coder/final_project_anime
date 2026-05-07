import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_response.dart';

class AuthService {
  static const String baseUrl = 'https://www.melivecode.com';
  static const String _tokenKey = 'access_token';

  // ฟังก์ชัน LOGIN หลัก
  // รับ username & password, คืนค่า LoginResponse
  Future<LoginResponse> login(String username, String password) async {
    try {
      // ขั้นตอนที่ 1: สร้าง API URL
      final url = Uri.parse('$baseUrl/api/login');

      // ขั้นตอนที่ 2: สร้าง request body (สิ่งที่ส่งไปยัง API)
      final body = jsonEncode({
        'username': username,
        'password': password,
        'expiresIn': 60000, // Token หมดอายุใน 60 วินาที (60000 ms)
      });

      // ขั้นตอนที่ 3: ส่ง POST request ไปยัง API
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // ขั้นตอนที่ 4: ตรวจสอบว่า request สำเร็จหรือไม่ (status 200-299)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // แปลง response ที่สำเร็จ
        final data = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(data);

        // บันทึก token ไว้ใน local storage
        if (loginResponse.isValid) {
          await saveToken(loginResponse.accessToken!);
        }

        return loginResponse;
      }

      // ขั้นตอนที่ 5: จัดการ error responses
      final errorData = jsonDecode(response.body);
      final message = errorData['message'] ?? 'Request failed';

      // คืนค่า error message ที่เหมาะสมตาม status code
      if (response.statusCode == 400) {
        return LoginResponse(
          status: 'error',
          message: 'Please enter both username and password',
        );
      } else if (response.statusCode == 401) {
        return LoginResponse(
          status: 'error',
          message: 'Invalid username or password',
        );
      }
      return LoginResponse(status: 'error', message: message);

    } catch (e) {
      // จัดการ network errors (ไม่มี internet, server ล้ม, ฯลฯ)
      return LoginResponse(
        status: 'error',
        message: 'Connection error. Please check your internet',
      );
    }
  }

  // บันทึก JWT token ไว้ใน device storage
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // รับ token ที่บันทึกไว้จาก device storage
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // ลบ token (logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // ตรวจสอบว่าผู้ใช้ล็อกอินอยู่หรือไม่
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}