# dl-apps-fuzzing

This project is intended to fuzz java deep learning applications to test the effectiveness of transforming datasets on increasing branch coverage. It utilizes a modified [JQF](https://github.com/rohanpadhye/JQF) framework to feed image data to the java applications. At the moment, there is basically only a pseudo-fuzzer that directly feeds the images dataset to the test applications, without performing any mutation on-the-fly. JQF is used mainly to record branch coverage data. Different kinds of transformations are performed off-line on the origional dataset before they are feeded to the application to observe whether there is an increase on the branch coverage for the testings. 

**This repo is a reorganization with necessary bug fixes of the following three repos:**

1. [dl-fuzzing](https://github.com/usama54321/dl-fuzzing): this is the test driver.

2. [dl-java-apps](https://github.com/usama54321/dl-java-apps): this repo consists of three borrowed java deep learning applications. **At the moment only the first two is functioning**, the third one has a bug:
    1. [FaceDetection](https://github.com/tzolov/mtcnn-java)
    2. [SmartCropper](https://github.com/pqpo/SmartCropper)
    3. [PoseEstimation](https://fritz.mycloudrepo.io/public/repositories/android/ai/fritz/)

3. [jqf](https://github.com/usama54321/jqf): this is a modified jqf that feeds image data directly to the test applications.

## How to build:

**Prerequisites**:
1. Java >= 9. **Tested with openjdk 11.0.13**
2. **Maven**

Make sure the **prerequisites** are met, then use the following command to clone and build:
```
git clone https://github.com/ShuoHe97/dl-apps-fuzzing.git
cd dl-apps-fuzzing
bash build.sh
```
Tested on Ubuntu 18.04.




## Example Run
The logic is that we first run testing to get the corpus of all test inputs that lead to coverage increase, as well as recording the overall branch coverage.

After that, we run reproduction test on the saved corpus to get post-inference coverage.

The test scripts that run the tests are helpers/fuzz.sh and helpers/repro.sh. Detail explanations are in both files. 

We have some sample data in ./data directory. We can first test the FaceDetection app to see how much branch coverage we can get from these data:
```
bash helpers/fuzz.sh tf testFaceDetection ./data ./results $(pwd)/temp/instrumentation edu.ucla.cs.FaceTest
```
Results will be stored in the ./results directory. ./results/corpus contains the recorded input that leads to a coverage increase. They are used to reproduce the test to obtain post-inference coverage.



After we run the first testing script and obtained ./results/corpus, we can re-run the test to also get post-inference coverage using this command:
```
bash helpers/repro.sh ./results/corpus tf ./results/repro testFaceDetection edu.ucla.cs.FaceTest
```
This will produce results containing post-inference coverage info, stored in ./results/repro



## Author

[Usama Hameed](https://github.com/usama54321), [Shuo He](https://github.com/ShuoHe97)
