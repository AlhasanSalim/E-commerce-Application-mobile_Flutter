import 'package:badges/badges.dart';
import 'package:ecommarce/providers/product_provider.dart';
import 'package:ecommarce/services/app_service.dart';
import 'package:ecommarce/views/screens/all_product_page.dart';
import 'package:ecommarce/views/screens/check_out_page.dart';
import 'package:ecommarce/views/screens/product_details_page.dart';
import 'package:ecommarce/views/widgets/category_card.dart';
import 'package:ecommarce/views/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getHomePageProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 10,
        title: const Text(
          "Welcome To Ecommerce App",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        actions: [
          Provider.of<ProductProvider>(context).productSelected() != null 
            ?
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              position: BadgePosition.topStart(),
              badgeContent: Text(
                Provider.of<ProductProvider>(context).productSelected()!.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_){return ChackOutPage(productSelected: Provider.of<ProductProvider>(context, listen: false).productSelected());}));
                },
                icon: const Icon(Icons.shopping_cart)
              )))
            :
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_){return ChackOutPage(productSelected: Provider.of<ProductProvider>(context, listen: false).productSelected());}));
                  },
                  icon: const Icon(
                    Icons.shopping_cart
                  )),
          ),
          
          IconButton(
            onPressed: (){
              AppService.logOut(context);
            },
            icon: const Icon(Icons.logout)
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: 350,
              //     decoration: const BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage("assets/discount3.jpg"),
              //         fit: BoxFit.fitWidth
              //       )
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                   Text(
                    "Categories",
                    style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                child: Row(
                  children: Provider.of<ProductProvider>(context, listen: false).
                    getCategoriesData().
                      map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryCard(title: e['title'] ?? "", image: e['image'] ?? ""),
                      ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Products",
                    style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_){return const AllProductsPage();}));
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Provider.of<ProductProvider>(context).getHomeData() == null 
             ?
             const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange,),
             )
             :
             Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: Provider.of<ProductProvider>(context)
              .getHomeData()!.
              map((e) => ProductCard(
                product: e, 
              )).toList()
             ),
            ],
          ),
        ),
      )
    );
  }
}