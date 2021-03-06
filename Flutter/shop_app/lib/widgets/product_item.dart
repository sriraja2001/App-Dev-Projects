import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon( product.isFavourite == true ? Icons.favorite : Icons.favorite_border ),
                color: Theme.of(context).accentColor,
                onPressed: (){
                  product.toggleFavouriteStatus();
                },
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: (){
                cart.addItem(product.id, product.price, product.title);
              },
            ),
          ),
        ),
    );
  }
}
