
String validateName(String value) {
    return (value.length < 3) ? 'Name must be more than 3 charater' : null;
}

 String validateMobile(String value) {
    return (value.length != 10) ? 'Mobile Number must be of 10 digit' : null;
  }


 String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isNotEmpty) {
      return (!regex.hasMatch(value)) ? 'Enter Valid Email' : null;
    }
    return null;
  }
