# PBSearchImage
This is an iOS application developed using Swift programming language. It is based on the MVVM design architecture and followed the SOLID and DRY principle as much as possible. It provides the interface to search image from Pixabay (https://pixabay.com/) and view in full screen. 

### Features ###
* Search images from pixabay.
* Lists all the searched images and user can scroll the images.
* Load more image records. As soon user reaches to the bottom of table view,  images (against the same keyword) will be fetched from pixabay silently and get loaded into the existing list.
* Show recently search keywords. Once user taps on search bar all (As of now recent search limit is 10, which you can change in `RecentSearchDatabaseAdapter` ) previous searched keywords will be displayed. 
* Show Image in full screen mode along with the left/right swipe. 
* Auto downloading of images using Kingfisher library (https://github.com/onevcat/Kingfisher)
* Upload the crash reports to firebase crashlytics

### Tool and Language ###
* Xcode: 11.x
* Programming language: Swift 5.0
* Device supported: iPhone and iPad 
* Orientation:  Portrait
* Minimum iOS deployment target: 11.0 and above
* App run well and tested on iPhone8 plus and iOS 13.0

### ThirdParty Libraries used ###
* Kingfisher to download the images
* Nimble and Quick to write the Unit test case 
* Firebase crashlytics to report the crash logs

### Recorded Video and Snapshot ###

To take a over view of application, go through the Youtube video link https://www.youtube.com/embed/JKq_iIQNZT0

![1](https://user-images.githubusercontent.com/1333329/94337217-781e7d80-0006-11eb-8d09-d02a556b337a.png) ![2](https://user-images.githubusercontent.com/1333329/94337216-7785e700-0006-11eb-8c36-2f5a7bbfeffd.png)
![3](https://user-images.githubusercontent.com/1333329/94337215-76ed5080-0006-11eb-8ca9-36aaca5306ae.png)
![4](https://user-images.githubusercontent.com/1333329/94337213-7654ba00-0006-11eb-92d5-0e9ca92f8227.png)
![5](https://user-images.githubusercontent.com/1333329/94337212-748af680-0006-11eb-83fd-6c7dfd3d6b08.png)
![6](https://user-images.githubusercontent.com/1333329/94337211-73f26000-0006-11eb-9831-9737b867c245.png)
![7](https://user-images.githubusercontent.com/1333329/94337209-7359c980-0006-11eb-85e3-ffa0f4d61a1c.png)
![8](https://user-images.githubusercontent.com/1333329/94337207-6fc64280-0006-11eb-9b5a-bef8d0feb589.png)


### Unit Test cases and code coverage ###
I've written unit test cases to ensure the code shoudl work fine. If any unintended code changes are made those changes could be observed without easily. It also ensures written code is working as expected and documented if new developer joines the project can go through the UT's and understand it as much as possible.

Considering the timeline, I've mainly wrote the unit test cases for the Source files placed inside the **Features** folder. I've tried to maintian the 100% test code coverage. Kindly have a look at below screen shot.

<img width="1281" alt="Screen Shot 2020-09-25 at 11 07 28 PM" src="https://user-images.githubusercontent.com/1333329/94298548-f554de80-ff83-11ea-82c7-f7e03eac9e44.png">

### Design architecture and principle followed ###
* MVVM
* SOLID
* DRY

### How to use it ###
* Generate the **API key** at PIXBAY (https://pixabay.com/api/docs/). In order to generate the api key, you will have to signup.
* Once API key is generated place it inside **APIConstant**, as mentioned below

```swift
APIConstants {
    static let apiKey = "" // Your PIXBAY API key goes here....
}
```
* If you don't provide the **API key**, You will not able to search the images. An error alert is displayed if try to run without providing the **API key**. Unit test cases will also failed in absence of **API key**.
* Either clone or download the source code, once it is downloaded/cloned. To open project, double click the `PBSearchImage.xcworkspace`

### Programming Approach ###
* I have followed the protocol orieneted programming (POP) and object orieneted programming(OOP) approaches.

### Code understanding ###

* **Database** -  This folder contains the source files related to the data persistant operations, as of considering the scope I've used the UserDefaults as persistant storage to save and fetch the recent searches. But it can also replace easily with any other data persistant store like realm, sqlite or core data.
   - **DataBasePersistable** - This is protocol should be confirmed by the data persistant store. As I said if we require to change the persistant store, that new store confirm to this protocol and while creating the  `RecentSearchViewModel` object needs to pass that persistant store, rest nothing much will be changed.
   -**DatabaseManager** - This source file is responsible for saving and fetching the data from persistant storage, as of now, I've used the userdefaults.
  
 * **Networking**: This folder conatins the code related to the network layer which handles the client-server communication. Few most important source file are explained below.
   - **PBServerConfig** - This is server configuration plist server base url is always read from this file. As of now considering the scope of this demo application, I've kept only one server configuration file but we should keep configuration according to environments (like **DEV, SIT, UAT, PROD** etc..)
   - **NetworkModel** - This source file takes care the responsbility of forming the base URL. It reads the server configuration and prepare the base URL.
   - **NetworkClient** - This is one of the crucial source files, it communicates with the server, handle API request and route the response parsing work to the concerned parser. As you can see, I have followed the SOLID principle , **High level module should not depend on low level module both should depend on abstractions**.
    **JSONResponseParser** - This source file is responsbile for handling the received response. As of now Pixabay image search API returns the response in JSON format but incase due to business rule change if it starts returning the response in XML that can also be hanlded easily withoyut doing changes at too many places. We just have to have another parser. It should confirm the protocol `ResponseDataParsable` and define the logic accordingly. And while creating the instance of `NetworkClient`, we just have to mention the corresponding parser.

 * **Features** -  This is main folder contains the source code for search image from Pixabay, show recent search, and detail full screen imageview with left/rigjt swipe to next/previous images. Few most important source file are explained below.
   - **SearchImageViewController** - This source file is responsbile for providing the user interface to user to search the images from pixabay. 
   - **DetailViewController** - This source file is responsbile for showing the full screen image view. It also handles swipe, once user swipe left then next image(if available) will be displayed and if user swipes right then the previous(if exist) image is displayed.
   - **RecentSearchViewController** - This source file is responsbile for showing the recently search keywords(only if there were images received otherwise it does not show that search query.
   - **ImageListViewModel** -  This source file responsible for channelizing and fulfilling the data requirement needed for/from `SearchImageViewController`. It further communicates with the `SearchImageNetworkAdapter` to trigger the network API call.
   - **RecentSearchViewModel** -  This source file responsible for channelizing and fulfilling the data requirement needed for/from `RecentSearchViewController` and `SearchImageViewController`. It basically communicates with the `RecentSearchDatabaseAdapter` that further communicates with the DB manager. You can see while creating the instance of  the `RecentSearchViewModel` and `ImageListViewModel`, we've followed the **Dependency Inversion Principle**.
   - **ImageListModel** -  This source file having the `ImageListModel` and `ImageModel` codable model which confirm the `ImageListable` and `ImageDisplayable` protocols respectively. Once the response is received it mapped with the `ImageListModel` model.
    - **PBAPIEndpointConfig** -  This plist file contains the api endpoints configurations like api endpoint URI and method type (**GET, POST, PUT, DELETE etc**.).
    - **PBNetworkConstants** -  This source file having the endpoints constants these constants represents the api endpoints.
    - **DynamicType** - This source file is responsbile for propogating the model changes back to observer.
