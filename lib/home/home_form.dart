import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class HomeForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  String buttonLabel = 'Shorten';
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeInitial) {
          setState(() {
            buttonLabel = 'Shorten';
          });
        } else if (state is HomeLoading) {
          setState(() {
            buttonLabel = 'Shortening...';
          });
        } else if (state is HomeSuccessful) {
          setState(() {
            buttonLabel = 'Shorten';
          });
          _showSnackbar(
            state.shortenURL,
            actionLabel: 'Copy',
            onActionPressed: () => BlocProvider.of(context).dispatch(LinkCopied(state.shortenURL)),
          );
        } else if (state is HomeFailure) {
          setState(() {
            buttonLabel = 'Shorten';
          });
          _showSnackbar(
            state.error.toString(),
            actionLabel: 'OK',
            onActionPressed: () {},
          );
        } else if (state is CopyToClipboardSuccessful) {
          _showSnackbar(
            'Copied!',
            actionLabel: 'OK',
            onActionPressed: () {},
          );
        } else if (state is CopyToClipboardFailure){
          _showSnackbar(
            'Unable to copy.',
            actionLabel: 'OK',
            onActionPressed: () {},
          );
        }
      },
      child: SafeArea(
        child: AnimatedContainer(
          color: Colors.white,
          duration: Duration(
            seconds: 5,
          ),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return Card(
                        elevation: 10,
                        color: Theme.of(context).primaryColor,
                        child: Container(
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
                                onFieldSubmitted: (longUrl) =>
                                    BlocProvider.of<HomeBloc>(context).dispatch(ShortenURLPressed(longUrl)),
                                controller: textController,
                              ),
                              SizedBox(height: 15),
                              RaisedButton(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.25,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                onPressed: () =>
                                    BlocProvider.of<HomeBloc>(context).dispatch(ShortenURLPressed(textController.text)),
                                child: Text(buttonLabel.toUpperCase()),
                                textColor: Theme.of(context).primaryColor,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackbar(
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
