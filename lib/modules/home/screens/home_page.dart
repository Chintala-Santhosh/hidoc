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

  @override
  void initState() {
    callHomePageApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return Container(
              decoration: const BoxDecoration(
                  // color: Colors.cyanAccent,
                  image: DecorationImage(
                      image: AssetImage("assets/images/img.png"),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  titleWidget(),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          dropDownWidget(),
                          const SizedBox(height: 20,),
                          articleWidget(),
                          hidocBulletinWidget(),
                          const SizedBox(height: 10,),
                          hidocTrendingBulletinWidget(),
                          const SizedBox(height: 20,),
                          Container(
                            margin: const EdgeInsets.only(left: 80, right: 80),
                            padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                            decoration:
                                const BoxDecoration(color: Colors.orange),
                            child: const Center(child: Text("Read More Articles",style: TextStyle(color: Colors.white,fontSize: 16),),),
                          ),
                          const SizedBox(height: 40,),
                          latestArticleWidget(),
                          const SizedBox(height: 40,),
                          trendingArticleWidget(),
                          const SizedBox(height: 40,),
                          exploreMoreArticleWidget(),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20,bottom: 20),
                            padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                            decoration:
                            const BoxDecoration(color: Colors.orange),
                            child: const Center(child: Text("Explore Hidoc Dr.",style: TextStyle(color: Colors.white,fontSize: 16),),),

                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 0, left: 10, right: 10,bottom: 10),
                            child: const Center(child: Text("What's more on Hidoc Dr.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                          ),
                          newsWidget(),
                          quizzesWidget(),
                          const SizedBox(height: 20,),
                          Container(
                            margin: const EdgeInsets.only(left: 20,right: 20,),
                            padding: const EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 10),
                            color: Colors.orange.shade200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Social Network for Doctors -\nA Special feture on Hidoc Dr.",style: TextStyle(fontWeight: FontWeight.bold),),
                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.orange
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: const Text("Visit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                  ),
                                  onTap: (){
                                    //Todo
                                  },
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                    color: Colors.black,
                    margin: const EdgeInsets.only(left: 100,right: 100,bottom: 0),
                    // child: const Divider(thickness: 2,)
                  ),
                  const SizedBox(height: 5,)
                ],
              ),
            );
          })),
    );

  }

  Widget titleWidget(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 50),
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: Colors.white)),
          child: const Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 85, left: 10, right: 10),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 15,
              child: const Text(
                "ARTICLES",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget dropDownWidget(){
    return  Container(

      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),
      margin: const EdgeInsets.only(
          left: 20, right: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(),
          Center(child: Text("Critical Care",style: TextStyle(fontSize: 14),)),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
  Widget articleWidget(){
    return  Card(
      margin: const EdgeInsets.only(
          left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          response.data?.article!.articleImg!=""
              ?  Image.network("${response.data?.article!.articleImg}",fit:BoxFit.fill,width: MediaQuery.of(context).size.width,height: 100,)
              :Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25),),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25),),
                color: Colors.cyan,
              ),
              padding: const EdgeInsets.only(left: 50,right: 50,top: 30,bottom: 30),
              child: Image.asset("assets/images/article-icon-png-27.jpg",color: Colors.black26,width: MediaQuery.of(context).size.width,height: 100,),
              // :const Icon(Icons.my_library_books_outlined,size: 100,),
            ),
          ),

          Container(
            color: Colors.white,
            padding:const EdgeInsets.only(
                top: 10, bottom: 10),
            margin: const EdgeInsets.only(
                left: 20, right: 20),
            child: Text(
              "${response.data?.article!.articleTitle}",style: const TextStyle(fontWeight: FontWeight.bold),),
          ),
          Container(
            padding:const EdgeInsets.only(
                top: 0, bottom: 30),
            margin: const EdgeInsets.only(
                left: 20, right: 20),
            child: Text(
                "${response.data?.article!.articleDescription}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Container(
                  padding:const EdgeInsets.only(
                      top: 20, bottom: 10),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20),
                  child: const Text(
                      "Read full Article to earn points",style: TextStyle(color: Colors.cyan,fontSize: 13,decoration: TextDecoration.underline,fontStyle:FontStyle.italic)),
                ),
                onTap: (){
                  //Todo
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)),
                  color: Colors.cyan,

                ),
                padding:const EdgeInsets.only(
                    top: 20, bottom: 10,left: 20,right: 20),
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
  Widget hidocBulletinWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: 0, left: 10, right: 10,bottom: 10),
            child: const Text("Hidoc Bulletin",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: response.data?.bulletin?.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 120,
                      width: MediaQuery.of(context).size.width / 4.59,
                      color: Colors.cyan,
                      margin: const EdgeInsets.only(
                          top: 0, left: 10, right: 10,bottom: 10),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 0, left: 10, right: 10,bottom: 0),
                      child: Text(
                        "${response.data?.bulletin![index].articleTitle}",style: const TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 0, left: 10, right: 10,bottom: 0),
                      child: Text(
                          "${response.data?.bulletin![index].articleDescription}",
                          style: TextStyle(
                            color: Colors.grey.shade700,fontSize: 14,),maxLines: 3,overflow: TextOverflow.ellipsis,),
                    ),
                    GestureDetector(
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: 15, left: 10, right: 10,bottom: 0),
                          child: const Text("Read More",style: TextStyle(color: Colors.cyan,fontSize: 13,decoration: TextDecoration.underline),)),
                      onTap: () {
                        //Todo
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget hidocTrendingBulletinWidget(){
    return Visibility(
      visible: true,
      child: Container(
        margin: const EdgeInsets.only(left: 15,right: 15),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          color: Colors.cyan.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 15, left: 15, right: 5),
                child: const Text("Trending Hidoc Bulletin",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                response.data?.trandingBulletin?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 15, right: 5,bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${response.data?.trandingBulletin![index].articleTitle}",style: const TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Text(
                          "${response.data?.trandingBulletin![index].articleDescription}",
                          style: TextStyle(color:Colors.grey.shade700),maxLines: 3,overflow: TextOverflow.ellipsis,),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 0, left: 0, right: 5,bottom: 0),
                              child: const Text("Read More",style: TextStyle(color: Colors.cyan,fontSize: 13,decoration: TextDecoration.underline),)),
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
  Widget latestArticleWidget(){
    return  Container(
      margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(width: 1)
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: 15, left: 15, right: 5),
            child: const Text("Latest Articles",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),

          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 5, right: 5,bottom: 15),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: response.data?.exploreArticle?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20),
                          child: const Divider(thickness: 1,color: Colors.grey,)),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20),
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

  Widget trendingArticleWidget(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(width: 1)
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: 15, left: 15, right: 5),
            child: const Text("Trending Articles",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
          ),

          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 5, right: 5,bottom: 15),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: response.data?.trandingArticle?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20,bottom: 0),
                        color: Colors.grey,
                        height: 1,
                        // child: const Divider(thickness: 1,color: Colors.grey,)
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20),
                        child: Image.network("${response.data?.trandingArticle![index].articleImg}",fit:BoxFit.cover),
                      ),
                      Container(
                        padding:const EdgeInsets.only(
                            top: 20, bottom: 10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20),
                        child: Text(
                          "${response.data?.trandingArticle![index].articleTitle}",style: const TextStyle(
                        ),
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

  Widget exploreMoreArticleWidget(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(width: 1)
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: 15, left: 15, right: 5),
            child: const Text("Explore More Articles",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),

          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 5, right: 5,bottom: 15),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: response.data?.exploreArticle?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20),
                          child: const Divider(thickness: 1,color: Colors.grey,)),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20),
                        child: Text(
                          "${response.data?.exploreArticle![index].articleTitle}",),
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

  Widget newsWidget(){
    return Container(
      margin: const EdgeInsets.only(top: 20,bottom: 20),
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            margin: const EdgeInsets.only(left: 20,right: 20),
            // decoration: BoxDecoration(
            //     border: Border.all(width: 1)
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20,top: 20),
                  child: const Text("News",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),

                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 15, left: 5, right: 5,bottom: 50),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: response.data?.news?.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20,bottom: 10),
                              child: Text(
                                "${response.data?.news![index].title}",),
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
            margin: const EdgeInsets.only(left: 20,right: 20,),
            child: Image.asset("assets/images/makeup1.jpg",fit:BoxFit.fill,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/4,),
            // :const Icon(Icons.my_library_books_outlined,size: 100,),
          ),
          const SizedBox(height: 40,),

        ],
      ),
    );
  }
  Widget quizzesWidget(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
          border: Border.all(width: 1,color: Colors.grey)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 0.5,color: Colors.grey),
                      color: Colors.cyan.shade50

                  ),
                  padding: const EdgeInsets.all(2.0),

                  child: const Icon(Icons.wine_bar_outlined,color: Colors.cyan,),

                ),
              ),
              const Text("Quizzes :",style: TextStyle(fontWeight: FontWeight.bold,),),
              const Text("Participate & Win Existing Prizes")
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 0),
              child: const Divider(thickness: 1,)
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 0.5,color: Colors.grey),
                      color: Colors.cyan.shade50

                  ),
                  padding: const EdgeInsets.all(2.0),
                  child: const Icon(Icons.wine_bar_outlined,color: Colors.cyan,),

                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/5,
                child: const Flexible(child: Text("Medical Calculators :",style: TextStyle(fontWeight: FontWeight.bold,),)),
              ),
              const Flexible(child: Text("Get Access to 800+ Evidenced Based Calculators"))
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 0),
              child: const Divider(thickness: 1,)
          ),
        ],
      ),
    );
  }



  callHomePageApi() {
    _bloc.add(GetHomePageDetails(sId: "500", uuId: "", userId: "423914"));
  }
}
