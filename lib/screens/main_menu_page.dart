import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walleto/data/model/category.dart';
import 'package:walleto/screens/widgets/carousel.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            background(),
            Column(
              children: [
                SizedBox(height: 90),
                saldo(),
                SizedBox(height: 20),
                item2(),
                SizedBox(height: 20),
                carousel(),
              ],
            ),
          ]
        ),
      ),
    );
  }
}

Widget carousel() {
  return Builder(builder: (BuildContext context) {
  return Container(
      child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 4,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            initialPage: 2,
            autoPlay: true,
          ),
          items: Category.categories
              .map((category) => Carousel(category: category))
              .toList()));
});
}

Widget background() {
  return Builder(builder: (BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
            color: Colors.cyanAccent),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Walleto',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Nunito',
                  )),
            ],
          ),
        ));
  });
}

Widget saldo() {
  return Builder(builder: (BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 45,
      decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saldo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      fontFamily: 'Nunito',
                    )),
                SizedBox(height: 10),
                Text('Rp 0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0,
                      fontFamily: 'Nunito',
                    )),
              ],
            ),
            addButton(context)
          ],
        ),
      ),
    );
  });
}

Widget addButton(context) => FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.black,
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                  height: 200,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Masukkan jumlah saldo',
                          style: TextStyle(fontFamily: 'Nunito'),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          child: Text('Simpan'),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ));
            });
      },
    );

Widget item2() {
  return Padding(
    padding: const EdgeInsets.only(left: 25.0),
    child: Row(
      children: [
        Column(
          children: [
            Text('Pilih Kategori Tabungan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  fontFamily: 'Nunito',
                )),
          ],
        ),
      ],
    ),
  );
}