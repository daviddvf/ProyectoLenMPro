pipeline {
  agent any
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-id')
  }
  stages {
    stage('Checkout') {
      steps { git url: 'git@github.com:tu_usuario/mi_crud.git', branch: 'main' }
    }
    stage('Build Docker') {
      steps {
        script {
          docker.build("tu_usuario/mi_crud_app:${env.BUILD_NUMBER}")
        }
      }
    }
    stage('Push') {
      steps {
        script {
          docker.withRegistry('', 'dockerhub-id') {
            docker.image("tu_usuario/mi_crud_app:${env.BUILD_NUMBER}").push()
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
