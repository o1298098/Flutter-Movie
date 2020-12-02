import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/loading_layout.dart';
import 'package:movie/models/country_phone_code.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CreateAddressState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Stack(children: [
        Scaffold(
          //resizeToAvoidBottomPadding: false,
          backgroundColor: _theme.primaryColorDark,
          appBar: AppBar(
            backgroundColor: _theme.primaryColorDark,
            brightness: _theme.brightness,
            iconTheme: _theme.iconTheme,
            elevation: 0.0,
            centerTitle: false,
            title: Text(
              '${state.address == null ? 'Create' : 'Edit'} Address',
              style: TextStyle(color: _theme.textTheme.bodyText1.color),
            ),
            actions: [
              _SaveButton(
                onTap: () => dispatch(CreateAddressActionCreator.onSave()),
              )
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(top: Adapt.px(20)),
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            decoration: BoxDecoration(
              color: _theme.backgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Adapt.px(60)),
              ),
            ),
            child: ListView(
              children: [
                SizedBox(height: Adapt.px(80)),
                _RegionCell(
                  countries: state.countries ?? [],
                  region: state.region,
                  onTap: (d) =>
                      dispatch(CreateAddressActionCreator.setRegion(d)),
                ),
                SizedBox(height: Adapt.px(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CustomTextField(
                      controller: state.firstNameController,
                      width: Adapt.px(300),
                      title: 'Name',
                    ),
                    _CustomTextField(
                      controller: state.cityController,
                      width: Adapt.px(300),
                      title: 'City',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CustomTextField(
                      controller: state.provinceController,
                      width: Adapt.px(300),
                      title: 'State/Province',
                    ),
                    _CustomTextField(
                      controller: state.postalCodeController,
                      width: Adapt.px(300),
                      title: 'Postal Code',
                    ),
                  ],
                ),
                _CustomTextField(
                  controller: state.streetAddressController,
                  title: 'Street Address',
                ),
                _CustomTextField(
                  controller: state.extendedAddressController,
                  title: 'Extended Address',
                ),
                SizedBox(height: Adapt.px(30)),
                _DeleteButton(
                  show: state.address != null,
                  onTap: () => dispatch(CreateAddressActionCreator.onDelete()),
                ),
              ],
            ),
          ),
        ),
        LoadingLayout(
          title: 'Loading',
          show: state.loading,
        )
      ]);
    },
  );
}

class _SaveButton extends StatelessWidget {
  final Function onTap;
  const _SaveButton({this.onTap});
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
            'Save',
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

class _DeleteButton extends StatelessWidget {
  final bool show;
  final Function onTap;
  const _DeleteButton({this.onTap, @required this.show});
  @override
  Widget build(BuildContext context) {
    return show
        ? GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Adapt.px(25)),
              decoration: BoxDecoration(
                  color: Color(0xFFFF0000),
                  borderRadius: BorderRadius.circular(Adapt.px(20))),
              child: Center(
                  child: Text(
                'DELETE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(30),
                  color: const Color(0xFFFFFFFF),
                ),
              )),
            ))
        : SizedBox();
  }
}

class _RegionCell extends StatelessWidget {
  final List<CountryPhoneCode> countries;
  final CountryPhoneCode region;
  final Function(CountryPhoneCode) onTap;
  const _RegionCell({this.countries, this.region, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Region', style: TextStyle(fontSize: Adapt.px(30))),
        SizedBox(height: Adapt.px(20)),
        GestureDetector(
          onTap: () => showDialog(
              context: context,
              builder: (_) => _CountryCodeDialog(
                    countries: countries,
                    onCellTap: onTap,
                  )),
          child: Container(
            height: Adapt.px(85),
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(20)),
              border: Border.all(color: Color(0xFF9E9E9E)),
            ),
            child: region == null
                ? Container(
                    alignment: Alignment.centerLeft,
                    width: Adapt.screenW(),
                    child: Text(
                      '-',
                      style: TextStyle(fontSize: Adapt.px(30)),
                    ))
                : Row(
                    children: [
                      Text(
                        region.flag,
                        style: TextStyle(fontSize: Adapt.px(30)),
                      ),
                      SizedBox(width: Adapt.px(30)),
                      SizedBox(
                        width: Adapt.screenW() - Adapt.px(250),
                        child: Text(
                          region.name,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
          ),
        )
      ],
    );
  }
}

class _CountryCodeDialog extends StatefulWidget {
  final List<CountryPhoneCode> countries;
  final Function(CountryPhoneCode) onCellTap;
  const _CountryCodeDialog({@required this.countries, this.onCellTap});
  @override
  _CountryCodeDialogState createState() => _CountryCodeDialogState();
}

class _CountryCodeDialogState extends State<_CountryCodeDialog> {
  final _width = Adapt.screenW() - Adapt.px(80);
  List<CountryPhoneCode> _countries;
  TextEditingController _controller;
  @override
  void initState() {
    _countries = widget.countries;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(30))),
      contentPadding: EdgeInsets.zero,
      title: Theme(
        child: TextField(
          controller: _controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            filled: true,
            prefixStyle: TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
            ),
          ),
          onChanged: (str) {
            _countries = widget.countries
                .where((e) => e.name.toUpperCase().contains(str.toUpperCase()))
                .toList();
            setState(() {});
          },
        ),
        data: Theme.of(context).copyWith(
          primaryColor: Colors.black87,
        ),
      ),
      children: <Widget>[
        Container(
          height: Adapt.screenH() / 2,
          width: _width,
          child: ListView.separated(
            padding: EdgeInsets.all(Adapt.px(40)),
            separatorBuilder: (_, __) => Divider(
              height: 25,
            ),
            itemCount: _countries.length,
            itemBuilder: (_, index) {
              final d = _countries[index];
              return _CountryCell(
                data: d,
                onTap: widget.onCellTap,
              );
            },
          ),
        )
      ],
    );
  }
}

class _CountryCell extends StatelessWidget {
  final CountryPhoneCode data;
  final Function(CountryPhoneCode) onTap;
  _CountryCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _width = Adapt.screenW() - Adapt.px(80);
    final _textStyle = TextStyle(fontSize: Adapt.px(28));
    return InkWell(
      key: ValueKey(data.name),
      onTap: () {
        onTap(data);
        Navigator.of(context).pop();
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(data.flag, style: _textStyle),
            SizedBox(width: Adapt.px(20)),
            Container(
              constraints: BoxConstraints(maxWidth: _width - Adapt.px(200)),
              child: Text(data.name, style: _textStyle),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String title;
  final double width;
  final TextEditingController controller;
  const _CustomTextField({this.title, this.width, this.controller});
  @override
  Widget build(BuildContext context) {
    final _intputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(Adapt.px(20)),
        borderSide: BorderSide(color: const Color(0xFF9E9E9E)));
    return Container(
      width: width ?? Adapt.screenW(),
      padding: EdgeInsets.only(bottom: Adapt.px(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: Adapt.px(30))),
          SizedBox(height: Adapt.px(20)),
          TextField(
            controller: controller,
            cursorColor: const Color(0xFF9E9E9E),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              enabledBorder: _intputBorder,
              disabledBorder: _intputBorder,
              focusedBorder: _intputBorder,
            ),
          ),
        ],
      ),
    );
  }
}
