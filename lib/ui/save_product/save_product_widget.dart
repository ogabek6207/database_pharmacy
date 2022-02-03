import 'package:cached_network_image/cached_network_image.dart';
import 'package:database_pharmacy/bloc/home_bloc.dart';
import 'package:database_pharmacy/model/drugs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SaveProductWidget extends StatefulWidget {
  final DrugsResult data;

  const SaveProductWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _SaveProductWidgetState createState() => _SaveProductWidgetState();
}

class _SaveProductWidgetState extends State<SaveProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Row(
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.data.image,
                  ),
                  widget.data.basePrice != 0
                      ? Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 18,
                      width: 42,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                        BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: Text(
                          "-" +
                              ((widget.data.basePrice -
                                  widget.data
                                      .price) *
                                  100 ~/
                                  widget.data
                                      .basePrice)
                                  .toString() +
                              "%",
                        ),
                      ),
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 183,
                    child: Text(
                      widget.data.name,
                      style: TextStyle(
                        color: const Color(0xFF1C1C1E),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.data.description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Text(widget.data.price.toString() +
                          " sum"),
                      SizedBox(
                        width: 12 ,
                      ),
                      widget.data.basePrice != 0
                          ? Text(
                        widget.data.basePrice.toString() +
                            " sum",
                        style: const TextStyle(
                          decoration:
                          TextDecoration.lineThrough,
                        ),
                      )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: 12 ,
                  ),
                  Row(
                    children: [
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
                          height: 30 ,
                          width: 120 ,
                          margin:
                          EdgeInsets.only(left: 5 ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                            BorderRadius.circular(
                                10 ),
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Text(
                                "add to cart",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 8 ,
                              ),
                              SvgPicture.asset(
                                  "assets/icons/basket.svg")
                            ],
                          ),
                        ),
                      )
                          : Container(
                        height: 30,
                        width: 120 ,
                        decoration: BoxDecoration(
                          color: Colors.blue
                              .withOpacity(0.1),
                          borderRadius:
                          BorderRadius.circular(10),
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
                                homeBloc.updateDrugs(
                                  false,
                                  widget.data.id,
                                  0,
                                );
                              },
                              child: Container(
                                height: 26 ,
                                width: 26 ,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                  BorderRadius.circular(
                                      10),
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
                                widget.data
                                    .cardCount
                                    .toString() +
                                    " шт.",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 15 ,
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
                                height: 26 ,
                                width: 26 ,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                  BorderRadius.circular(
                                      10),
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
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.data.favSelected =
                            !widget.data.favSelected;
                          });
                        },
                        child: widget.data.favSelected
                            ? SvgPicture.asset(
                          "assets/icons/like.svg",
                          height: 24,
                          width: 24 ,
                        )
                            : SvgPicture.asset(
                          "assets/icons/dislike.svg",
                          height: 24,
                          width: 24 ,
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}