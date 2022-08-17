import 'package:foodies/Data/Repository/user_repo.dart';
import 'package:foodies/Models/response_model.dart';
import 'package:foodies/Models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late UserModel _userModel;
  UserModel get userModel => _userModel;

// ******************* Get User Info *******************

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo(); // response from server

    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "Successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    update(); // ui and indicator
    return responseModel;
  }
}
