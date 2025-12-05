pipeline {
    agent any
        environment {
        // Явно устанавливаем переменные окружения

        NEXUS_URL = ""http://nexus:8081""
        NEXUS_CREDENTIALS_ID = ""nexus_cred""
    }


       
    stages {
        stage('Download from Nexus') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: NEXUS_CREDENTIALS_ID, usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh "curl -u ${USER}:${PASS} -o ${APP_NAME}.jar ${NEXUS_URL}/repository/maven-releases/myapp.jar"
                    }
                }
            }
        }
        
        stage('Run Ansible') {
            steps {
                dir('deploy') {
                    git branch: 'main', url: 'https://github.com/yourusername/deploy.git'
                }
                sh 'ansible-playbook deploy/ansible/playbook.yml'
            }
        }
    }

}