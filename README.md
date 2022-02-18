# so71155976

Demonstration of using Trash to find class reference relationships.
https://stackoverflow.com/questions/71155976/

## Instructions

Run "bash build.sh"

You should see the output "|A B|A C|A D", meaning class "A" contains a reference to class "B", etc.

The problem you see with this example is the lack of information to decide what a reference
"B" refers to. There is no symbol table implementation, so the meaning of "B" depends.
