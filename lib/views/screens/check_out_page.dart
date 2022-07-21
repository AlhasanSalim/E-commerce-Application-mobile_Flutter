import 'package:ecommarce/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ChackOutPage extends StatefulWidget {
  final List <Map<String, dynamic>>? productSelected;
  const ChackOutPage({Key? key, required this.productSelected}) : super(key: key);

  @override
  State<ChackOutPage> createState() => _ChackOutPageState();
}

class _ChackOutPageState extends State<ChackOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 10,
        title: const Text(
          "Chack out page" ,
          style: TextStyle(
            color: Colors.white70,
          ),
        )
      ),
      body: widget.productSelected == null ?
       const Center(
        child: Text(
          "No Data Selected",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),
       ) : 
        Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Expanded(
               child: SingleChildScrollView(
                 child: Column(
                   children: 
                     widget.productSelected!
                     .map((e) => ListTile(
                       title: Text(e['productName']),
                       subtitle:
                        Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Quantity : ${e['quantity']}"),
                           const SizedBox(height: 5),
                           Text(
                             "Price : ${e['productPrice'] * e['quantity']}",
                             style: const TextStyle(
                               color: Colors.red
                             ),
                           ),
                           const Divider(
                            height: 70,
                            thickness: 2.0,
                           )
                         ],
                       ),
                       leading: Container(
                         height: 80,
                         width: 80,
                         decoration: BoxDecoration(
                           image: DecorationImage(
                             image: NetworkImage(e['productImage']),
                             fit: BoxFit.contain
                           )
                         )
                       )
                     )).toList(),
                 ),
               ),
             ),
           const Padding(
             padding: EdgeInsets.symmetric(horizontal: 30),
             child: Divider(
              height: 30,
              thickness: 2.0,
             ),
           ),  
           InkWell(
           onTap: (){
            Provider.of<ProductProvider>(context, listen: false).sendCardData(context);
           },
           child: SizedBox(
             width: MediaQuery.of(context).size.width,
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
               child: Row(
                 children: [
                   Text(
                     "Total Price : "+ " \$ " + Provider.of<ProductProvider>(context).getCardTotalPrice(),
                     style: const TextStyle(
                       color: Colors.black,
                       fontSize: 25,
                       fontWeight: FontWeight.w800
                     ),
                   ),
                   const SizedBox(width: 20),
                   
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
                           "Check Out",
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
           ],
         ),
       )
      );
  }
}