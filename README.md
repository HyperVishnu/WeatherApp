# WeatherApp
https://github.com/HyperVishnu/WeatherApp.git

1. Open terminal -> Go to App folder(WeatherApp) Pod install
2. Used Swinject framework for dependency injection
   See from SceneDelegate.swift, Used container to register/resolve of protocols. If you see that the dependencies of one object is provided by other objects. This will help us to use objects with loosely coupled.
3. Used Xib's for UI
4. Created seperate network layer, so it can be used with more than one api with small modifications.
5. Created Viewmodel. So, it will be more helpful for understanding and also we can write test cases in easy way.
6. If you see, I have written only UI part in ViewControllers and all the functionalities, coditions are written in ViewModel. So, these methods can be called any where by passing required data.



https://user-images.githubusercontent.com/101444092/158061144-0ff2f7ba-d494-43c3-9099-f9080295ac76.mov

