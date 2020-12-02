import 'package:flutter/widgets.dart';
import '../views/auth/complete_registration.dart';
import '../views/categories/category.dart';
import '../views/details/details_screen.dart';
import '../views/home/home.dart';
import '../views/myBag/myBag_screen.dart';
import '../views/userType/user_Type.dart';
import '../views/auth/Auth.dart';
import '../views/userType/store-register.dart';
import '../views/categories/categories.dart';
import '../views/stores/stores.dart';
import '../views/Products/products.dart';
import '../views/home/drawer/about-us.dart';
import '../views/home/drawer/QA.dart';
import '../views/home/drawer/contact-us.dart';
import '../views/account/editAccount.dart';
import '../views/account/account.dart';
import '../views/wishlist/wishList.dart';
import '../views/checkout/checkout.dart';
import '../views/checkout/checkoutSummary.dart';

final Map<String, WidgetBuilder> routes = {
  AuthScreen.routeName: (context) => AuthScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  MyBagScreen.routeName: (context) => MyBagScreen(),
  UserTypeScreen.routeName: (context) => UserTypeScreen(),
  StoreRegisterScreen.routeName: (context) => StoreRegisterScreen(),
  CategoryScreen.routeName: (context) => CategoryScreen(),
  CategoriesScreen.routeName: (context) => CategoriesScreen(),
  StoresScreen.routeName: (context) => StoresScreen(),
  ProductsScreen.routeName: (context) => ProductsScreen(),
  AboutUsScreen.routeName: (context) => AboutUsScreen(),
  QAScreen.routeName: (context) => QAScreen(),
  ContactUsScreen.routeName: (context) => ContactUsScreen(),
  CompleteRegistration.routeName: (context) => CompleteRegistration(),
  AccountScreen.routeName: (context) => AccountScreen(),
  EditAccountScreen.routeName: (context) => EditAccountScreen(),
  WishListSceen.routeName: (context) => WishListSceen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
  CheckoutSummaryScreen.routeName: (context) => CheckoutSummaryScreen()
};
