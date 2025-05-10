pipeline {
  agent any
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-id')
  }
  stages {
    stage('Checkout') {
      steps { git url: 'git@github.com:daviddvf/ProyectoLenMPro.git',branch: 'main' ,credentialsId: 'gitsshkey'}
    }
    stage('Build Docker') {
      steps {
        script {
          docker.build("daviddvf/mi_crud_app:${env.BUILD_NUMBER}")
        }
      }
    }
    stage('Push') {
      steps {
        script {
          docker.withRegistry('', 'dockerhub-id') {
            docker.image("daviddvf/mi_crud_app:${env.BUILD_NUMBER}").push()
          }
        }
      }
    }
    stage('Deploy') {
      steps {
        sh 'docker stack deploy -c docker-compose.yml mi_app'
      }
    }
  }
}
