variable "name-suffix" {
  type = string
  default = "projecttwobootcampwebapp"
}

variable "environments" {
  type = set(string)
  default = [ "Dev", "Staging", "Production" ]
}

variable "rg-location" {
  type = string
  default = "canadacentral"
}

variable "as-sku" {
  type = string
  default = "S1"
}