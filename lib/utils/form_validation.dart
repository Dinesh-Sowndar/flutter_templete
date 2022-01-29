String? validateName(value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(patttern);
  if (value.length == 0) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return null;
}

String? validateMobile(value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (value.length == 0) {
    return "Mobile is Required";
  } else if (value.length != 10) {
    return "Mobile number must 10 digits";
  } else if (!regExp.hasMatch(value)) {
    return "Mobile Number must be digits";
  }
  return null;
}

String? validateOTP(value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (value.length == 0) {
    return "OTP is Required";
  } else if (value.length != 6) {
    return "OTP must 6 digits";
  } else if (!regExp.hasMatch(value)) {
    return "OTP must be digits";
  }
  return null;
}


String? validateEmail(value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (value.length == 0) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}

String? validateRequired(value, String label) {
  if (value.length == 0) {
    return "$label is Required";
  } else {
    return null;
  }
}

String? validatePass(value) {
  if (value.length == 0) {
    return "Password is Required";
  } else if (value.length < 8) {
    return "Password must minimum 8 charactor";
  } else {
    return null;
  }
}
