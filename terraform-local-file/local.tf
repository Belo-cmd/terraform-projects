resource "local_file" "pet" {
  filename = "/desktop/terra_intro.txt"
  content = "hello guys, this is my first terraform file"
}