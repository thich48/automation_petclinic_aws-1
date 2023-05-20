pipeline {
  agent any
  stages {
    stage('verify supported software') {
      steps {
        sh '''
         ls
        '''
      }
    }

    stage('Maven build') {
      steps {
        sh './scripts/run_all.sh'
        sh 'docker system prune -a --volumes -f'
      }
    }

    stage('Build docker') {
      steps {
        sh 'docker compose up -d --no-color --wait'
        sh 'docker compose ps'
      }
    }

    stage('Push docker images to DockerHub') {
      environment {
        DOCKER_PASS = credentials('DOCKER_HUB_PASS')
      }
      steps {
        sh 'docker login -u $DOCKER_ID -p $DOCKER_PASS'
        echo 'Push docker images to DockerHub : using docker compose multiple microservices'
      }
    }

    stage('Run tests against the container') {
      steps {
        echo 'Test should be applied after the deployment on the different servers'
      }
    }

    stage('Deploiement en dev') {
      environment {
        KUBECONFIG = credentials('config')
      }
      steps {
        script {
          sh '''
rm -Rf .kube
mkdir .kube
ls
cat $KUBECONFIG > ~/.kube/config
'''
        }

      }
    }

  }
  environment {
    DOCKER_ID = 'abrarhm'
    DOCKER_IMAGE = 'datascientestapi'
    DOCKER_TAG = "v.${BUILD_ID}.0" // we will tag our images with the current build in order to increment the value by 1 with each new build
  }
}
