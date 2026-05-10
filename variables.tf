variable "name" {
  description = "Name of security group"
  type        = string
}

variable "description" {
  description = "Descirption to assign to security group"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC to create security group in."
  type        = string
}

variable "tags" {
  description = "tags to assign security group"
  type        = map(string)
  default     = {}
}

variable "inbound_rules" {
  description = "List of inbound security rules to associate with security group"
  type        = list(map(string))
  default     = []
}

variable "outbound_rules" {
  description = "List of outbound security rules to associate with security group"
  type        = list(map(string))
  default     = []
}

variable "self_referencing" {
  description = "determines if sg should include a self referencing rule"
  type        = bool
  default = false
}
