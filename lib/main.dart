import 'package:flutter/material.dart';
import '/config/size_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: scrapeParts(),
    );
  }
}

class scrapeParts extends StatefulWidget {
  const scrapeParts({Key? key}) : super(key: key);

  @override
  State<scrapeParts> createState() => _scrapePartsState();
}

class _scrapePartsState extends State<scrapeParts> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ),

      body: ListView.builder(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1,),
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return parts_cell();
          }
      ),
    );
  }
}

class parts_cell extends StatelessWidget {
  const parts_cell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1,),
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                          width: SizeConfig.blockSizeHorizontal * 45,
                          height: 160 - SizeConfig.blockSizeHorizontal * 0.5,
                          child: Image.network(
                            //fit: BoxFit.cover,
                              'https://img1.kakaku.k-img.com/images/productimage/fullscale/K0001419396.jpg'
                          )
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 45,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 4,),
                              Icon(
                                Icons.local_mall_outlined,
                                color: Colors.orangeAccent,
                                size: 16,
                              ),
                              Text(
                                '1位',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1,),
                    width: SizeConfig.blockSizeHorizontal * 50,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 14,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text(
                                'MSI',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              SizedBox(width: 8,),
                              Container(
                                padding: EdgeInsets.all(2),
                                height: 14,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  ' NEW',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 2,),
                        Container(
                          height: 58,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                          ),
                          child: Text(
                            'GeForce RTX 4090 SUPRIM X 24G [PCIExp 24GB]',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          //padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                          decoration: BoxDecoration(
                            //color: Colors.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 20,
                              ),
                              Icon(
                                Icons.star_half,
                                color: Colors.orange,
                                size: 20,
                              ),
                              Icon(
                                Icons.star_border_purple500_sharp,
                                color: Colors.orange,
                                size: 20,
                              ),
                              SizedBox(width: 2,),
                              Text(
                                '3.5 (2)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 28,
                          width: double.infinity,
                          // decoration: BoxDecoration(
                          //   color: Colors.red,
                          // ),
                          child: Text(
                            '¥345,675',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.redAccent
                            ),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: double.infinity,
                          // decoration: BoxDecoration(
                          //   color: Colors.red,
                          // ),
                          child: Text(
                            '(前週比 : +5,875円↑)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 8
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
        SizedBox(height: 8,),
      ],
    );
  }
}

