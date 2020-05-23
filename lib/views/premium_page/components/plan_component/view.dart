import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/checkout_model.dart';
import 'package:movie/models/enums/premium_type.dart';

import 'state.dart';

Widget buildView(PlanState state, Dispatch dispatch, ViewService viewService) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(children: [
        _Background(controller: state.scrollController),
        _Swiper(scrollController: state.scrollController),
        _Appbar()
      ]));
}

final _items = [
  _SubscriptionPlanItem(
      name: '1 Month',
      amount: 2.99,
      subscribed: true,
      type: PremiumType.oneMonth),
  _SubscriptionPlanItem(
      name: '3 Months',
      amount: 6.99,
      subscribed: false,
      type: PremiumType.threeMonths),
  _SubscriptionPlanItem(
      name: '6 Months',
      amount: 9.99,
      subscribed: false,
      type: PremiumType.sixMonths),
  _SubscriptionPlanItem(
      name: '12 Months',
      amount: 16.99,
      subscribed: false,
      type: PremiumType.twelveMonths)
];

class _SubscriptionPlanItem {
  String name;
  double amount;
  bool subscribed;
  PremiumType type;
  _SubscriptionPlanItem({this.name, this.amount, this.subscribed, this.type});
}

class _Background extends StatelessWidget {
  final ScrollController controller;
  const _Background({this.controller});
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          height: Adapt.screenH(),
          width: Adapt.screenW() * 4,
          foregroundDecoration: BoxDecoration(color: Color(0x90000000)),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                  'https://image.tmdb.org/t/p/original/2lBOQK06tltt8SQaswgb8d657Mv.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubscriptionPlanCell extends StatelessWidget {
  final _SubscriptionPlanItem data;
  const _SubscriptionPlanCell({this.data});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Adapt.px(40)),
          Container(
            child: Text(
              '${data.name} of premium for \$ ${data.amount}',
              style: TextStyle(
                  fontSize: Adapt.px(60),
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Watch Movie and TvShows without ads, download video if support',
            style: TextStyle(color: const Color(0xFF9E9E9E), height: 1.6),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: Adapt.screenW(),
            height: Adapt.px(30),
            child: data.subscribed
                ? Text(
                    'This is your current plan',
                    style: TextStyle(
                      color: Color(0xFFFFB74D),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 10),
          data.subscribed
              ? Container(
                  height: Adapt.px(80),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Adapt.px(40)),
                    border: Border.all(color: Color(0xFFEB7875)),
                    color: Color(0x50000000),
                  ),
                  child: Center(
                    child: Text(
                      'UNSUBSCRIBE',
                      style: TextStyle(color: Color(0xFFEB7875)),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () async => await Navigator.of(context)
                      .pushNamed('checkoutPage', arguments: {
                    'data': CheckOutModel(
                        name: 'Premium ${data.name}',
                        amount: data.amount,
                        premiumType: data.type,
                        isPremium: true)
                  }),
                  child: Container(
                    height: Adapt.px(80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(40)),
                      color: Color(0xFFEB7875),
                    ),
                    child: Center(
                      child: Text(
                        'SUBSCRIBE',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _Swiper extends StatefulWidget {
  final ScrollController scrollController;
  const _Swiper({this.scrollController});
  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<_Swiper> {
  SwiperController _controller;
  int selectIndex = 0;
  final double itemWidth = Adapt.screenW() * 0.6;
  @override
  void initState() {
    _controller = SwiperController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Swiper(
        itemCount: 4,
        controller: _controller,
        onIndexChanged: (index) {
          setState(() {
            selectIndex = index;
          });
          widget.scrollController.animateTo(Adapt.screenW() * selectIndex,
              duration: Duration(milliseconds: 600), curve: Curves.ease);
        },
        loop: false,
        fade: 0.1,
        viewportFraction: 0.6,
        scale: 0.5,
        itemBuilder: (_, index) {
          final _item = _items[index];
          return _SubscriptionPlanCell(data: _item);
        },
      ),
    );
  }
}

class _Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: false,
          title: Text('Subscription Plan'),
        ));
  }
}
