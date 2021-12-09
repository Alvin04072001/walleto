import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walleto/shared/theme.dart';

class WalletDetailPage extends StatelessWidget {
  static const routeName = "/wallet_add_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Detail Wallet', style: TextStyle(fontFamily: 'Nunito')),
          centerTitle: true,
          backgroundColor: kBlueColor),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 20),
            detailSaldo(),
            SizedBox(height: 20),
            // history()
          ],
        ),
      ),
    );
  }

  Widget detailSaldo() {
    return Builder(builder: (BuildContext context) {
      return AspectRatio(
        aspectRatio: 4.0 / 2.0,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: kLightGreyColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      height: 40.0,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.withOpacity(.8),
                          shape: BoxShape.rectangle),
                      child: Icon(
                        Icons.attach_money_rounded,
                        size: 20.0,
                        color: Colors.amber,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "RP. 100.000.000",
                          style: whiteTextStyle.copyWith(
                              fontSize: 15, fontWeight: regular),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Investasi",
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Better Future",
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

// Widget history() {
//   return Builder(builder: (BuildContext context) {
//     return ListView(
//       physics: ClampingScrollPhysics(),
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       children: <Widget>[
//         Card(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(color: Colors.grey, width: 1)),
//           child: ListTile(
//             title: Text('Minang Deng Laka Minang Suang',
//                 style: TextStyle(fontFamily: 'Nunito')),
//           ),
//         ),
//         Card(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(color: Colors.grey, width: 1)),
//           child: ListTile(
//             title: Text('Minang Deng Laka Minang Suang',
//                 style: TextStyle(fontFamily: 'Nunito')),
//           ),
//         ),
//         Card(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(color: Colors.grey, width: 1)),
//           child: ListTile(
//             title: Text('Minang Deng Laka Minang Suang',
//                 style: TextStyle(fontFamily: 'Nunito')),
//           ),
//         ),
//         Card(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(color: Colors.grey, width: 1)),
//           child: ListTile(
//             title: Text('Minang Deng Laka Minang Suang',
//                 style: TextStyle(fontFamily: 'Nunito')),
//           ),
//         ),
//         Card(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(color: Colors.grey, width: 1)),
//           child: ListTile(
//             title: Text('Minang Deng Laka Minang Suang',
//                 style: TextStyle(fontFamily: 'Nunito')),
//           ),
//         ),
//       ],
//     );
//   });
// }