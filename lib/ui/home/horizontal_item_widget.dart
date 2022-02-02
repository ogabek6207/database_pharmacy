import 'package:cached_network_image/cached_network_image.dart';
import 'package:database_pharmacy/bloc/home_bloc.dart';
import 'package:database_pharmacy/model/drugs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemHorizontalWidget extends StatefulWidget {
  final DrugsResult data;

  const ItemHorizontalWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ItemHorizontalWidgetState createState() => _ItemHorizontalWidgetState();
}

class _ItemHorizontalWidgetState extends State<ItemHorizontalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.only(
        right: 12,
      ),
      width: 140,
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: widget.data.image,
            fit: BoxFit.cover,
            width: 140,
            height: 140,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            widget.data.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF1C1C1E),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Text(
            widget.data.description,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          const Spacer(),
          widget.data.cardCount == 0
              ? GestureDetector(
                  onTap: () {
                    homeBloc.updateDrugs(
                      true,
                      widget.data.id,
                      1,
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 120,
                    margin: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.data.price.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset("assets/icons/korzinka.svg")
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.data.cardCount > 1) {
                            widget.data.cardCount--;
                            homeBloc.updateDrugs(
                              false,
                              widget.data.id,
                              widget.data.cardCount,
                            );
                          }
                        },
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Text(
                          widget.data.cardCount.toString() + " шт.",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          widget.data.cardCount++;
                          homeBloc.updateDrugs(
                            false,
                            widget.data.id,
                            widget.data.cardCount,
                          );
                        },
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
