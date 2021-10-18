variable "cloud_id" {
  description = "cloud_id from yandex"
}

variable "folder_id" {
  description = "Folder from yandex console"
}

variable "zone" {
  description = "Zone"
}

variable "image_id" {
  description = "image id that we use"
}

variable "subnet_id" {
  description = "subnet id that we use"
}

variable "public_key_path" {
  description = "public_key_path that we use"
}

variable "private_key_path" {
  description = "private_key_path that we use"
}

variable service_account_key_file {
  description = "key .json"
}

variable region_id {
  description = "region"
}

variable instances {
  description = "count instances"
  default     = 1
}
