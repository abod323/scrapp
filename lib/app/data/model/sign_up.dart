class SignUpModel{


  String? name;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;
  String? address;
  String? city;
  String? country;

  SignUpModel({this.name, this.email, this.phone, this.password, this.passwordConfirmation, this.address, this.city, this.country});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    country = json['country'];
    address = json['address'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']=this.name;
    data['email']=this.email;
    data['phone']=this.phone;
    data['city']=this.city;
    data['country']=this.country;
    data['address']=this.address;
    data['password']=this.password;
    data['password_confirmation']=this.passwordConfirmation;
    return data;
  }
}