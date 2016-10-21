module ExamsHelper
  def check_status exam
    case
    when exam.checked?
      "<span class='label label-danger'>
       #{exam.status} </span>"
    when exam.uncheck?
      "<span class='label label-info'>
      #{exam.status} </span>"
    when exam.testing?
      "<span class='label label-warning'>
      #{exam.status} </span>"
    else
      "<span class='label label-success'>
      #{exam.status} </span>"
    end.html_safe
  end
end
