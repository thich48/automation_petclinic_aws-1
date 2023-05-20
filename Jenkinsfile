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
        
        echo 'Discovery Server - http://localhost:8761'
         sh 'curl http://localhost:8761'
        
         echo 'Config Server - http://localhost:8888'
         sh 'curl http://localhost:8888'
       
         echo 'AngularJS frontend (API Gateway) - http://localhost:8085'
         sh 'http://localhost:8085'
        
         echo 'Tracing Server (Zipkin) - http://localhost:9411/zipkin/'
         sh 'curl http://localhost:9411/zipkin/'
        
         echo 'Admin Server (Spring Boot Admin) - http://localhost:9090'
         sh 'curl http://localhost:9090'
        
         echo 'Grafana Dashboards - http://localhost:3000'
         sh 'curl http://localhost:3000'
        
         echo 'Prometheus - http://localhost:9091'
         sh 'curl http://localhost:9091'
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
    DOCKER_IMAGE = 'springcommunity'
    DOCKER_TAG = "v.${BUILD_ID}.0" // we will tag our images with the current build in order to increment the value by 1 with each new build
  }
}
