import 'package:flutter/material.dart';
import 'package:shoe_shop_app/features/cart/domain/entities/cart.dart';
import 'package:shoe_shop_app/features/cart/presentation/view/cart_page.dart';
import 'package:shoe_shop_app/features/discover/data/models/shoe_model.dart';
import 'package:shoe_shop_app/features/discover/presentation/view/discover_page.dart';
import 'package:shoe_shop_app/features/order_summary/presentation/order_summary_page.dart';
import 'package:shoe_shop_app/features/product_detail/presentation/product_detail.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DiscoverPage.routeName:
        return MaterialPageRoute(builder: (_) => const DiscoverPage());
      case CartPage.routeName:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case OrderSummaryPage.routeName:
        List<CartItem> args = settings.arguments as List<CartItem>;
        return MaterialPageRoute(
            builder: (_) => OrderSummaryPage(
                  cartItems: args,
                ));
      case ProductDetail.routeName:
        ShoeModel args = settings.arguments as ShoeModel;
        return MaterialPageRoute(
            builder: (_) => ProductDetail(
                  shoe: args,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
