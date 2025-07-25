resource "aws_lb_target_group_attachment" "web_attachment" {
  count            = length(aws_instance.Web_test)
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.Web_test[count.index].id
  port             = 80
}
