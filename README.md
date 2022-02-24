# dl-apps-fuzzing
Prereq   jdk    maven

# How to build:
Simply run this command. 
```
bash build.sh
```

# How to run tests:

To get the overall test coverage, run the following command:
```
bash helpers/fuzz.sh tf testFaceDetection ./data/vggface2/ORIG $(pwd)/results/face/ORIG $(pwd)/results/instrumentation edu.ucla.cs.FaceTest
```


To get the post-inference test coverage, run the following command:
```
bash helpers/repro.sh ./results/face/ORIG/corpus tf ./results/face/ORIG/repro testFaceDetection edu.ucla.cs.FaceTest
```
