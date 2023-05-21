import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/base_state.dart';
import '../models/home_page_response.dart';
import 'home_bloc.dart';
import 'home_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeBloc(initialState: Loading());
  HomePageResponse response = HomePageResponse();
  String? newsImage = "";

  @override
  void initState() {
    callHomePageApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width>=1250
          ?AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           // Container(
           //   width: 50,
           //     child: Image.asset("assets/images/hidoc_logo.jpg",width: 20,height: 20,)) ,
            Text("Hidoc",style: TextStyle(color: Colors.black),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Social",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                Text("Cases",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                Text("Quizzes",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                Text("Articles",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                Text("Drugs",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                Text("Webinars",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                Text("Calculators",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                Text("Guidelines",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                Text("Surveys",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                Text("Clinical Trails",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.search,color: Colors.black),
                Icon(Icons.menu,color: Colors.black),
               Container(
                 width: 20,
                 padding: EdgeInsets.all(4),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(100),
                   border: Border.all(width: 1,color: Colors.black)
                 ),
                 child: Text("G",style: TextStyle(color: Colors.black,fontSize: 12),),
               )
              ],
            ),

          ],
        ),
      )
          :null,
      body: BlocProvider(
          create: (_) => _bloc,
          child: BlocBuilder<HomeBloc, BaseState>(builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DataLoaded) {
              if (state.event == "GetHomePageDetails") {
                response = state.data;
                newsImage = response.data!.news![1].urlToImage;
              }
            }

            if (state is Error) {
              return const Center(
                child: Text(
                  'error',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              );
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 1250) {
                  return SingleChildScrollView(
                    child: Container(
                      color: Colors.grey.shade200,
                      child: Column(
                        children: [
                          titleWidget(constraints.maxWidth),
                          dropDownWidget(constraints.maxWidth),
                          const SizedBox(height: 50,),
                          articleWidget(constraints.maxWidth),
                         Container(
                           margin:const EdgeInsets.only(left: 200, right: 200),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Flexible(
                                 flex: 1,
                                 child: hidocBulletinWidget(constraints.maxWidth),
                               ),
                               Flexible(
                                   flex: 1,
                                   child: hidocTrendingBulletinWidget(constraints.maxWidth)),
                             ],
                           ),
                         ),
                          readMoreArticleWidget(constraints.maxWidth),
                          Container(
                            margin:const EdgeInsets.only(left: 200, right: 200),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: latestArticleWidget(constraints.maxWidth),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: trendingArticleWidget(constraints.maxWidth),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        exploreMoreArticleWidget(constraints.maxWidth),
                                        exploreHidocDrWidget(constraints.maxWidth),
                                      ],
                                    )
                                ),

                              ],
                            ),
                          ),
                          whatsMoreOnHidocDr(constraints.maxWidth),
                          const SizedBox(height: 20,),
                          Container(
                            margin:const EdgeInsets.only(left: 200, right: 200),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: newsWidget(constraints.maxWidth),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: quizzesWidget(constraints.maxWidth),
                                ),

                              ],
                            ),
                          ),
                          visitWidget(constraints.maxWidth),
                          const SizedBox(height: 20,),

                          addsCardWidget(),




                        ],
                      ),
                    ),
                  );
                  // } else if (constraints.maxWidth >= 650) {
                  //   return tabletBuilder(context, constraints);
                } else {
                  return Container(
                    decoration: const BoxDecoration(
                        // color: Colors.cyanAccent,
                        image: DecorationImage(
                            image: AssetImage("assets/images/img.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        titleWidget(constraints.maxWidth),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dropDownWidget(constraints.maxWidth),
                                const SizedBox(
                                  height: 20,
                                ),
                                articleWidget(constraints.maxWidth),
                                hidocBulletinWidget(constraints.maxWidth),
                                const SizedBox(
                                  height: 10,
                                ),
                                hidocTrendingBulletinWidget(constraints.maxWidth),
                                const SizedBox(
                                  height: 20,
                                ),
                                readMoreArticleWidget(constraints.maxWidth),
                                const SizedBox(
                                  height: 40,
                                ),
                                latestArticleWidget(constraints.maxWidth),
                                const SizedBox(
                                  height: 40,
                                ),
                                trendingArticleWidget(constraints.maxWidth),
                                const SizedBox(
                                  height: 40,
                                ),
                                exploreMoreArticleWidget(constraints.maxWidth),
                                exploreHidocDrWidget(constraints.maxWidth),
                                whatsMoreOnHidocDr(constraints.maxWidth),
                                newsWidget(constraints.maxWidth),
                                quizzesWidget(constraints.maxWidth),
                                const SizedBox(
                                  height: 20,
                                ),
                                visitWidget(constraints.maxWidth),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 5,
                          color: Colors.black,
                          margin: const EdgeInsets.only(
                              left: 100, right: 100, bottom: 0),
                          // child: const Divider(thickness: 2,)
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  );
                }
              },
            );
          })),
    );
  }

  Widget titleWidget(double maxWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible:maxWidth<1250 ,
          child: Container(
            margin: const EdgeInsets.only(left: 20, top: 50),
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.width / 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 2, color: Colors.white)),
            child: const Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 85, left: 10, right: 10),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 15,
              child: const Text(
                "ARTICLES",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget dropDownWidget(double maxWidth) {
    return Container(
      decoration: maxWidth>=1250? BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(15),
      ):BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding:  maxWidth>=1250?const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10):const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin:  maxWidth>=1250?const EdgeInsets.only(left: 350, right: 350):const EdgeInsets.only(left: 50, right: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(),
          Center(
              child: Text(
            "Critical Care",
            style: TextStyle(fontSize: 14),
          )),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  Widget articleWidget(double maxWidth) {
    return maxWidth>=1250
        ? Column(
          children: [
            Container(
      margin:const EdgeInsets.only(left: 200, right: 200),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              Stack(
                children: [
                  Container(
                    child:  response.data?.article!.articleImg != ""
                        ? Image.network(
                      "${response.data?.article!.articleImg}",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width/4.5,
                      height: MediaQuery.of(context).size.width/7,
                    )
                        : Image.asset(
                      "assets/images/empty_image.png",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width/4.5,
                      height: MediaQuery.of(context).size.width/7,
                    ),
                  ),
                  Positioned(
                    bottom: 0,right:0,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(30)),
                          color: Colors.cyan,
                        ),
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 10, left: 20, right: 20),
                        child: Column(
                          children: [
                            const Text("Points"),
                            Text("${response.data?.article!.rewardPoints}"),
                          ],
                        ),
                      ),),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "${response.data?.article!.articleTitle}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 0, bottom: 30),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Text("${response.data?.article!.articleDescription}"),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: const Text("Read full Article to earn points",
                          style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic)),
                    ),
                    onTap: () {
                      //Todo
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Text("Published Date: ${response.data?.article!.createdAt}",style: const TextStyle(fontSize: 12,color: Colors.grey),),
                  ),
                ],
              )

      ],
    ),
            ),
            const SizedBox(height: 40,),
            Container(
                margin:const EdgeInsets.only(left: 200, right: 200),
                child: const Divider(thickness: 0.5,color: Colors.grey,))
          ],
        )
        : Card(
      margin:const EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
          child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          response.data?.article!.articleImg != ""
              ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
          ),
                child: Image.network(
                    "${response.data?.article!.articleImg}",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                  ),
              )
              : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
                child: Image.asset(
                    "assets/images/empty_image.png",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                  // alignment: Alignment.center,
                  ),
              ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "${response.data?.article!.articleTitle}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 0, bottom: 30),
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Text("${response.data?.article!.articleDescription}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: const Text("Read full Article to earn points",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic)),
                ),
                onTap: () {
                  //Todo
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(25)),
                  color: Colors.cyan,
                ),
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    const Text("Points"),
                    Text("${response.data?.article!.rewardPoints}"),
                  ],
                ),
              ),
            ],
          ),
      ],
    ),
        );
  }

  Widget hidocBulletinWidget(double maxWidth) {
    return Container(
      margin: maxWidth>=1250?const EdgeInsets.only(left: 0, right: 0,top: 5): const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: maxWidth>=1250? const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0):const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child:  Text(
              "Hidoc Bulletin",
              style: TextStyle(fontSize: maxWidth>=1250?20:20, fontWeight: FontWeight.bold),
            ),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: response.data?.bulletin?.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: index==0&&maxWidth>=1250?Colors.grey.shade300:Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 120,
                        width: maxWidth>=1250?MediaQuery.of(context).size.width / 9:MediaQuery.of(context).size.width /4.59,
                        color: Colors.cyan,
                        margin:  EdgeInsets.only(
                            top: maxWidth>=1250?50:0, left: maxWidth>=1250?0:10, right: 10, bottom: 10),
                      ),
                      Container(
                        margin:  EdgeInsets.only(
                            top: 0, left: maxWidth>=1250?0:10, right: 10, bottom: 0),
                        child: Text(
                          "${response.data?.bulletin![index].articleTitle}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin:  EdgeInsets.only(
                            top: 0, left: maxWidth>=1250?0:10, right: 10, bottom: 0),
                        child: Text(
                          "${response.data?.bulletin![index].articleDescription}",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                            margin:  EdgeInsets.only(
                                top: 15, left: maxWidth>=1250?0:10, right: 10, bottom: 0),
                            child: const Text(
                              "Read More",
                              style: TextStyle(
                                  color: Colors.cyan,
                                  fontSize: 13,
                                  decoration: TextDecoration.underline),
                            )),
                        onTap: () {
                          //Todo
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget hidocTrendingBulletinWidget(double maxWidth) {
    return Visibility(
      visible: true,
      child: Container(
        margin: maxWidth>=1250?const EdgeInsets.only(left: 0, right: 0): const EdgeInsets.only(left: 15, right: 15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.cyan.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, left: maxWidth>=1250?30:15, right: 5,bottom: maxWidth>=1250?5:0),
                child: const Text(
                  "Trending Hidoc Bulletin",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: response.data?.trandingBulletin?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: maxWidth>=1250?30:15, right: 15, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${response.data?.trandingBulletin![index].articleTitle}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${response.data?.trandingBulletin![index].articleDescription}",
                          style: TextStyle(color: Colors.grey.shade700),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 0, left: 0, right: 5, bottom: 0),
                              child: const Text(
                                "Read More",
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 13,
                                    decoration: TextDecoration.underline),
                              )),
                          onTap: () {
                            //Todo
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget readMoreArticleWidget(double maxWidth){
    return   Container(
      margin: maxWidth>=1250? const EdgeInsets.only(left: 500, right: 500,top: 40,bottom: 20):const EdgeInsets.only(left: 80, right: 80),
      padding: const EdgeInsets.only(
          top: 10, right: 10, left: 10, bottom: 10),
      decoration:
       BoxDecoration(color: maxWidth>=1250?Colors.cyan:Colors.orange),
      child: const Center(
        child: Text(
          "Read More Articles",
          style: TextStyle(
              color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget latestArticleWidget(double maxWidth) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(border: Border.all(width: 1,color: maxWidth>=1250?Colors.grey:Colors.black)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 5),
            child: const Text(
              "Latest Articles",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 15),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: response.data?.exploreArticle?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          )),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          "${response.data?.exploreArticle![index].articleTitle}",
                          // maxLines: 3,overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget trendingArticleWidget(double maxWidth) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(border: Border.all(width: 1,color: maxWidth>=1250?Colors.grey:Colors.black)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 5),
            child: const Text(
              "Trending Articles",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 15),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: response.data?.trandingArticle?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 0),
                        color: Colors.grey,
                        height: 1,
                        // child: const Divider(thickness: 1,color: Colors.grey,)
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: response
                                    .data?.trandingArticle![index].articleImg !=
                                null
                            ? Image.network(
                                "${response.data?.trandingArticle![index].articleImg}",
                                fit: BoxFit.cover)
                            : Image.asset("assets/images/empty_image.png}",
                                fit: BoxFit.cover),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          "${response.data?.trandingArticle![index].articleTitle}",
                          style: const TextStyle(),
                          // maxLines: 3,overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget exploreMoreArticleWidget(double maxWidth) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(border: Border.all(width: 1,color: maxWidth>=1250?Colors.grey:Colors.black)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 5),
            child: const Text(
              "Explore More Articles",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 15),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: response.data?.exploreArticle?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          )),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          "${response.data?.exploreArticle![index].articleTitle}",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget exploreHidocDrWidget(double maxWidth){
    return Container(
      margin: const EdgeInsets.only(
          left: 20, right: 20, bottom: 20),
      padding: const EdgeInsets.only(
          top: 10, right: 10, left: 10, bottom: 10),
      decoration:
       BoxDecoration(color: maxWidth>=1250?Colors.cyan:Colors.orange),
      child: const Center(
        child: Text(
          "Explore Hidoc Dr.",
          style: TextStyle(
              color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget whatsMoreOnHidocDr(double maxWidth){
    return Container(
      margin: const EdgeInsets.only(
          top: 0, left: 10, right: 10, bottom: 10),
      child: const Center(
          child: Text(
            "What's more on Hidoc Dr.",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget newsWidget(double maxWidth) {
    return Container(
      margin:  EdgeInsets.only(top: maxWidth>=1250?0:20, bottom: 20),
      width: MediaQuery.of(context).size.width,
      // height: 220,
      child: maxWidth>=1250
          ?Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: const Text(
                      "News",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 15, left: 0, right: 5, bottom: 50),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: response.data?.news?.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                child: Text(
                                  "${response.data?.news![index].title}",
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              // color: Colors.grey,
              margin: const EdgeInsets.only(
                left: 0,
                right: 0,
              ),
              child: newsImage != null
                  ? Image.network(
                newsImage!,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
              )
                  : Image.asset(
                "assets/images/makeup1.jpg",
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,

              ),
            ),
          ),
        ],
      )
          :Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            margin: const EdgeInsets.only(left: 20, right: 20),
            // decoration: BoxDecoration(
            //     border: Border.all(width: 1)
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: const Text(
                    "News",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 15, left: 5, right: 5, bottom: 50),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: response.data?.news?.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Text(
                                "${response.data?.news![index].title}",
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.grey,
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: newsImage != null
                ? Image.network(
              newsImage!,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
            )
                : Image.asset(
              "assets/images/makeup1.jpg",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget quizzesWidget(double maxWidth) {
    return maxWidth>=1250?Container(
      margin:  EdgeInsets.only(left: maxWidth>=1250?10:20, right: 20),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 0.5, color: Colors.grey),
                        color: Colors.cyan.shade50),
                    padding: const EdgeInsets.all(2.0),
                    child: const Icon(
                      Icons.wine_bar_outlined,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width / 7,
                  padding: EdgeInsets.zero,
                  child: const Text(
                    "Quizzes :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Flexible(
                flex: 3,
                  child: Text("Participate & Win Existing Prizes"))
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: const Divider(
                thickness: 1,
              )),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 0.5, color: Colors.grey),
                        color: Colors.cyan.shade50),
                    padding: const EdgeInsets.all(2.0),
                    child: const Icon(
                      Icons.calculate,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width / 5.5,
                  padding: EdgeInsets.zero,
                  child: const Text(
                    "Medical Calculators :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Flexible(
                flex: 3,
                  child: Text("Get Access to 800+ Evidenced Based Calculators"))
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: const Divider(
                thickness: 1,
              )),
        ],
      ),
    ):Container(
      margin:  EdgeInsets.only(left: maxWidth>=1250?10:20, right: 20),
      decoration:
      BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 0.5, color: Colors.grey),
                      color: Colors.cyan.shade50),
                  padding: const EdgeInsets.all(2.0),
                  child: const Icon(
                    Icons.wine_bar_outlined,
                    color: Colors.cyan,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 7,
                padding: EdgeInsets.zero,
                child: const Text(
                  "Quizzes :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Flexible(child: Text("Participate & Win Existing Prizes"))
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: const Divider(
                thickness: 1,
              )),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 0.5, color: Colors.grey),
                      color: Colors.cyan.shade50),
                  padding: const EdgeInsets.all(2.0),
                  child: const Icon(
                    Icons.calculate,
                    color: Colors.cyan,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5.5,
                padding: EdgeInsets.zero,
                child: const Text(
                  "Medical Calculators :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Flexible(
                  child: Text("Get Access to 800+ Evidenced Based Calculators"))
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: const Divider(
                thickness: 1,
              )),
        ],
      ),
    );
  }

  Widget visitWidget(double maxWidth){
    return Container(
      margin:  EdgeInsets.only(
        left: maxWidth>=1250?200:20,
        right: maxWidth>=1250?200:20,
      ),
      padding:  EdgeInsets.only(
          top: 20, bottom: 20, left: 20, right: maxWidth>=1250?20:10),
      color: maxWidth>=1250?Colors.cyan.shade100:Colors.orange.shade200,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          maxWidth>=1250?const Text("Social Network for Doctors - A Special feture on Hidoc Dr.",
            style: TextStyle(
                fontWeight: FontWeight.bold),
          ):const Text("Social Network for Doctors -\nA Special feture on Hidoc Dr.",
            style: TextStyle(
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(15),
                  color: maxWidth>=1250?Colors.cyan:Colors.orange),
              padding:  maxWidth>=1250?const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10):const EdgeInsets.all(8),
              child: const Text(
                "Visit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            onTap: () {
              //Todo
            },
          )
        ],
      ),
    );
  }

  Widget addsCardWidget(){
    return Container(
      margin: const EdgeInsets.only(left: 0,right: 0,),
      color: Colors.grey.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
                width: MediaQuery.of(context).size.width/3.5,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/images/adds_image1.jpg",alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),


              ),
              Container(
                height: 180,
                padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
                width: MediaQuery.of(context).size.width/3.5,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/images/adds_image2.jpg",alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),


              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
                width: MediaQuery.of(context).size.width/3.5,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/images/adds_image3.jpg",alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),


              ),
              Container(
                height: 180,
                padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
                width: MediaQuery.of(context).size.width/3.5,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/images/adds_image4.jpg",alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),


              ),

            ],
          ),
        ],
      ),

    );
  }



  callHomePageApi() {
    _bloc.add(GetHomePageDetails(sId: "500", uuId: "", userId: "423914"));
  }
}
