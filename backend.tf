terraform {
  backend "s3" {
    bucket       = "spacex-latest-tfs"
    key          = "terrform.tfstate"
    region       = "eu-west-2"
    profile      = "sandbox"
    use_lockfile = true
    encrypt      = true
  }
}
