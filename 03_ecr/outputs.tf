output "repo_arn" {
  description = "arn del repo"
  value       = aws_ecr_repository.repo.arn
}