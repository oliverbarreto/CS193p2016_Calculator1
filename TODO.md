//
//  TODO
//  Calculator
//
//  Created by David Oliver Barreto Rodríguez on 1/5/16.
//  Copyright © 2016 Oliver Barreto. All rights reserved.
//

# Done

### Required Tasks
1. Get the Calculator working as demonstrated in lectures 1 and 2.
2. Your calculator already works with floating point numbers (e.g. if you touch 3 ÷ 4 =, it will properly show 0.75), however, there is no way for the user to enter a floating point number directly. Fix this by allowing legal floating point numbers to be entered (e.g. “192.168.0.1” is not a legal floating point number!). You will have to add a new “.” button to your calculator. Don’t worry too much about precision or significant digits in this assignment (including in the examples below).
3. Add some more operations buttons to your calculator such that it has at least a dozen operations total (it can have even more if you like). You can choose whatever operations appeal to you. The buttons must arrange themselves nicely in portrait and landscape modes on all iPhones.
4. Use color to make your UI look nice. At the very least, your operations buttons must be a different color than your keypad buttons, but otherwise you can use color in whatever way you think looks nice.

5. Add a String property to your CalculatorBrain called description which returns a description of the sequence of operands and operations that led to the value returned by result. “=“ should never appear in this description, nor should “...”.

6. Add a Bool property to your CalculatorBrain called isPartialResult which returns whether there is a binary operation pending (if so, return true, if not, false).




# TODO

### Required Tasks
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
8. Add a C button that clears everything (your display, the new UILabel you added above, etc.). The Calculator should be in the same state as it is at application startup after you touch this new button.


###Extra Credit
We try to make Extra Credit be opportunities to expand on what you’ve learned this week. Attempting at least some of these each week is highly recommended to get the most out of this course.

1. Implement a “backspace” button for the user to touch if they hit the wrong digit button. This is not intended to be “undo,” so if the user hits the wrong operation button, he or she is out of luck! It is up to you to decide how to handle the case where the user backspaces away the entire number they are in the middle of typing, but having the display go completely blank is probably not very user-friendly. You will find the Strings and Characters section of the Swift Reference Guide to be very helpful here.
2. Change the computed instance variable displayValue to be an Optional Double rather than a Double. Its value should be nil if the contents of display.text cannot be interpreted as a Double. Setting its value to nil should clear the display out. You’ll have to modify the code that uses displayValue accordingly.
3. Figure out from the documentation how to use the NSNumberFormatter class to format your display so that it only shows 6 digits after the decimal point (instead of showing all digits that can be represented in a Double). This will eliminate the need for Autoshrink in your display. While you’re at it, make it so that numbers that are integers don’t have an unnecessary “.0” attached to them (e.g. show “4” rather than “4.0” as the result of the square root of sixteen). You can do all this for your description in the CalculatorBrain as well.
4. Make one of your operation buttons be “generate a random number between 0 and 1”. This operation button is not a constant (since it changes each time you invoke it). Nor is it a unary operation (since it does not operate on anything).