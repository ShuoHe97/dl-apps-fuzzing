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
cd dl-appps-fuzzing
bash build.sh
```
Tested on Ubuntu 18.04.


## How to run tests:
The test driver is inside the dl-fuzzing directory. You can use any image data. For now lets use some data [here](https://github.com/ShuoHe97/data):
```
cd dl-fuzzing
git clone https://github.com/ShuoHe97/data.git
unzip data/vggface2/ORIG.zip -d data/vggface2/ORIG
```

To run the test and obtain the overall branch coverage, use this command:
```
bash helpers/fuzz.sh \$engine \$method \$in \$out \$cacheDir \$testclass
```
Where 
**engine**: type "tf" for our customized guidance.

**method** is the test method we want to run. 

**in** is the directory that consists of test input images.

**out** is the directory that we want the results to be stored

**cashDir** is the directory to store temp files

**testclass** is the class of testcase


### Example 
now that we have some images in data/vggface2/ORIG. We can first test the FaceDetection app to see how much branch coverage we can get from these data:
```
bash helpers/fuzz.sh tf testFaceDetection ./data/vggface2/ORIG ./face_test_results $(pwd)/results/instrumentation edu.ucla.cs.FaceTest
```
Results will be stored in the ./face_test_results directory. ./face_test_results/corpus contains the recorded input that leads to a coverage increase. They are used to reproduce the test to obtain post-inference coverage.

To get the post-inference test coverage, use the following command:
```
bash helpers/repro.sh \$input \$engine \$out \$method
```
Where
**input** is ./face_test_results/corpus
**engine**: type "tf" for our customized guidance.
**out** is the output directory
**method** is the test method we want to re-run. 

**For example**, after we run the first testing script and obtained ./face_test_results/corpus, we can re-run the test to also get post-inference coverage using this command:
```
bash helpers/repro.sh ./results/face/ORIG/corpus tf ./results/face/ORIG/repro testFaceDetection edu.ucla.cs.FaceTest
```

## Author
[Usama Hameed}(https://github.com/usama54321), [Shuo He](https://github.com/ShuoHe97)
