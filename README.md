#CS193P - Developing iOS 9 Apps with Swift 2.2

## Calculator 
This is Programming Assignment #1
Donwload the document on [iTunesU]( http://apple.co/1OapOAg)


## Programming Assigment 1: Calculator
<img src="https://github.com/oliverbarreto/CS193p2016_Calculator1/blob/master/Calculator1.png" width= "30%">
<img src="https://github.com/oliverbarreto/CS193p2016_Calculator1/blob/master/Calculator2.png" width="50%">

### License
Stanford University code on iTunes and Its blog follows the following license. This work by Stanford University is licensed under a [Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License](http://creativecommons.org/licenses/by-nc-sa/3.0/us/). Based on a work at [cs193p.stanford.edu](http://cs193p.stanford.edu/)

My code is also licensed under the [Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License](http://creativecommons.org/licenses/by-nc-sa/3.0/us/)
<!---
![Calculator](https://github.com/oliverbarreto/CS193p2016_Calculator1/blob/master/Calculator1.png "Logo Title Text 1")
-->


### Required Tasks
1. Get the Calculator working as demonstrated in lectures 1 and 2.
2. Your calculator already works with floating point numbers (e.g. if you touch 3 ÷ 4 =, it will properly show 0.75), however, there is no way for the user to enter a floating point number directly. Fix this by allowing legal floating point numbers to be entered (e.g. “192.168.0.1” is not a legal floating point number!). You will have to add a new “.” button to your calculator. Don’t worry too much about precision or significant digits in this assignment (including in the examples below).
3. Add some more operations buttons to your calculator such that it has at least a dozen operations total (it can have even more if you like). You can choose whatever operations appeal to you. The buttons must arrange themselves nicely in portrait and landscape modes on all iPhones.
4. Use color to make your UI look nice. At the very least, your operations buttons must be a different color than your keypad buttons, but otherwise you can use color in whatever way you think looks nice.
5. Add a String property to your CalculatorBrain called description which returns a description of the sequence of operands and operations that led to the value returned by result. “=“ should never appear in this description, nor should “...”.
6. Add a Bool property to your CalculatorBrain called isPartialResult which returns whether there is a binary operation pending (if so, return true, if not, false).
7. Use the two properties above to implement a UILabel in your UI which shows the sequence of operands and operations that led to what is showing in the display. If isPartialResult, put . . . on the end of the UILabel, else put =. If the userIsInTheMiddleOfTypingANumber, you can leave the UILabel showing whatever was there before the user started typing the number. Examples:
...a. touching 7 + would show “7 + ...” (with 7 still in the display)
...b. 7 + 9 would show “7 + ...” (9 in the display)
...c. 7 + 9 = would show “7 + 9 =” (16 in the display)
...d. 7 + 9 = √ would show “√(7 + 9) =” (4 in the display)
...e. 7 + 9 √ would show “7 + √(9) ...” (3 in the display)
...f. 7 + 9 √ = would show “7 + √(9) =“ (10 in the display)
...g. 7 + 9 = + 6 + 3 = would show “7 + 9 + 6 + 3 =” (25 in the display)
...h. 7 + 9 = √ 6 + 3 = would show “6 + 3 =” (9 in the display)
...i. 5 + 6 = 7 3 would show “5 + 6 =” (73 in the display)
...j. 7 + = would show “7 + 7 =” (14 in the display)
...k. 4 × π = would show “4 × π =“ (12.5663706143592 in the display)
...l. 4 + 5 × 3 = would show “4 + 5 × 3 =” (27 in the display)
...m. 4 + 5 × 3 = could also show “(4 + 5) × 3 =” if you prefer (27 in the display)
8. Add a C button that clears everything (your display, the new UILabel you added above, etc.). The Calculator should be in the same state as it is at application startup after you touch this new button.