import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kutchmahamandalbhav/localization/transaltedValues.dart';
import 'package:kutchmahamandalbhav/models/product.dart';
import 'package:kutchmahamandalbhav/models/report.dart';
import 'package:kutchmahamandalbhav/routes/routesName.dart';
import 'package:kutchmahamandalbhav/services/database.dart';
import 'package:kutchmahamandalbhav/styles/textStyles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(TransaltedValues.getTransaltedValues(
              context, 'home_page_app_bar_title')),
        ),
        //Navigation Drawer
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              CircleAvatar(
                radius: 60,
              ),
              Divider(),
              //To Change Language
              ListTile(
                title: Text(TransaltedValues.getTransaltedValues(
                    context, "change_language")),
                onTap: () {
                  String languageCode =
                      Localizations.localeOf(context).languageCode;
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushNamed(changeLanguage, arguments: languageCode);
                },
                leading: Icon(Icons.language),
              ),
            ],
          ),
        ),
        //Using stream provider to watch latestreports
        body: StreamBuilder<List<Report>>(
            stream: Database.getReport(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    TransaltedValues.getTransaltedValues(context, "ERROR"),
                    style: titleStyle,
                  ),
                );
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text(
                    TransaltedValues.getTransaltedValues(context, "ERROR"),
                    style: titleStyle,
                  ),
                );
              }
              return ReportContainer(report: snapshot.data.first);
            }));
  }
}

class ReportContainer extends StatelessWidget {
  final Report report;
  const ReportContainer({Key key, this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime =
        Timestamp(report.timestamp.seconds, report.timestamp.nanoseconds)
            .toDate();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Title, Date and Time
        SizedBox(
          height: 25.0,
        ),
        //Title
        Text(
          TransaltedValues.getTransaltedValues(context, "home_page_title"),
          style: titleStyle,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (0.035),
        ),
        //Date and time
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: TransaltedValues.getTransaltedValues(
                        context, "home_page_date"),
                    style: titleStyle,
                  ),
                  TextSpan(
                      text:
                          " :- ${dateTime.day}-${dateTime.month}-${dateTime.year}",
                      style: titleStyle),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: TransaltedValues.getTransaltedValues(
                        context, "home_page_time"),
                    style: titleStyle,
                  ),
                  TextSpan(
                      text: " :- ${dateTime.hour}:${dateTime.minute}",
                      style: titleStyle),
                ]),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (0.03),
        ),

        //Products
        Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.black12),
                bottom: BorderSide(color: Colors.black12)),
            color: Colors.grey.shade100,
          ),
          //Displaying products in reports
          child: Column(
            children: report.products
                .map((product) => ProductContainer(
                      product: product,
                    ))
                .toList(),
          ),
        ),

        Spacer(),
        //President Details
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${TransaltedValues.getTransaltedValues(context, "home_page_president")}",
              style: titleStyle,
            ),
            Text(
              "${TransaltedValues.getTransaltedValues(context, "home_page_president_name")}",
              style: titleStyle,
            ),
            Text(
              "M.1234567890",
              style: titleStyle,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}

class ProductContainer extends StatelessWidget {
  final Product product;
  const ProductContainer({Key key, this.product}) : super(key: key);

  String formattedPrice(String price) {
    if (price.length == 5) {
      price = price.replaceRange(2, 2, ",");
    } else if (price.length == 6) {
      price = price.replaceRange(1, 1, ",");
      price = price.replaceRange(4, 4, ",");
    } else if (price.length == 7) {
      price = price.replaceRange(2, 2, ",");
      price = price.replaceRange(5, 5, ",");
    }

    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
      child: Row(
        children: [
          Container(
            child: Text(
              "${product.name} ",
              style: titleStyle,
            ),
          ),
          //
          Spacer(),
          //Width of Price Container
          Container(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/rupee-indian.svg",
                  height: 14.5,
                  width: 14.5,
                  color: Colors.black87,
                ),
                SizedBox(
                  width: 2.5,
                ),
                Text(
                  formattedPrice(product.price),
                  style: titleStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
