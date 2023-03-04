class HomeModel{
  late  bool status;
  late  HomeDataModel ?data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);


  }

}

class HomeDataModel{
  List<Map<String,dynamic>> productslist =[];
  List<Map<String,dynamic>> bannerslist =[];

  List<ProductModel> products =[];
  List<BannerModel> banners =[];

  HomeDataModel.fromJson(Map<String,dynamic> json){

    json['products'].forEach((element)
      {
      products.add(ProductModel.fromJson(element));
    });

    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });


    // productslist.forEach((element) {
    //   products.add(ProductModel(
    //       id: element['id'],
    //       price: element['price'],
    //       old_price: element['old_price'],
    //       discount: element['discount'],
    //       image: element['image'],
    //       name: element['name'],
    //       in_favorites: element['in_favorites'],
    //       in_cart: element['in_cart']));
    // });


  //   bannerslist.forEach((element) {
  //     banners.add(BannerModel(
  //         id: element['id'],
  //         image: element['image']
  //   ));
  // });


}
}


class ProductModel{

  late  int id;
  late  dynamic price;
  late  dynamic old_price;
  late  dynamic discount;
  late  String image;
  late  String name;
  late  bool in_favorites;
  late  bool in_cart;




  ProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    name = json['name'];
    image = json['image'];
    discount = json['discount'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];

  }

}



class BannerModel{
  late  int id;
  late  String image;

  BannerModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];

  }

  BannerModel({
    required this.id,
    required this.image,  });
}

