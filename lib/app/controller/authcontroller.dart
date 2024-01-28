import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:mvc_app/resources/pages/auth/loginpage.dart';
import 'package:mvc_app/resources/pages/auth/otppage.dart';
import 'package:mvc_app/resources/pages/homepage.dart';

class AuthenticationController extends GetxController {
  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );
  final isLoading = false.obs;
  RxString token = ''.obs;
  final box = GetStorage();
  final Dio _dio = Dio();
  void register(String name, String email, String phone, String password,
      String text) async {
    Map<String, dynamic> requestData = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': password,
    };
    printInfo(info: requestData.toString());
    try {
      String apiUrl = 'http://192.168.100.253:8000/api/register';
      var response = await _dio.post(
        apiUrl,
        data: requestData,
      );

      if (response.statusCode == 201) {
        logger.i(response.data);
        Get.snackbar("Sucess", "Registration Successfull");
        box.write('token', response.data["token"]);
        Get.offAll(const OtpPage());
      } else {
        logger.i(response.data);
        Get.snackbar("Error", "Registration error");
      }
    } catch (e) {
      logger.e('Error during registration: $e');
    }
  }

  login(String email, String password) async {
    Map<String, dynamic> data = {'email': email, 'password': password};
    try {
      isLoading.value = true;
      String apiUrl = 'http://192.168.100.253:8000/api/login';
      var response = await _dio.post(apiUrl,
          data: data,
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseData = response.data;
        if (responseData.containsKey('token')) {
          token.value = responseData['token'];
          box.write('token', token.value);
          Get.offAll(() => const loginpage());
          print('LogIn successful. Token: $token');
          Get.snackbar("Success", "Log In Successfull");
        } else {
          print('Token not found in the response data.');
        }
      } else {
        print('LogIn failed. Status code: ${response.statusCode}');
        Get.snackbar("Error", "Log in error");
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }

  otppin(String pin) async {
    Map<String, dynamic> submitOtp = {'otp': pin};
    try {
      String apiUrl = 'http://192.168.100.253:8000/api/phone/verify/';

      var token = box.read('token');
      if (token == null) {
        print('Token is null. User not authenticated.');
        return;
      }
      logger.i('Token: $token');
      var response = await _dio.post(apiUrl,
          data: submitOtp,
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      logger.i('Response Data: ${response.data}');
      logger.i('Response Headers: ${response.headers}');

      if (response.statusCode == 201) {
        logger.i(response.data);
        Get.offAll(() => const loginpage());
      } else {
        print('LogIn failed. Status code: ${response.statusCode}');
        Get.snackbar("Error", "Verify in error");
      }
    } on DioException catch (e) {
      print('Error during verifying: $e');
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        var response = await _dio.post(
          'http://192.168.100.253:8000/api/google/login',
          data: {
            "name": googleUser.displayName,
            "email": googleUser.email,
            "image": googleUser.photoUrl,
            "access_token": googleAuth.accessToken,
          },
        );
        logger.i(response);
        if (response.statusCode == 201) {
          Get.offAll(() => const loginpage());
          var responseData = response.data();
          token.value = responseData["token"];
          box.write('token', response.data["token"]);
          isLoading.value = false;
          logger.d(response.data);
        } else {
          logger.e('login failed. Status code: ${response.statusCode}');
          Get.snackbar("Error", "login is error");
        }
      } else {
        logger.e("sign in canceled or failed");
      }
    } catch (e) {
      print("Error during Google Sign In: $e");
    }
  }
}
