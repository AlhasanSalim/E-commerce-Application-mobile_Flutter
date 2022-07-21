class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  Product(
    {
      this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating
    }
  );
  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    price = json['price'] == null ? 0.0 : json['price'].toDouble();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'title' : title,
      'price' : price,
      'description' : description,
      'category' : category,
      'image' : image,
      'rating' : rating?.toJson()
    };
  }
}

class Rating {
  double? rate;
  int? count;

  Rating(
    {
      this.rate,
      this.count
    }
  );
  Rating.fromJson(Map<String, dynamic> json){
    rate = json['rate'] == null ? 0.0 : json['rate'].toDouble();
    count = json['count'];
  }
  Map <String, dynamic> toJson(){
    return {
      'rate' : rate,
      'count' : count
    };
  }
}