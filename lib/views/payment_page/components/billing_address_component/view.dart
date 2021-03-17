import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/stripe_address.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    BillingAddressState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        backgroundColor: _theme.primaryColorDark,
        appBar: AppBar(
          backgroundColor: _theme.primaryColorDark,
          brightness: _theme.brightness,
          iconTheme: _theme.iconTheme,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            'Billing Address',
            style: TextStyle(color: _theme.textTheme.bodyText1.color),
          ),
          actions: [
            _AddButton(
              onTap: () => dispatch(BillingAddressActionCreator.onCreate()),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: Adapt.px(20)),
          decoration: BoxDecoration(
            color: _theme.backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Adapt.px(60)),
            ),
          ),
          child: state.address == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(_theme.iconTheme.color),
                  ),
                )
              : state.address != null
                  ? ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: Adapt.px(40), vertical: Adapt.px(40)),
                      itemBuilder: (_, index) => _AddressCell(
                        name: state.customerName,
                        address: state.address,
                        onTap: (a) =>
                            dispatch(BillingAddressActionCreator.onEdit(a)),
                      ),
                      separatorBuilder: (_, __) => Divider(),
                      itemCount: state.address == null ? 0 : 1,
                    )
                  : const _EmptyListCell(),
        ),
      );
    },
  );
}

class _AddButton extends StatelessWidget {
  final Function onTap;
  const _AddButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: Adapt.px(20)),
        padding: EdgeInsets.all(Adapt.px(20)),
        child: Center(
          child: Text(
            'Add',
            style: TextStyle(
              color: _theme.textTheme.bodyText1.color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddressCell extends StatelessWidget {
  final String name;
  final StripeAddress address;
  final Function(StripeAddress) onTap;
  const _AddressCell({this.address, this.onTap, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(30), vertical: Adapt.px(30)),
      //height: Adapt.px(140),
      decoration: BoxDecoration(
        // color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(Adapt.px(20)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Adapt.px(28)),
              ),
              SizedBox(height: Adapt.px(10)),
              Text(address?.country ?? ''),
              Text(address?.state ?? ''),
              Text(
                  '${address?.city}, ${address?.line1} ${address?.postalCode}'),
            ],
          ),
          Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () => onTap(address),
            child: Container(
              padding: EdgeInsets.all(Adapt.px(15)),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF9E9E9E)),
                  borderRadius: BorderRadius.circular(Adapt.px(15))),
              child: Icon(
                FontAwesomeIcons.pen,
                size: Adapt.px(20),
                color: const Color(0xFF9E9E9E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyListCell extends StatelessWidget {
  const _EmptyListCell();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const Text(
        'Empty List',
        style: TextStyle(
          color: const Color(0xFF9E9E9E),
          fontSize: 16,
        ),
      ),
    );
  }
}
