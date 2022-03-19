







select
    roll_number, name
from 
    student_information S
left join
    faculty_information f
on S.advisor = f.employee_id
where (gender = 'M' and salary>15000) OR (gender = 'F' and salary>20000)
;










select
    s.roll_number, s.name
from 
    student_information s
left join
    examination_marks e
on s.roll_number = e.roll_number
where (subject_one+subject_two+subject_three) < 100
;