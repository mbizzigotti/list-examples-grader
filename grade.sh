FAIL_MSG="FAIL"
SUCCESS_MSG="SUCCESS"

CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

FILE=$(find -name ListExamples.java)

if [[ -e "$FILE" ]];
then
    echo "Found $FILE"
else
    echo "did not find ListExamples.java"
    echo "$FAIL_MSG"
    exit 1
fi

cp $FILE grading-area/
cp "TestListExamples.java" grading-area/
cp -r lib/ grading-area/

# Then, add here code to compile and run, and do any post-processing of the
# tests

cd grading-area/
#javac -cp "$CPATH" *.java &> compile-output.txt

if javac -cp "$CPATH" *.java &> compile-output.txt;
then
    echo "Compilation Succedded"
else
    echo "Compilation Failed"
    echo "$FAIL_MSG"
    exit 1
fi

#java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples > output.txt

if java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples > output.txt;
then
    echo "$SUCCESS_MSG"
else
    cat output.txt
    echo "$FAIL_MSG"
fi
