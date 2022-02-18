# so71155976

Demonstration of using Trash to find class reference relationships.
https://stackoverflow.com/questions/71155976/

## Instructions

Run "bash build.sh"

You should see the output "|A B|A C|A D", meaning class "A" contains a reference to class "B", etc.

The problem here parses this code and runs an xpath to find these relationships.

Java code example:

	import org.fake.B;
	class A {
	    class B {}
	    private B myReferenceToB;
	    private C myReferenceToC;
	    private D myReferenceToD;
	    A(){
		this.myReferenceToB = new B();
	    }
	    public method(){
		B refrenceFromMethod = new B();
	    }
	    private method2(){
		B refrenceFromPrivateMethod = new B();
	    }
	}
	class B {}

xpath expression for "using" relationship within classBody:

	//classDeclaration/string-join(./classBody/classBodyDeclaration/memberDeclaration/fieldDeclaration/typeType/classOrInterfaceType/identifier/IDENTIFIER/text(), concat('|', ./identifier/IDENTIFIER/text(), ' '))

The problem you see with this example is the lack of information to decide what a reference
"B" refers to. There is no symbol table implementation, so the meaning of "B" depends on the
scope and qualifications. A specification for the construction of the symbol table can be made,
but normally the relationship computed here would not be precomputed. This is why you also need
a query language on top of the computed semantics.
