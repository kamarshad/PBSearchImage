# PBSearchImage
This is a self learning iOS application developed using Swift programming language. It is based on the MVVM design architecture. It provides the interface to search image from Pixabay (https://pixabay.com/). 

### Features ###
* Search images from pixabay.
* Lists all the searched images and user can scroll the images.
* Load more image record, as soon user reaches to the bottom of list,  images (against the same keyword) will be fetched silently and get loaded into the existing list.
* Show Recently search keyword once user tap on search bar If exist. 
* Show Image in full screen mode along with the left/right swipe. 
* Auto downloading of images using Kingfisher library (https://github.com/onevcat/Kingfisher)
* Upload the crash reports to firebase analytics

### Tool and language ###
* Xcode: 11.x
* Programming language: Swift 5.0
* Device supported: iPhone and iPad 
* Orientation:  Portrait
* Minimum iOS deployment target: 11.0 and above

### ThirdParty Libraries used ###
* Kingfisher to download the images
* Nimble and Quick to write the Unit test case 


### Recorded Video ###

<figure class="video_container">
  <iframe src="https://www.youtube.com/embed/JKq_iIQNZT0" frameborder="0" allowfullscreen="true"> 
  </iframe>
</figure>

### Unit Test cases and code coverage ###
<img width="1281" alt="Screen Shot 2020-09-25 at 11 07 28 PM" src="https://user-images.githubusercontent.com/1333329/94298548-f554de80-ff83-11ea-82c7-f7e03eac9e44.png">

### Design architecture/patterns followed ###
* MVVM
* SOLID
* DRY

### How to use it ###
* Generate the API key at PIXBAY (https://pixabay.com/api/docs/). In order to generate the api key, you will have to signup.
* Once API key is generated place it inside APIConstant, as mentioned below

```swift
APIConstant {
    static let apiKey = "" // Your PIXBAY API key goes here....
}
```
* If you don't provide the API key, Unit test cases will get failed
* Either clone or download the source code, once it is downloaded. To open project, double click the `PBSearchImage.xcworkspace`

### Programming Approach ###
* I have followed the protocol orieneted programming (POP) and object orieneted programming(OOP) approaches.

### Code understanding ###

* **Networking**: This folder conatins the code related to the network layer which handles the client-server communication.
* **Features/SearchImage**: This folder conatins code related to search image, list them, show recent search and show detail of any tapped list item etc.
