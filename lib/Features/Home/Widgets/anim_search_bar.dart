import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/Features/Home/Screens/home_screen.dart';
import 'package:get/get.dart';

class AnimSearchBar extends StatefulWidget {
  final double width;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;

  const AnimSearchBar({
    Key? key,

    /// The width cannot be null
    required this.width,

    /// The textController cannot be null
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",

    /// choose your custom color
    this.color = Colors.white,

    /// The onSuffixTap cannot be null
    required this.onSuffixTap,
    this.animationDurationInMilli = 375,

    /// make the search bar to open from right to left
    this.rtl = false,

    /// make the keyboard to show automatically when the searchbar is expanded
    this.autoFocus = false,

    /// TextStyle of the contents inside the searchbar
    this.style,

    /// close the search on suffix tap
    this.closeSearchOnSuffixTap = false,

    /// can add list of inputformatters to control the input
    this.inputFormatters,
    this.borderRadius = 15.0,
  }) : super(key: key);

  @override
  _AnimSearchBarState createState() => _AnimSearchBarState();
}

///toggle - 0 => false or closed
///toggle 1 => true or open
int toggle = 0;

class _AnimSearchBarState extends State<AnimSearchBar>
    with SingleTickerProviderStateMixin {
  ///initializing the AnimationController
  late AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    ///Initializing the animationController which is responsible for the expanding and shrinking of the search bar
    _con = AnimationController(
      vsync: this,

      /// animationDurationInMilli is optional, the default value is 375
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,

      ///if the rtl is true, search bar will be from right to left
      alignment: widget.rtl ? Alignment.centerRight : Alignment(-1.0, 0.0),

      ///Using Animated container to expand and shrink the widget
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: 48.0,
        width: (toggle == 0) ? 48.0 : widget.width,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          /// can add custom color or the color will be white
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: -10.0,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Stack(
          children: [
            ///Using Animated Positioned widget to expand and shrink the widget
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 6.0,
              right: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    /// can add custom color or the color will be white
                    color: widget.color,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AnimatedBuilder(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          ///trying to execute the onSuffixTap function
                          widget.onSuffixTap();

                          ///closeSearchOnSuffixTap will execute if it's true
                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });
                          }
                        } catch (e) {
                          ///print the error if the try block fails
                          print(e);
                        }
                      },

                      ///suffixIcon is of type Icon
                      child: widget.suffixIcon != null
                          ? widget.suffixIcon
                          : Icon(
                              Icons.close,
                              size: 20.0,
                            ),
                    ),
                    builder: (context, widget) {
                      ///Using Transform.rotate to rotate the suffix icon when it gets expanded
                      return Transform.rotate(
                        angle: _con.value * 2.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: 11.0,

              ///Using Animated opacity to change the opacity of th textField while expanding
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 4.0),
                  alignment: Alignment.topCenter,
                  width: widget.width / 1.7,
                  child: TextField(
                    ///Text Controller. you can manipulate the text inside this textField by calling this controller.
                    controller: widget.textController,
                    inputFormatters: widget.inputFormatters,
                    focusNode: focusNode,
                    cursorRadius: Radius.circular(10.0),
                    cursorWidth: 2.0,
                    onEditingComplete: () {
                      /// on editing complete the keyboard will be closed and the search bar will be closed
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                    },

                    ///style is of type TextStyle, the default is just a color black
                    style: widget.style != null
                        ? widget.style
                        : TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: widget.helpText,
                      labelStyle: TextStyle(
                        color: Color(0xff5B5B5B),
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///Using material widget here to get the ripple effect on the prefix icon
            Material(
              /// can add custom color or the color will be white
              color: widget.color,
              borderRadius: BorderRadius.circular(30.0),

              child: Padding(
                padding: const EdgeInsets.only(left: 3.8, top: 3.8),
                child: IconButton(
                  splashRadius: 21.0,

                  ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                  ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                  ///prefixIcon is of type Icon
                  icon: widget.prefixIcon != null
                      ? toggle == 1
                          ? Icon(Icons.arrow_back_ios)
                          : widget.prefixIcon!
                      : Icon(
                          toggle == 1 ? Icons.arrow_back_ios : Icons.search,
                          size: 20.0,
                        ),
                  onPressed: () {
                    setState(
                      () {
                        ///if the search bar is closed
                        if (toggle == 0) {
                          toggle = 1;
                          setState(() {
                            ///if the autoFocus is true, the keyboard will pop open, automatically
                            if (widget.autoFocus)
                              FocusScope.of(context).requestFocus(focusNode);
                          });

                          ///forward == expand
                          _con.forward();
                        } else {
                          ///if the search bar is expanded
                          toggle = 0;

                          ///if the autoFocus is true, the keyboard will close, automatically
                          setState(() {
                            if (widget.autoFocus) unfocusKeyboard();
                          });

                          ///reverse == close
                          _con.reverse();
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 


 /*
 IconButton(
                splashRadius: 19.0,

                ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                ///prefixIcon is of type Icon
                icon: widget.prefixIcon != null
                    ? toggle == 1
                        ? Icon(Icons.arrow_back_ios)
                        : widget.prefixIcon!
                    : Icon(
                        toggle == 1 ? Icons.arrow_back_ios : Icons.search,
                        size: 20.0,
                      ),
                onPressed: () {
                  setState(
                    () {
                      ///if the search bar is closed
                      if (toggle == 0) {
                        toggle = 1;
                        setState(() {
                          ///if the autoFocus is true, the keyboard will pop open, automatically
                          if (widget.autoFocus)
                            FocusScope.of(context).requestFocus(focusNode);
                        });

                        ///forward == expand
                        _con.forward();
                      } else {
                        ///if the search bar is expanded
                        toggle = 0;

                        ///if the autoFocus is true, the keyboard will close, automatically
                        setState(() {
                          if (widget.autoFocus) unfocusKeyboard();
                        });

                        ///reverse == close
                        _con.reverse();
                      }
                    },
                  );
                },
              ),
 
  */
