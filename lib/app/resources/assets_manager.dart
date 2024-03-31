const String imagePath = "assets/images/";
const String imageOnBoarding = "assets/images/onboarding/";
const String jsonPath = "assets/json/";
const String iconPath = "assets/icons/";

class ImageManager {
  static const String splashLogo = "${imagePath}splash_logo.png";
  static const String appLogo = "${imagePath}logo.png";

  /// Map markers images
  static const String blueCar = "${imagePath}blue_car.png";
  static const String greenCar = "${imagePath}green_car.png";
  static const String greyCar = "${imagePath}grey_car.png";
  static const String redCar = "${imagePath}red_car.png";
  static const String greenFlag = "${imagePath}green_flag.png";
  static const String redFlag = "${imagePath}red_flag.png";
  static const String placeHolder = "${imagePath}placeholder.png";
  static const String purpleCar = "${imagePath}purple_car.png";
  static const String sheetHolder = "${imagePath}sheet_holder.png";
}

class SvgManager {
  static const String closeDialog = "${iconPath}close_dialog.svg";
  static const passwordEyeHidden = "${iconPath}password-eye-hidden.svg";
  static const passwordEyeShown = "${iconPath}password-eye-shown.svg";
  static const arrowDown = "${iconPath}arrow-down.svg";
  static const editAvatar = "${iconPath}edit-avatar.svg";
  static const copyRight = "${iconPath}copyright.svg";
  static const infoWarning = "${iconPath}info_warning.svg";
  static const xlcFile = "${iconPath}excel.svg";
  static const language = "${iconPath}language_icon.svg";
}

class JsonManager {
  static const String dataNotFound = "${jsonPath}data_not_found.json";
  static const String empty = "${jsonPath}empty.json";
  static const String error = "${jsonPath}error.json";
  static const String success = "${jsonPath}success.json";
  static const String loading = "${jsonPath}loading.json";
  static const String loader = "${jsonPath}loader.json";
  static const String networkError = "${jsonPath}network_error.json";
  static const String logout = "${jsonPath}logout.json";
}
