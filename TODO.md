//  TODO
//  Calculator
//
//  Created by David Oliver Barreto Rodríguez on 1/5/16.
//  Copyright © 2016 Oliver Barreto. All rights reserved.
//

# Working
### Extra Tasks

# Done

### Required Tasks
1. Get the Calculator working as demonstrated in lectures 1 and 2.
2. Your calculator already works with floating point numbers (e.g. if you touch 3 ÷ 4 =, it will properly show 0.75), however, there is no way for the user to enter a floating point number directly. Fix this by allowing legal floating point numbers to be entered (e.g. “192.168.0.1” is not a legal floating point number!). You will have to add a new “.” button to your calculator. Don’t worry too much about precision or significant digits in this assignment (including in the examples below).

	**Solution:**  this was easy... you only need to track when the user is in the middle of typing something and checking whether you have previously entered a "." before... and check at the first to handle the case that you first enter "." which should print "0." in the display
3. Add some more operations buttons to your calculator such that it has at least a dozen operations total (it can have even more if you like). You can choose whatever operations appeal to you. The buttons must arrange themselves nicely in portrait and landscape modes on all iPhones.

	**Solution:** this was more trickier than I originally though it would be... the thing is that stackviews need to handle the views it manages with its own magic methods... If you try to show/hide views inside stackviews directly using SizeClasses constrains... you'll run into trouble of frame & constrains misplacements. [Check this link that i posted on the Google Forum](https://groups.google.com/forum/#!topic/cs193p_2016/bb5RAPNwdoo) or [check this post in Use Your Loaf Blog](http://useyourloaf.com/blog/using-size-classes-to-hide-stack-view-contents/). The solution is to handle hide/show using device orientation changes on UITraitCollection...
4. Use color to make your UI look nice. At the very least, your operations buttons must be a different color than your keypad buttons, but otherwise you can use color in whatever way you think looks nice.
	**Solution:** this was (still is) the most annoying one... having the outter stackview properly align with the VC view.. still annoyies me...

	**Question/TODO:**
	- ...is there any way that i can assign a minimum proportional amount of space for the display and the touchpad views??? let's say Display 1/3 of the view... also
	- ...is there any way that i can stick the content of UILabel used for the display at the very bottom of the label instead of centered on the display... so i can have a big text font with smaller amount of space used for the display???

