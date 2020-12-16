#What I Did

Created a visual representation of the rule 30 "Pyramid"
    -Added a bit of flair, like functions to start, stop reset, and change the colors of the cells

#Archetechure

I went with an interpretation of MVVM.

I went through great pains to avoid the view model dealing directly with a collection view to make testing easier.  I personally prefer to put as few views in the viewModel as possible, but others may have a different opinion about that.  Though, in this case I may have sacrificed a little bit of readability for it in the cellForItemAt function.

I added what I call a "DrawerView" which is the control for the "rule 30 pyramid" and shares a View Model with the Rule30ViewController.
    
This was another area I may have sacrificed a bit of simplicity/readability for flair. I didnt want to make the controlls in the same view controller as the pyramid... that would have been boring, and uninteresting. Not sure if it was worth the sacrifice though, I'll leave that judgment up to you.

Thinking back, I didn't implement any examples of protocol oriented programming or dependency inversion.  Usually service calls are what makes me think of using those methods, and there werent any service calls in this project...My bad.

The Pyramid only grows to a certain size because the collection view gets too big and slows down the app.




#Frameworks

I went with combine instead of using delegates and callbacks. I find it can be cleaner and more streamlined than having delegates all over the place.

I used UIKit instead of SwiftUI, I dont think SwiftUI has reached the adoption rate necessary to warrant using it in coding exercises yet.







