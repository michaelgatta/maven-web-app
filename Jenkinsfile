node{
    
    
    stage("git clone"){
        git 'https://github.com/michaelgatta/maven-web-app'
    }
    
    stage("maven build"){
        def mavenHome = tool name: "maven-3.9.4" , type : "maven"
        def mavenCMD = "${mavenHome}/bin/mvn "
        sh "${mavenCMD} clean package"
    }
    
    stage("docker build"){
        
        sh "docker build -t michaelgat/mwork ."
    }
    
    
    stage("docker push"){
        withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIAL', variable: 'DOCKER_HUB_CREDENTIALS')]) {
        sh "docker login -u michaelgat -p ${DOCKER_HUB_CREDENTIALS}"    
       }
        sh "docker push michaelgat/mwork"
    }
    
    stage("deploy to k8s"){
        sh "kubectl apply -f spring-boot.yml"
    }
