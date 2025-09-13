resource "aws_cloudwatch_dashboard" "emr_dashboard" {
  dashboard_name = "${var.project_name}-emr-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ElasticMapReduce", "CoreNodesRunning", "JobFlowId", var.emr_cluster_id],
            [".", "CoreNodesRequested", ".", "."],
            [".", "MasterNodesRunning", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = "EMR Cluster Nodes"
          period  = 300
        }
      }
    ]
  })
}

resource "aws_cloudwatch_metric_alarm" "emr_cluster_failed" {
  alarm_name          = "${var.project_name}-emr-cluster-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CoreNodesRunning"
  namespace           = "AWS/ElasticMapReduce"
  period              = "300"
  statistic           = "Average"
  threshold           = "0"
  alarm_description   = "This metric monitors EMR cluster health"
  treat_missing_data  = "breaching"

  dimensions = {
    JobFlowId = var.emr_cluster_id
  }
}
