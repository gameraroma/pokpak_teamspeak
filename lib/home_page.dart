import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/models.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.products}) : super(key: key);

  final String title;
  final List<Channel> products;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<Channel> _shoppingCart = Set<Channel>();

  void _handleCartChanged(Channel channel, bool inCart) {
    setState(() {
      // When a user changes what's in the cart, we need to change _shoppingCart
      // inside a setState call to trigger a rebuild. The framework then calls
      // build, below, which updates the visual appearance of the app.

      if (inCart)
        _shoppingCart.add(channel);
      else
        _shoppingCart.remove(channel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title)
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: widget.products.map((Channel channel) {
            return ShoppingListItem(
              channel: channel,
              inCart: _shoppingCart.contains(channel),
              onCartChanged: _handleCartChanged,
            );
          }).toList(),
        )
    );
  }
}

typedef void CartChangedCallback(Channel product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.channel, this.inCart, this.onCartChanged})
       : super(key: ObjectKey(channel));

  final Channel channel;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts of the tree
    // can have different themes.  The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
//      onTap: () {
//        onCartChanged(product, !inCart);
//      },
//      title: Text(product.name, style: _getTextStyle(context)),
//      trailing: Text(product.name, style: _getTextStyle(context)),
      title: Text(channel.name),
      trailing: Text(channel.name),
    );
  }
}