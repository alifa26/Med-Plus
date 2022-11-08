import 'package:med/social_app/cubit.dart';
import 'package:med/social_app/messages.dart';
import 'package:med/social_app/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart';
import 'message_model.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder:(context, state) {
        return ListView.separated(
                itemBuilder: (context, index) => BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        navigateTo(
                          context,
                          MessagesScreen(
                            userDataModel: AppBloc.get(context).usersList[index],
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              if (AppBloc.get(context)
                                  .usersList[index]
                                  .image
                                  .isNotEmpty)
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(
                                    AppBloc.get(context).usersList[index].image,
                                  ),
                                ),
                              if (AppBloc.get(context)
                                  .usersList[index]
                                  .image
                                  .isEmpty)
                                CircleAvatar(
                                  radius: 20.0,
                                  child: Center(
                                    child: Text(
                                      AppBloc.get(context)
                                          .usersList[index]
                                          .username
                                          .characters
                                          .first,
                                      style: const TextStyle(
                                        fontSize: 26.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              space10Horizontal(context),
                              Expanded(
                                child: Text(
                                  AppBloc.get(context).usersList[index].username,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
    
                              // IconButton(
                              //   padding: EdgeInsets.zero,
                              //   onPressed: () {},
                              //   icon: Icon(
                              //     Icons.more_vert,
                              //     size: 16.0,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                separatorBuilder: (context, index) => space10Vertical(context),
                itemCount: AppBloc.get(context).usersList.length,
              );
      }
    );
}}

