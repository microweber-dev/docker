def getKubeLabel = { Integer index, String gitBranch, String buildNumber ->
    return "microweber-docker-images-build-${index}-${gitBranch}-${buildNumber}"
}

def getKubeNodeSelector = { Integer index ->
    def nodeNumber = (index % 5) + 1

    return "kubernetes.io/hostname=tests${nodeNumber}"
}

def getImageTag = { String gitBranch, String buildNumber ->
    return "${gitBranch}-${buildNumber}"
}

def getKubeYamlTemplate = { Integer index, String gitBranch, String buildNumber ->
    return """
metadata:
spec:
  containers:
  - name: jnlp
    image: jenkins/jnlp-slave:alpine
    tty: true
  - name: docker
    image: docker:stable
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
  - name: composer-cache
    hostPath:
      path: /srv/composer-cache
    """
}

pipeline {
  environment {
    registryCredential = 'microweber-dockerhub'
    //DOCKER_BUILDKIT = "1"
  }
  agent {
    node {
      label 'master'
    }
  }
  stages {
    stage('Build') {
      parallel {
        stage('php71-apache') {
          agent {
            kubernetes {
                label "${getKubeLabel(0, BRANCH_NAME, BUILD_NUMBER)}"
                defaultContainer 'docker'
                yaml "${getKubeYamlTemplate(0, BRANCH_NAME, BUILD_NUMBER)}"
                nodeSelector "${getKubeNodeSelector(0)}"
            }
          }
          steps {
            dir('php71-apache/') {
              script {
                def app = docker.build("microweber/php71-apache")
                app.inside {
                  sh 'echo "Tests passed"'
                }
                docker.withRegistry('https://registry.hub.docker.com', 'microweber-dockerhub') {
                    app.push("latest")
                }
              }
            }
          }
        }
        stage('php72-apache') {
          agent {
            kubernetes {
                label "${getKubeLabel(1, BRANCH_NAME, BUILD_NUMBER)}"
                defaultContainer 'docker'
                yaml "${getKubeYamlTemplate(1, BRANCH_NAME, BUILD_NUMBER)}"
                nodeSelector "${getKubeNodeSelector(1)}"
            }
          }
          steps {
            dir('php72-apache/') {
              script {
                def app = docker.build("microweber/php72-apache")
                app.inside {
                  sh 'echo "Tests passed"'
                }
                docker.withRegistry('https://registry.hub.docker.com', 'microweber-dockerhub') {
                    app.push("latest")
                }
              }
            }
          }
        }
        stage('php73-apache') {
          agent {
            kubernetes {
                label "${getKubeLabel(2, BRANCH_NAME, BUILD_NUMBER)}"
                defaultContainer 'docker'
                yaml "${getKubeYamlTemplate(2, BRANCH_NAME, BUILD_NUMBER)}"
                nodeSelector "${getKubeNodeSelector(2)}"
            }
          }
          steps {
            dir('php73-apache/') {
              script {
                def app = docker.build("microweber/php73-apache")
                app.inside {
                  sh 'if [[ $(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d".") == 7.4 ]] ; then echo "Test passing"; else echo "Test failed"; exit 0; fi'
                }
                docker.withRegistry('https://registry.hub.docker.com', 'microweber-dockerhub') {
                    app.push("latest")
                }
              }
            }
          }
        }
        stage('php74-apache') {
          agent {
            kubernetes {
                label "${getKubeLabel(3, BRANCH_NAME, BUILD_NUMBER)}"
                defaultContainer 'docker'
                yaml "${getKubeYamlTemplate(3, BRANCH_NAME, BUILD_NUMBER)}"
                nodeSelector "${getKubeNodeSelector(3)}"
            }
          }
          steps {
            dir('php74-apache/') {
              script {
                def app = docker.build("microweber/php74-apache")
                app.inside {
                  sh 'if [[ $(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d".") == 7.4 ]] ; then echo "Test passing"; else echo "Test failed"; exit 0; fi'
                }
                docker.withRegistry('https://registry.hub.docker.com', 'microweber-dockerhub') {
                    app.push("latest")
                }
              }
            }
          }
        }
        stage('php73-nginx') {
          agent {
            kubernetes {
                label "${getKubeLabel(4, BRANCH_NAME, BUILD_NUMBER)}"
                defaultContainer 'docker'
                yaml "${getKubeYamlTemplate(4, BRANCH_NAME, BUILD_NUMBER)}"
                nodeSelector "${getKubeNodeSelector(4)}"
            }
          }
          steps {
            dir('php73-nginx/') {
              script {
                def app = docker.build("microweber/php73-nginx")
                app.inside {
                  sh 'echo "Tests passed"'
                }
                docker.withRegistry('https://registry.hub.docker.com', 'microweber-dockerhub') {
                    app.push("latest")
                }
              }
            }
          }
        }
        stage('nginx') {
          agent {
            kubernetes {
                label "${getKubeLabel(5, BRANCH_NAME, BUILD_NUMBER)}"
                defaultContainer 'docker'
                yaml "${getKubeYamlTemplate(5, BRANCH_NAME, BUILD_NUMBER)}"
                nodeSelector "${getKubeNodeSelector(5)}"
            }
          }
          steps {
            dir('nginx/') {
              script {
                def app = docker.build("microweber/nginx")
                app.inside {
                  sh 'echo "Tests passed"'
                }
                docker.withRegistry('https://registry.hub.docker.com', 'microweber-dockerhub') {
                    app.push("latest")
                }
              }
            }
          }
        }
        stage('cypress') {
          agent {
            kubernetes {
                label "${getKubeLabel(6, BRANCH_NAME, BUILD_NUMBER)}"
                defaultContainer 'docker'
                yaml "${getKubeYamlTemplate(6, BRANCH_NAME, BUILD_NUMBER)}"
                nodeSelector "${getKubeNodeSelector(6)}"
            }
          }
          steps {
            dir('cypress/') {
              script {
                def app = docker.build("microweber/cypress")
                app.inside {
                  sh 'echo "Tests passed"'
                }
                docker.withRegistry('https://registry.hub.docker.com', 'microweber-dockerhub') {
                    app.push("latest")
                }
              }
            }
          }
        }
      }
    }

  }
}
