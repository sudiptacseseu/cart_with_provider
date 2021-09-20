import 'package:cart_with_provider/data/dummy_product_list.dart';
import 'package:cart_with_provider/provider/cart_provider.dart';
import 'package:cart_with_provider/screen/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    var cartItems = cart.cartItems;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actionsIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          "Products",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cart(),
                        maintainState: true,
                      ));
                },
              ),
              Positioned(
                right: 8,
                top: 4,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "${cartItems.length}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
          itemCount: DummyProductList.products.length,
          itemBuilder: (context, index) {
            final product = DummyProductList.products[index];
            return ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  radius: double.infinity,
                  backgroundImage: NetworkImage(product.image),
                ),
              ),
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              trailing: GestureDetector(
                onTap: () {
                  cart.addItemOrIncreaseQuantity(product);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.black26,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add to cart",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
