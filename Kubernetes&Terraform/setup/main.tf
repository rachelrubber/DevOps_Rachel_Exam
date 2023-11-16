provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

module "kubernetes" {
    source = "../modules/k8s"
    dep_name = "nginx-deployment"
    service_name = "nginx-service"
    namespace = "exam"
    lbl = "nginx"
    container_name = "nginx"
}