output "all_namespaces" {
  value = kubernetes_namespace.exam[*].metadata[*].name
}

output "taxes_namespace" {
  value = kubernetes_namespace.taxes_namespace.name
}