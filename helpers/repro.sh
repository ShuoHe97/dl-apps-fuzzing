echo "usage bash repro.sh \$input \$engine \$out \$method"

# Example
# bash helpers/repro.sh ./results/corpus tf ./results/repro testFaceDetection edu.ucla.cs.FaceTest

# $input: is the /corpus directory inside the previous test results directory

# $engine: "tf" for our customized guidance.

# $out: is the output directory for reproduced results to be stored

# $method: is the test method we want to re-run.











#rm -r $3/instrumentation

mvn -e -X jqf:repro -Dclass=$5 -DincludeOnly=edu.ucla.cs.FaceTest,edu.ucla.cs.CropTest,edu.ucla.cs.PoseTest,net.tzolov -Dinput=$1 -Dmethod=$4 -Dengine=$2  -Djanala.verbose=true -Dout=$3 -Djanala.instrumentationCacheDir="$3/instrumentation" -Djqf.tracing.TRACE_GENERATORS=true
#org/nd4j/tensorflow/conversion/graphrunner/
