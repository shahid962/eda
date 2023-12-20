# resource "helm_release" "grafana" {
#     repository = "https://grafana.github.io/helm-charts"
#     name       = "grafana"
#     chart      = "grafana/grafana"
#     namespace = "monitoring"
# }

resource "helm_release" "loki" {
    repository = "https://grafana.github.io/helm-charts"
    name       = "loki"
    chart      = "grafana/loki-stack"
    namespace = "monitoring"
    values = [
    "${file("./loki-values.yaml")}"
  ]
}

# resource "helm_release" "grafana-agent" {
#     repository = "https://grafana.github.io/helm-charts"
#     name       = "grafana-agent"
#     chart      = "grafana/agent"
#     namespace = "monitoring"
  
# }

# resource "helm_release" "mimir" {
#     repository = "https://grafana.github.io/helm-charts"
#     name       = "mimir"
#     chart      = "grafana/mimir"
#     namespace = "monitoring"
    
  
# }
