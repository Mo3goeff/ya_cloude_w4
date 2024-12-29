resource "yandex_storage_bucket" "my_bucket" {
  bucket = "mozgoeff" # Уникальное имя бакета
  acl    = "public-read-write" # Уровень доступа
  force_destroy = true # Разрешить удаление бакета, даже если он не пуст
  # Опционально: Настройка версионирования
  versioning {
    enabled = false
  }

  # Опционально: Настройка политики бакета
#  policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Principal": "*",
#      "Action": "s3:GetObject",
#      "Resource": "arn:aws:s3:::mozgoeff/*"
#    }
#  ]
#}
#EOF
}