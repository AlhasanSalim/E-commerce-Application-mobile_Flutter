import 'package:ecommarce/helpers/snack_helper.dart';
import 'package:ecommarce/models/product_model.dart';
import 'package:ecommarce/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProuductDetailsPage extends StatefulWidget {
  final Product product;
  const ProuductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProuductDetailsPage> createState() => _ProuductDetailsPageState();
}

class _ProuductDetailsPageState extends State<ProuductDetailsPage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 10,
        title: Text(
          widget.product.title ?? "",
          style: const TextStyle(
            color: Colors.white70
          ),
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.product.image ?? ""),
                        fit: BoxFit.contain
                      )
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.category!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black45
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          widget.product.rating?.rate.toString() ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '(${widget.product.rating!.count.toString()} Reviews)',
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            )
          ),
          InkWell(
            onTap: (){
              onItemClicked(context, quantity, widget.product);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  children: [
                    Text(
                      '\$ '+widget.product.price.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    const SizedBox(width: 70),
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          if (quantity != 1){
                            setState(() {
                            quantity--;
                          });
                          }
                        }, icon: const Icon(Icons.remove)),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        IconButton(onPressed: (){
                          setState(() {
                            quantity++;
                          });
                        }, icon: const Icon(Icons.add)),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          child: Text(
                            (Provider.of<ProductProvider>(context, listen: false).cartContainProduct(widget.product.id ?? 0))
                            ?
                            "- remove From Cart"
                            :
                            "+ Add To Cart",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Divider(
              height: 10,
              thickness: 2.0,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Information",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
          ),  
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.product.description ?? "",
              maxLines: 10,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
          ),  
        ],
      ),
    );
  }

  void onItemClicked(BuildContext context, int quantity, Product product){

    if (Provider.of<ProductProvider>(context, listen: false).cartContainProduct(product.id ?? 0)) {

      Provider.of<ProductProvider>(context, listen: false)
      .removeProductToCard(product.id ?? 0);
      SnackHelper.showSnack(title: "Product removed Successfully", context: context);
      setState(() {
        quantity = 1;
      });
    }
    else{
      Provider.of<ProductProvider>(context, listen: false)
      .addProductToCard({'productId' : product.id ?? 0, 'quantity' : quantity, 'productName' : product.title ?? "", 'productPrice' : product.price ?? 0.0, 'productImage' : product.image ?? ""});
      SnackHelper.showSnack(title: "Product Added Successfully", context: context);
      setState(() {});
    }
  }
}