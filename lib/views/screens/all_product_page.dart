import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../widgets/product_card.dart';
class AllProductsPage extends StatefulWidget {
  final String? categoryTitle;
  const AllProductsPage({Key? key, this.categoryTitle}) : super(key: key);

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  @override
  void initState() {
    if (widget.categoryTitle != null){
      Provider.of<ProductProvider>(context, listen: false).getcategoryProducts(title: widget.categoryTitle!);
    }
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 10,
        title: Text(
          widget.categoryTitle == null ?
          "All Products" :
          widget.categoryTitle.toString(),
          style: const TextStyle(
            color: Colors.white70,
          ),
        )
      ),
      body: widget.categoryTitle != null ? 
        categoryProductsBody()
        :
        allProductsBody()
      );
  }
  Widget allProductsBody(){
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Provider.of<ProductProvider>(context).getAllData() == null
              ?
             const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange,),
             )
             :
             Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: 
               Provider.of<ProductProvider>(context).getAllData()!.map((e) => ProductCard(product: e)).toList()
             ),
          ),
        );
  }

  Widget categoryProductsBody(){
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Provider.of<ProductProvider>(context).getOneTypeOfProducts() == null
              ?
             const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange,),
             )
             :
             Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: 
               Provider.of<ProductProvider>(context).getOneTypeOfProducts()!.map((e) => ProductCard(product: e)).toList()
             ),
          ),
        );
  }
}