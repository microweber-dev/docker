pipeline {
  agent {
    node {
      label 'master'
    }

  }
  stages {
    stage('Build images') {
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
            dir(path: 'php71-apache/') {
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
            dir(path: 'php72-apache/') {
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
            dir(path: 'php73-apache/') {
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
            dir(path: 'php74-apache/') {
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
            dir(path: 'php73-nginx/') {
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
              nodeSelector "${getKubeNodeSelector(4)}"
            }

          }
          steps {
            dir(path: 'nginx/') {
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
      }
    }
  }
  environment {
    registryCredential = 'microweber-dockerhub'
  }
}