# dl-apps-fuzzing
This project is intended to fuzz java deep learning applications to test the effectiveness of transforming datasets on increasing branch coverage. It utilizes a modified [JQF](https://github.com/rohanpadhye/JQF) framework to feed image data to the java applications. At the moment, there is basically only a pseudo-fuzzer that directly feeds the images dataset to the test applications, without performing any mutation on-the-fly. JQF is used mainly to record branch coverage data. Different kinds of transformations are performed off-line on the origional dataset before they are feeded to the application to observe whether there is an increase on the branch coverage for the testings. 

**This repo is a reorganization with necessary bug fixes of the following three repos:**

1. [dl-fuzzing](https://github.com/usama54321/dl-fuzzing): this is the test driver.

2. [dl-java-apps](https://github.com/usama54321/dl-java-apps): this repo consists of three borrowed java deep learning applications. At the moment only the first two is functioning, the third one has a bug:
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

To get the overall test coverage, run the following command:
```
bash helpers/fuzz.sh tf testFaceDetection ./data/vggface2/ORIG $(pwd)/results/face/ORIG $(pwd)/results/instrumentation edu.ucla.cs.FaceTest
```


To get the post-inference test coverage, run the following command:
```
bash helpers/repro.sh ./results/face/ORIG/corpus tf ./results/face/ORIG/repro testFaceDetection edu.ucla.cs.FaceTest
```
