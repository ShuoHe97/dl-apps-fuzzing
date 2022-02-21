cd jqf
mvn package -DskipTests=true
mvn install -DskipTests=true
cd ..

cd dl-java-apps
mvn package -DskipTests=true
mvn install -DskipTests=true
cd ..

cd dl-fuzzing
mvn package -DskipTests=true
mvn install -DskipTests=true
cd ..