5. Add a String property to your CalculatorBrain called description which returns a description of the sequence of operands and operations that led to the value returned by result. “=“ should never appear in this description, nor should “...”.
6. Add a Bool property to your CalculatorBrain called isPartialResult which returns whether there is a binary operation pending (if so, return true, if not, false).
7. Use the two properties above to implement a UILabel in your UI which shows the sequence of operands and operations that led to what is showing in the display. If isPartialResult, put . . . on the end of the UILabel, else put =. If the userIsInTheMiddleOfTypingANumber, you can leave the UILabel showing whatever was there before the user started typing the number. Examples:
	* touching 7 + would show “7 + ...” (with 7 still in the display)
	* 7 + 9 would show “7 + ...” (9 in the display)
	* 7 + 9 = would show “7 + 9 =” (16 in the display)
	* + 9 = √ would show “√(7 + 9) =” (4 in the display)
	* 7 + 9 √ would show “7 + √(9) ...” (3 in the display)
	* 7 + 9 √ = would show “7 + √(9) =“ (10 in the display)
	* 7 + 9 = + 6 + 3 = would show “7 + 9 + 6 + 3 =” (25 in the display)
	* 7 + 9 = √ 6 + 3 = would show “6 + 3 =” (9 in the display)
	* 5 + 6 = 7 3 would show “5 + 6 =” (73 in the display)
	* 7 + = would show “7 + 7 =” (14 in the display)
	* 4 × π = would show “4 × π =“ (12.5663706143592 in the display)
	* 4 + 5 × 3 = would show “4 + 5 × 3 =” (27 in the display)
	* 4 + 5 × 3 = could also show “(4 + 5) × 3 =” if you prefer (27 in the display)

	**Solution:** this was not easy at all.. after i found that i should follow the same approach using an accumulator for the description... and extending the pending struct to hold a copy of both, the math part... and the description part

	Another time consuming part was getting all the operations printable descriptions "in good shape"...

	Another annoying thing was the fact that in e.g. "x²" xcode was not returning this as text from the button... it was sending me a long string with text description of the unicode.. i think... so the ops were not executing... until i found out !!!

	**Question/TODO:**
	- I found on the blog [Calculator of the cs193p lecture Spring 2016](http://cs193p.m2m.at/tag/calculator+2016/) and the [Github code](https://github.com/m2mtech/calculator-2016) and approach that uses operation precedence to add extra "()" for e.g. 4 + 6 x 7... (4 + 6) x 7 .. **i would give it a try**

	**Cool Part:** It was also my first time using Unit tests in iOS (simple test... but still cool) !!!

8. Add a C button that clears everything (your display, the new UILabel you added above, etc.). The Calculator should be in the same state as it is at application startup after you touch this new button.

	**Solution:** i thought that this would be a piece of cake if i created a public var in CalculatorBrain that would act a Reset button of the model... it was easier to simply throw the calculator away from the VC and instantiate a new one...

### Extra Tasks
We try to make Extra Credit be opportunities to expand on what you’ve learned this week. Attempting at least some of these each week is highly recommended to get the most out of this course.
1. Implement a “backspace” button for the user to touch if they hit the wrong digit button. This is not intended to be “undo,” so if the user hits the wrong operation button, he or she is out of luck! It is up to you to decide how to handle the case where the user backspaces away the entire number they are in the middle of typing, but having the display go completely blank is probably not very user-friendly. You will find the Strings and Characters section of the Swift Reference Guide to be very helpful here.

	**Solution:** it is simple... however a little bit trickier than expected, because of *Swift Strings* when handling the case of "0." ... **To Be Remembered:** use  String.Characters.dropLast/First/Last/etc... to get characters from strings in swift... string and ranges are also weird

2. Change the computed instance variable displayValue to be an Optional Double rather than a Double. Its value should be nil if the contents of display.text cannot be interpreted as a Double. Setting its value to nil should clear the display out. You’ll have to modify the code that uses displayValue accordingly.
	**Solution:** not so difficult.. just follow the path...

3. Figure out from the documentation how to use the NSNumberFormatter class to format your display so that it only shows 6 digits after the decimal point (instead of showing all digits that can be represented in a Double). This will eliminate the need for Autoshrink in your display. While you’re at it, make it so that numbers that are integers don’t have an unnecessary “.0” attached to them (e.g. show “4” rather than “4.0” as the result of the square root of sixteen). You can do all this for your description in the CalculatorBrain as well.

	**Solution:** this was not as easy as i thought it would be in principle...
	- First I had to create a var in the VC that keeps a hold on a NSNumberFormatter variable to work with the same conditions...  and use it every time we set the displayValue
	- I had to pass to the Model the current number of decimal digits as well... (and sync with rotation changes)
	- I had to set in storyboards... the minimum font of display labels

	**Extra:** the number of decimal digits varies according to device orientation... in landscape (with bigger horizontal space) it uses 12 digits, while in portrait it uses only 6
4. Make one of your operation buttons be “generate a random number between 0 and 1”. This operation button is not a constant (since it changes each time you invoke it). Nor is it a unary operation (since it does not operate on anything).

	**Solution:** this is more like an app architecting task... i initially tried to create rdn function as a constant, but evaluating it every time it was called... then i decided to create a new type of operation that takes no arguments but returns a double... then... it was piece of cake!!!


# TODO

### Required Tasks
All Done !!!

###Extra Credit
All  Done !!!
