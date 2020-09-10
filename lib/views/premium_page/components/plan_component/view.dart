import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/base_api_model/checkout_model.dart';
import 'package:movie/models/enums/premium_type.dart';
import 'package:movie/views/premium_page/components/plan_component/action.dart';

import 'state.dart';

Widget buildView(PlanState state, Dispatch dispatch, ViewService viewService) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(children: [
        _Background(controller: state.scrollController),
        _Swiper(
          scrollController: state.scrollController,
          user: state.user,
          dispatch: dispatch,
        ),
        _Appbar(),
        state.loading ? _LoadingLayout() : SizedBox()
      ]));
}

class _SubscriptionPlanItem {
  int id;
  String name;
  double amount;
  PremiumType type;
  _SubscriptionPlanItem({this.id, this.name, this.amount, this.type});
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
  final bool isSubscried;
  final Dispatch dispatch;
  const _SubscriptionPlanCell({this.data, this.isSubscried, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Container(
            child: Text(
              '${data.name} of premium for \$ ${data.amount}',
              style: TextStyle(
                  fontSize: Adapt.px(60),
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Watch Movie and TvShows without ads, download video if support',
            style: TextStyle(color: const Color(0xFF9E9E9E), height: 1.6),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: Adapt.screenW(),
            height: Adapt.px(30),
            child: isSubscried
                ? const Text(
                    'This is your current plan',
                    style: TextStyle(
                      color: const Color(0xFFFFB74D),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 10),
          isSubscried
              ? GestureDetector(
                  onTap: () => dispatch(PlanActionCreator.unSubscribe()),
                  child: Container(
                    height: Adapt.px(80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(40)),
                      border: Border.all(color: Color(0xFFEB7875)),
                      color: Color(0x50000000),
                    ),
                    child: Center(
                      child: const Text(
                        'UNSUBSCRIBE',
                        style: TextStyle(
                          color: const Color(0xFFEB7875),
                        ),
                      ),
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
                      color: const Color(0xFFEB7875),
                    ),
                    child: Center(
                      child: const Text(
                        'SUBSCRIBE',
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                        ),
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
  final Dispatch dispatch;
  final AppUser user;
  const _Swiper({this.scrollController, this.user, this.dispatch});
  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<_Swiper> {
  SwiperController _controller;
  int selectIndex = 0;
  final double itemWidth = Adapt.screenW() * 0.6;
  final _items = [
    _SubscriptionPlanItem(
        id: 1, name: '1 Month', amount: 2.99, type: PremiumType.oneMonth),
    _SubscriptionPlanItem(
        id: 2, name: '3 Months', amount: 6.99, type: PremiumType.threeMonths),
    _SubscriptionPlanItem(
        id: 3, name: '6 Months', amount: 9.99, type: PremiumType.sixMonths),
    _SubscriptionPlanItem(
        id: 4, name: '12 Months', amount: 16.99, type: PremiumType.twelveMonths)
  ];
  @override
  void initState() {
    _controller = SwiperController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          return _SubscriptionPlanCell(
            dispatch: widget.dispatch,
            data: _item,
            isSubscried: widget.user.premium?.premiumType == _item.id &&
                widget.user.premium.subscription,
          );
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

class _LoadingLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: Adapt.screenW(),
        height: Adapt.screenH(),
        color: const Color(0x20000000),
        child: Center(
          child: Container(
            width: Adapt.px(300),
            height: Adapt.px(300),
            decoration: BoxDecoration(
              color: const Color(0xAA000000),
              borderRadius: BorderRadius.circular(
                Adapt.px(20),
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(const Color(0xFFFFFFFF)),
              ),
              SizedBox(height: Adapt.px(30)),
              const Text(
                'Working',
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: 14,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
