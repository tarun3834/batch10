try{
    node{
        def mavenHome
        def mavenCMD
        def docker
        def dockerCMD
        def tagName = "1.4"
        
        stage('Preparation'){
            echo "Preparing the Jenkins environment with required tools by Tarun"
            mavenHome = tool name: 'maven 3', type: 'maven'
            mavenCMD = "${mavenHome}/bin/mvn"
            docker = tool name: 'docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
            //dockerCMD = "$docker/bin/docker"
        }
        
        stage('git checkout'){
            echo "Checking out the code from tarun git repository."
            git 'https://github.com/tarun3834/batch10.git'
                             }
        
        stage('Build, Test and Package'){
            echo "Building the springboot application by Tarun"
            sh "${mavenCMD} clean package"
            //sh "java -jar target/my-test-app*.jar"
                                      }
        /*stage('Sonar check'){
            echo "scanning the app"
            tool name:'maven 3',type: 'maven'
            sh 'mvn sonar:sonar -Dsonar.projectKey=sonar -Dsonar.login=admin -Dsonar.password=admin123 -Dsonar.host.url=http://35.222.13.38:9000/'
        } */           
              
        stage('Build Docker Image'){
            echo "Building docker image for springboot application."
            sh "docker build -t tarun3834/spring:${tagName} ."
            }
        stage("Push Docker Image to Docker Registry"){
            echo "Pushing image to docker hub"
            withCredentials([string(credentialsId: 'dockerPwd', variable: 'dockerHubPwd')]) {
            sh "docker login -u tarun3834 -p ${dockerHubPwd}"
            }
            sh "docker push tarun3834/spring:${tagName}"
        }
        stage('Deploy Application'){
            echo "Installing desired software.."
            echo "Bring docker service up and running"
            echo "Deploying spring application"
            ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible 2.9.22', inventory: '/etc/ansible/hosts', playbook: 'deploy-playbook.yml'
        }
          stage('Clean up'){
            echo "Cleaning up the workspace..."
            cleanWs()
        }
        stage('Email test'){
            emailext attachLog: true, body: 'Hi Tarun, This is your first pipeline  log report.', subject: 'My first jenkins pipeline', to: 'tarunvani3834@gmail.com'
        }
    }
}
catch(Exception err){
        echo "Exception occured."
        currentBuild.result="FAILURE"
}
finally{
       (currentBuild.result!= "ABORTED") && node("master") {
        echo "finally gets executed and end an email notification for every build"
        //emailext body: 'Your build has been successful or unsuccessful', subject: 'Build Result', to: 'tarunvani3834@gmail.com'
}
}
