/// https://javiercbk.github.io/json_to_dart/
class Food {
  String? code;
  Product? product;
  int? status;
  String? statusVerbose;

  Food({
    this.code,
    this.product,
    this.status,
    this.statusVerbose,
  });

  Food.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    status = json['status'];
    statusVerbose = json['status_verbose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['status'] = status;
    data['status_verbose'] = statusVerbose;
    return data;
  }
}

class Product {
  String? categories;
  String? id;
  String? imageUrl;

  Product({this.categories, this.id, this.imageUrl});

  Product.fromJson(Map<String, dynamic> json) {
    categories = json['categories'];
    id = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories'] = categories;
    data['id'] = id;
    data['image_url'] = imageUrl;
    return data;
  }
}
