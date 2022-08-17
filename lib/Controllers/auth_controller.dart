import 'package:foodies/Models/sign_in_body_model.dart';
import 'package:foodies/Models/sign_up_body_model.dart';
import 'package:foodies/Data/Repository/auth_repo.dart';
import 'package:foodies/Models/response_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  //
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

// ******************* Registration *******************

  Future<ResponseModel> registration(SignUpBodyModel signUpBodyModel) async {
    _isLoading = true;
    update(); // Show indicator
    Response response =
        await authRepo.registration(signUpBodyModel); // response from server

    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);

      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;

    update(); // ui and indicator
    return responseModel;
  }

// ******************* Log In *******************

  Future<ResponseModel> login(SignInBodyModel signInBodyModel) async {
    _isLoading = true;
    update(); // Show indicator
    Response response =
        await authRepo.login(signInBodyModel); // response from server

    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      /*
      
       for each customer , backend creates a token what will save in headers
       by the method below. for security proccess 

      */

      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;

    update(); // ui and indicator
    return responseModel;
  }

// ******************* Save User Number And Password *******************

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

// ******************* User Logged In ? *******************

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

// ******************* Clear User Token *******************

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
