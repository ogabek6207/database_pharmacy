import 'package:database_pharmacy/bloc/home_bloc.dart';
import 'package:database_pharmacy/model/drugs_model.dart';
import 'package:database_pharmacy/ui/save_product/save_product_widget.dart';
import 'package:flutter/material.dart';

class SaveProductScreen extends StatefulWidget {
  const SaveProductScreen({Key? key}) : super(key: key);

  @override
  _SaveProductScreenState createState() => _SaveProductScreenState();
}

class _SaveProductScreenState extends State<SaveProductScreen> {
  @override
  initState() {
    homeBloc.getDrugs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: homeBloc.fetchDrugs,
        builder: (context, AsyncSnapshot<DrugsModel> snapshot) {
          if (snapshot.hasData) {
            List<DrugsResult> drugsRersult = snapshot.data!.results;
            return drugsRersult.isEmpty
                ? Container()
                : Container(
                    color: Colors.orange,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: drugsRersult.length,
                      itemBuilder: (context, index) {
                        return SaveProductWidget(
                          key: Key(
                            drugsRersult[index].cardCount.toString(),
                          ),
                          data: drugsRersult[index],
                        );
                      },
                    ),
                  );
          }
          return Container();
        },
      ),
    );
  }
}