import 'package:ecommarce/views/screens/all_product_page.dart';
import 'package:ecommarce/views/screens/product_details_page.dart';
import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  const CategoryCard({Key? key, required this.title, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_){return AllProductsPage(categoryTitle: title,);}));
      },
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        elevation: 5.0,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 253, 253, 253),
            borderRadius: BorderRadius.circular(15)
          ),
          child: SizedBox(
            height: 100,
            width: 75,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.contain
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}