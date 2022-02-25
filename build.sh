cd jqf
mvn package -DskipTests=true
mvn install -DskipTests=true
cd ..

cd dl-java-apps
mvn package -DskipTests=true
mvn install -DskipTests=true
cd ..

mvn package -DskipTests=true
mvn install -DskipTests=true
