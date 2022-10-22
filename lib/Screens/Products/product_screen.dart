import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Products/product_form.dart';
import 'package:flutter_auth/components/background.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: SvgPicture.asset("assets/icons/signup.svg"),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: defaultPadding*2),
            Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: ProductForm(),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
