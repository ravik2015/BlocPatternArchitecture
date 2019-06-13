import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rockfarm/blocs/UserBloc.dart';
import 'package:rockfarm/model/userResponse.dart';
import 'package:rockfarm/model/user.dart';

class UserWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserWidgetState();
  }
}

// _UserWidgetState is class which implements UserWidget state.
// In initState we inform bloc that is time to load data
class _UserWidgetState extends State<UserWidget> {
  @override
  void initState() {
    super.initState();
    bloc.getUser();
  }

  @override
  Widget build(BuildContext context) {
    //  In Streambuilder’s builderparameter we decide what should be displayed at this moment.
    //  When there is no data yet, we will show loading widget which is build by _buildLoadingWidget method
    return StreamBuilder<UserResponse>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<UserResponse> snapshot) {
        print("snapshosnapshotsnapshot$snapshot");
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildUserWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Loading data from API...",
            style: Theme.of(context).textTheme.subtitle),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error",
            style: Theme.of(context).textTheme.subtitle),
      ],
    ));
  }

  Widget _buildUserWidget(UserResponse data) {
    User user = data.results[0];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(user.picture.large),
          ),
          Text(
            "${_capitalizeFirstLetter(user.name.first)} ${_capitalizeFirstLetter(user.name.last)}",
            style: Theme.of(context).textTheme.title,
          ),
          Text(user.email, style: Theme.of(context).textTheme.subtitle),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Text(user.location.street, style: Theme.of(context).textTheme.body1),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Text(user.location.city, style: Theme.of(context).textTheme.body1),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Text(user.location.state, style: Theme.of(context).textTheme.body1),
        ],
      ),
    );
  }

  _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(0, text.length);
  }
}
