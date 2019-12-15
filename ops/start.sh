for FILE in $(find . -name '*.yml'); do
  COMMAND_MSG=$(kubectl apply -f $FILE || kubectl create -f $FILE)
  STATUS=$?

  if [[ $FILE =~ "-service.yml" ]]; then
    FILE_NAME=$(basename -- $FILE)
    SERVICE_NAME=$(echo $FILE_NAME | grep -Ei "^([a-z]+)" --only-match)

    if [ $STATUS == 0 ]; then
      SERVICE_URL=$(minikube service "$SERVICE_NAME"-service --url)
      echo $SERVICE_NAME $SERVICE_URL
    else
      echo "Service [$SERVICE_NAME] has a error"
    fi
  fi
done
