resource "kubernetes_namespace" "taxes_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    namespace = var.namespace
    name      = var.dep_name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.lbl
      }
    }

    template {
      metadata {
        labels = {
          app = var.lbl
        }
      }

      spec {
        container {
          image = "${var.nginx_image}:${var.nginx_image_version}"
          name  = "nginx"
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    namespace = var.namespace
    name      = var.service_name
  }

  spec {
    selector = {
      app = kubernetes_deployment.nginx.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = var.service_ports[0]
      target_port = var.service_ports[0]
    }
  }
}
