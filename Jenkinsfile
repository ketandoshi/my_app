pipeline {
  agent any
  stages {
    stage('Deploy') {
      steps {
        sh '''#!/bin/bash -l
            set -e
            cd /Users/ketan/workspace/ketan-test/my_app
            bundle exec cap staging deploy'''
      }
    }

  }
}