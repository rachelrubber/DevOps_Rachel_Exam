variable "namespace" {
  description = "Namespace for the deployment"
  type        = string
}

variable "nginx_image" {
  description = "Nginx Docker image to deploy"
  type        = string
  default     = "nginx:latest"
}

variable "nginx_image_version" {
  description = "Nginx Docker image version"
  type        = string
  default     = "latest"
}

variable "service_ports" {
  description = "List of service ports"
  type        = list(number)
  default     = [80]
}

variable "dep_name" {

}

variable "service_name" {

}

variable "lbl" {

}

variable "container_name" {
  
}