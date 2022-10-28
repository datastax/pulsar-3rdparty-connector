targetroot="/Users/andreyyegorov/src/pulsar-3rdparty-connector"
for dirname in ~/src/camel-kafka-connector/connectors/*/; do
  name=$(basename $dirname)
  echo $name
  shortname=${name/-kafka-connector/}
  echo $shortname

  mkdir -p $targetroot/pulsar-connectors/$shortname
  cp -R $targetroot/pulsar-connectors/template-camel/ $targetroot/pulsar-connectors/$shortname

  grep -rli 'CAMEL-CONNECTOR-ARTIFACTID' $targetroot/pulsar-connectors/$shortname/* | xargs -I@ sed -i '' "s/CAMEL-CONNECTOR-ARTIFACTID/${shortname}/g" @

   grep -rli 'CAMEL-CONNECTOR-DEPENDENCY' $targetroot/pulsar-connectors/$shortname/* | xargs -I@ sed -i '' "s/CAMEL-CONNECTOR-DEPENDENCY/${name}/g" @

   sed -i '' '/add new connector modules here/i\'$'\n'"    <module>${shortname}</module>
   " $targetroot/pulsar-connectors/pom.xml


   sed -i '' '/add new connector modules here/i\'$'\n'"1. [${shortname}](pulsar-connectors/${shortname})
   " $targetroot/README.md
done

