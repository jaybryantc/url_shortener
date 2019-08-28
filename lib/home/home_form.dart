import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class HomeForm extends StatelessWidget {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var blocListener = BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccessful) {
          _showSnackbar(
            context,
            state.shortenURL,
            actionLabel: 'Copy',
            onActionPressed: () => _copyToClipboard(context, state.shortenURL),
          );
        } else if (state is HomeFailure) {
          _showSnackbar(
            context,
            state.error.toString(),
            actionLabel: 'OK',
            onActionPressed: () => HomeScreen.homeScaffoldKey.currentState.hideCurrentSnackBar(),
          );
        } else if (state is CopyToClipboardSuccessful) {
          _showSnackbar(
            context,
            'Copied!',
            actionLabel: 'OK',
            onActionPressed: () => HomeScreen.homeScaffoldKey.currentState.hideCurrentSnackBar(),
          );
        }
      },
      child: SafeArea(
        child: AnimatedContainer(
            color: Colors.white,
            duration: Duration(
              seconds: 5,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 10,
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    height: 180,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            labelText: 'Paste URL here',
                            labelStyle: TextStyle(color: Colors.white),
                            hasFloatingPlaceholder: true,
                          ),
                          minLines: 1,
                          maxLines: 1,
                          onFieldSubmitted: (longUrl) => _shortenURL(context, longUrl),
                          controller: textController,
                          keyboardType: TextInputType.url,
                        ),
                        SizedBox(height: 15),
                        BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                          var buttonLabel = 'Shorten';
                          if (state is HomeLoading) {
                            buttonLabel = 'Shortening...';
                          }
                          return RaisedButton(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.25,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            onPressed: () => _shortenURL(context, textController.text),
                            child: Text(buttonLabel.toUpperCase()),
                            textColor: Theme.of(context).primaryColor,
                            color: Colors.white,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );

    return blocListener;
  }

  void _shortenURL(BuildContext context, String longURL) {
    BlocProvider.of<HomeBloc>(context).dispatch(ShortenURLPressed(longURL));
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _copyToClipboard(BuildContext context, String shortURL) {
    BlocProvider.of<HomeBloc>(context).dispatch(LinkCopied(shortURL));
    HomeScreen.homeScaffoldKey.currentState.hideCurrentSnackBar();
  }

  void _showSnackbar(
    BuildContext context,
    String message, {
    @required String actionLabel,
    @required VoidCallback onActionPressed,
  }) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(
        label: actionLabel,
        onPressed: onActionPressed,
      ),
    ));
  }
}
