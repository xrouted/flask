pipeline {
    agent any
    environment {
        image_name="652991552826.dkr.ecr.eu-central-1.amazonaws.com/flask-final"
    }
    stages {
        stage('Build') {
            steps {
              sh '''
                docker build -t "${image_name}:$GIT_COMMIT" .
              '''
            }
        }
        stage('Test') {
            steps {
              sh '''
                docker run -dit -p 5000:5000 "${image_name}:$GIT_COMMIT"
                sleep 5
                curl localhost:5000
                exit_status=$?
                if [[ $exit_status == 0 ]]
                then echo "SUCCESSFUL TESTS" && docker stop $(docker ps -a | grep python | awk '{print $1}') 
                else echo "FAILED TESTS" && docker stop $(docker ps -a | grep python | awk '{print $1}') && exit 1
                fi
               '''
            }
        }
        stage('Push') {
            steps {
               sh '''
                  docker login -u AWS https://652991552826.dkr.ecr.eu-central-1.amazonaws.com -p $(aws ecr get-login-password --region eu-central-1)
                  docker push ${image_name}:$GIT_COMMIT
                '''
            }
        }
       stage("Deploy_Prod") {
          when {
            expression {
                  env.BRANCH_NAME == "main"
                }
          }
            steps {
                sh '''
                    helm upgrade flask helm/ --atomic --wait --install --namespace prod --create-namespace --set deployment.tag=$GIT_COMMIT --set deployment.env=prod
                '''
           }
         }
       }
    }
