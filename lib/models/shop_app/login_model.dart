class ShopLoginModel{

  late final  bool status;
  late final  String? message;
  late final  UserData ?data;

  ShopLoginModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;


  }


}


class UserData{

   late int id;
   late String name;
   late String email;
   late String phone;
   late String image;
   late int points;
   late String token;
   late int credit;


  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token
});


  UserData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone']??='';
    image = json['image']??='';
    points = json['points']??=0;
    credit = json['credit']??=0;
    token = json['token'];


  }





}