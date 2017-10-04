# Expressions

Unfortunately, expressions are similar to javascript but not quite the same.
So for converting and evaluating the code, I use Esprima and Escodegen.
A subset of expressions is supported.

## Return value in the last line of code.
The returning value must be on the last line. You can't return the value in the middle code.
To workaround this, you can create a var, set the value, and return it in the final line.

## Expression controls
All expression controls are supported. You should have no issues linking any of the supported properties to an expression control.

## Native functions
functions like linear, velocityAtTime and wiggle are not supported.
Probably some will in the near future.
You can set your own function inside the code.

## Use javascript
If you set the string 'use javascript' as the first line of your expression, the plugin won't parse your code and you can get a significant performance increase.
For your code to be javascript compliant, please declare all vars and use operators limited to what javascript supports.
For example don't use an addition operator to sum two arrays.