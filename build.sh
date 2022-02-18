#

# verify build environment.

dotnet --version 2>&1 > /dev/null
status=$?
if [[ $status != 0 ]]
then
    echo dotnet required. See https://dotnet.microsoft.com/en-us/
    exit 1
fi

git --version 2>&1 > /dev/null
status=$?
if [[ $status != 0 ]]
then
    echo git required. See https://git-scm.com/
    exit 1
fi

#

if [[ -d java ]]
then
    rm -rf java/
fi

echo Cloning grammars-v4...
git clone https://github.com/antlr/grammars-v4.git
mv grammars-v4/java/java .
echo Cleaning up...
rm -rf grammars-v4

echo Cloning Trash tools...
git clone https://github.com/kaby76/trash-install.git
cd trash-install
dotnet tool restore
trparse --version
cd ..
echo Cleaning up...
rm -rf trash-install

echo Build parser...
cd java
trgen
cd Generated
dotnet build

echo Demonstrate class reference example...
cat << END > ex.java
class A {
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
END

# echo "Setting MSYS2_ARG_CONV_EXCL so that Trash XPaths do not get mutulated."
export MSYS2_ARG_CONV_EXCL="*"
trparse ex.java | trxgrep "//classDeclaration/string-join(./classBody/classBodyDeclaration/memberDeclaration/fieldDeclaration/typeType/classOrInterfaceType/identifier/IDENTIFIER/text(), concat('|', ./identifier/IDENTIFIER/text(), ' '))"
