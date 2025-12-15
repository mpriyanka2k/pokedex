class Validators {
 

  static String? validateEmail(String? value, {String message = "Please enter email"}) {
    if (value == null || value.isEmpty) return 'Please enter email';

    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$");

    if (!emailRegex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  static String? validatePassword(String? value,
  String message,
      {int minLength = 6}) {
    if (value == null || value.length < minLength) {
      return message;
    }
    return null;
  }

 


}
